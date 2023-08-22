import json
from datetime import datetime, timedelta
from pathlib import Path
from typing import List, Tuple

    
def lambda_handler(request, context):

    # Construct and send appropriate JSON response back to Fivetran
    return {
        "state": {},
        "insert": {
            "candles": [
            {"id":1, "product":"regular", "amount": 100},
            {"id":2, "product":"premium", "amount": 50},
            {"id":3, "product":"regular", "amount": 200},
            {"id":4, "product":"super", "amount": 25},
            {"id":5, "product":"regular", "amount": 125},
            {"id":6, "product":"mini", "amount": 75}
        ]},
        "hasMore" : False
    }

if __name__ == "__main__":
    print(lambda_handler("", ""))
