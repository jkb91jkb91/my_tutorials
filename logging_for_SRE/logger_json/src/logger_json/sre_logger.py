
import logging
import json
from datetime import datetime

class JsonFormatter(logging.Formatter):
    def format(self, record):
        payload = {
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "level": record.levelname,
            "message": record.getMessage(),
            "logger": record.name,
        }

        if record.__dict__.get("extra"):
            payload.update(record.__dict__["extra"])

        if record.exc_info:
            payload["exception"] = self.formatException(record.exc_info)

        return json.dumps(payload)

def init_json_logger(service_name: str = "app", level=logging.INFO):
    """
    Inicjalizuje logger JSON dla całej aplikacji.
    """
    logger = logging.getLogger(service_name)
    logger.setLevel(level)

    handler = logging.StreamHandler()
    handler.setFormatter(JsonFormatter())

    if logger.hasHandlers():
        logger.handlers.clear()

    logger.addHandler(handler)
    return logger
