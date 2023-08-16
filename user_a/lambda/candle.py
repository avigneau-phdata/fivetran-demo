from dataclasses import dataclass, asdict

@dataclass
class Candle:

    symbol: str
    close: float
    high: float
    low: float
    open: float
    status: str
    ts: int
    volume: int

    @property
    def json(self):
        return asdict(self)
