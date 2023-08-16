import finnhub
import json
from candle import Candle
from datetime import datetime, timedelta
from pathlib import Path
from typing import List, Tuple

HISTORICAL_START_DATE = "2023-06-01"

def get_client(api_key: str) -> finnhub.Client:
    return finnhub.Client(api_key=api_key)

def add_day(dt: str) -> str:
    date = datetime.strptime(dt, "%Y-%m-%d")
    new_date = date + timedelta(days=1)

    return new_date.strftime("%Y-%m-%d")

def last_week(dt: str) -> str:
    date = datetime.strptime(dt, "%Y-%m-%d")
    new_date = date + timedelta(days=-7)

    return new_date.strftime("%Y-%m-%d")

def dt_gte_last_week(dt: str) -> bool:
    last_week_date = last_week(datetime.now().strftime('%Y-%m-%d'))

    return dt >= last_week_date

def dt_to_unix(dt: str) -> Tuple[int, int]:
    date = datetime.strptime(dt, "%Y-%m-%d")
    start_timestamp = date.timestamp()
    end_timestamp = start_timestamp + 86400

    return int(start_timestamp), int(end_timestamp)

def eval_state(req_state: dict) -> Tuple[str, bool]:
    state = {
        "cursor": HISTORICAL_START_DATE
    }
    hasMore = True

    if req_state.get("cursor"):
        state["cursor"] = add_day(req_state.get("cursor"))
        if dt_gte_last_week(state["cursor"]):
            hasMore = False
    
    return state, hasMore

def get_candles(symbol: str, dt: str, client: finnhub.Client) -> List[dict]:
    _from, to = dt_to_unix(dt=dt)
    data = client.stock_candles(symbol=symbol, resolution="D", _from=_from, to=to)
    timestamps = data.get("t")
    candles = []

    if timestamps:
        for i in range(0, len(timestamps)):
            candles.append(
                Candle(
                    symbol=symbol,
                    close=data.get("c")[i],
                    high=data.get("h")[i],
                    low=data.get("l")[i],
                    open=data.get("o")[i],
                    status=data.get("s"),
                    ts=data.get("t")[i],
                    volume=data.get("v")[i],
                ).json
            )
    
    return candles

def get_symbols(location: str) -> List[str]:
    s = Path(location)

    if s.exists():
        return json.loads(s.read_text())
    
def lambda_handler(request, context):
    # Extract state from the Fivetran request object
    req_state = request["state"]

    # Evaluate the state object
    new_state, hasMore = eval_state(req_state=req_state)

    # Extract token from the Fivetran request object and create Finnhub client
    api_key = request["secrets"]["apiKey"]
    client = get_client(api_key=api_key)

    # Get required symbols
    symbols = get_symbols("symbols.json")
    candles = []

    # Get candles for each symbol from Finnhub API
    for symbol in symbols:
        candles.extend(get_candles(symbol=symbol, dt=new_state["cursor"], client=client))

    # Construct and send appropriate JSON response back to Fivetran
    return {
        "state": new_state,
        "insert": {
            "candles": candles
        },
        "hasMore" : hasMore
    }

if __name__ == "__main__":
    print(lambda_handler("", ""))
