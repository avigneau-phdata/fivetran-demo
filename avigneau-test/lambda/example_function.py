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
            {"id":1, "amount": 100},
            {"id":3, "amount": 50}
        ]},
        "hasMore" : False
    }

if __name__ == "__main__":
    print(lambda_handler("", ""))
