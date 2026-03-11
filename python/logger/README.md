# LOGGER ###########################################

1.) INFO  
2.) SIMPLEST LOGGER WITH CONSOLE OUTPUT ( STREAMHANDLER ) 
3.) SIMPLEST LOGGER WITH FILE OUTPUT ( FILEHANDLER )  
4.) SIMPLEST LOGGER WITH FORMATTER  
5.) WITH CUSTOM JSON FORMATTER  


1.) INFO  
What does a logger consist of ?  
Mandatory fields:  
- getLogger()
- handler  example StreamHandler >>> logs go out into console  
- setLevel() #

Optional fields:  
- custom Formatter
- many Handlers
- propagate = False
- custom Handler

2.) SIMPLEST LOGGER WITH CONSOLE OUTPUT ( STREAMHANDLER )
```
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.StreamHandler()
logger.addHandler(handler)

logger.info("Start aplikacji")
logger.error("Coś poszło nie tak")
```

3.) SIMPLEST LOGGER WITH FILE OUTPUT ( FILEHANDLER )
```
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.FileHandler("app.log")
logger.addHandler(handler)

logger.info("Start aplikacji")
logger.error("Coś poszło nie tak")
```

4.) SIMPLEST LOGGER WITH FORMATTER  
```
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

handler = logging.FileHandler("app.log", encoding="utf-8")
formatter = logging.Formatter(
    "%(asctime)s %(levelname)s [%(name)s] %(message)s"
)

handler.setFormatter(formatter)
logger.addHandler(handler)

logger.info("Start aplikacji")
logger.error("Coś poszło nie tak")

```

5.) WITH CUSTOM JSON FORMATTER  
```
import logging
import json
import sys
from datetime import datetime


class JsonFormatter(logging.Formatter):
    def format(self, record):
        payload = {
            "timestamp": datetime.utcnow().isoformat() + "Z",
            "level": record.levelname,
            "logger": record.name,
            "message": record.getMessage(),
        }

        if record.exc_info:
            payload["exception"] = self.formatException(record.exc_info)

        return json.dumps(payload)


logger = logging.getLogger("my-app")
logger.setLevel(logging.INFO)

handler = logging.StreamHandler(sys.stdout)
handler.setFormatter(JsonFormatter())

logger.addHandler(handler)
logger.propagate = False

logger.info("Start aplikacji")
logger.warning("To jest warning"
```
