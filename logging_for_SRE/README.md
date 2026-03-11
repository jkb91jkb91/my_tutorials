# BASIC INFO

# 1 Set standard logging for JSON ( policy for logging )  , NO-LOGGING WITH PLAIN-TEXT
Its SRE document that says developers  
- in what format they should log  
- what fields are mandatory  
- how to write logs for CloudWatch/Datadog/Grafana/ELK ( to be easy to parse )  


# 2 As SRE you should write library for logging and you should force developers to use it  
- This is the most clever approach  
- There is no sense to use 20 different logger formatters  
- you can base on this library: https://pypi.org/project/python-json-logger/  


# 3 How to use the logger  
- JSON format on-liner  
- timestamp in UTC  
- mandatory fields like: level, message, service, env, logger  

# Example  
```
{
  "timestamp": "2026-03-10T10:00:00Z",
  "level": "INFO",
  "message": "User logged in",
  "service": "payments",
  "request_id": "abcd-1234",
  "user_id": 441
}
```
# PRACTICAL PART: PACKAGE CREATION #######################################################

1) Download uv  
```
curl -LsSf https://astral.sh/uv/install.sh | sh
uv init --lib logger_json    # --lib means >>> create project of librarby, not application
```

```
└── logger_json
    ├── pyproject.toml
    ├── README.md
    └── src
        └── logger_json
            ├── __init__.py
            └── py.typed
```
2) Create you own file 
```
touch logger_json/src/sre_logger.py
```

```
└── logger_json
    ├── pyproject.toml
    ├── README.md
    └── src
        └── logger_json
            ├── __init__.py
            ├── py.typed
            └── sre_logger.py
```


3) Optional, how to build packages
```
cd logging_for_SRE/logger_json
uv run python -m build        # It has to fit what is in pyproject.toml like
>>> [project]
requires-python = ">=3.12"

```
4) Installation guide
```
uv init my-app    # Create Project and venv
uv venv
uv pip list       # Show locally installed packets
uv pip install "git+https://github.com/jkb91jkb91/my_tutorials.git#subdirectory=logging_for_SRE/logger_json"
```
uv pip list
```
root@jkb91:~/my_app# uv pip list
Package     Version
----------- -------
logger-json 0.1.0
```

main.py
```
from logger_json import init_json_logger
import time
def main():
    logger = init_json_logger("custom-logger")
    while True:
        time.sleep(4)
        logger.info("something")

if __name__ == "__main__":
    main()
```

uv run python main.py
```
root@jkb91:~/testing-module-app# uv run python main.py 
{"timestamp": "2026-03-11T10:24:19.738788Z", "level": "INFO", "message": "something", "logger": "custom-logger"}
{"timestamp": "2026-03-11T10:24:23.739197Z", "level": "INFO", "message": "something", "logger": "custom-logger"}
```
5) How to import this module into single python module app.py  
```

```
6) Build Dockerfile based on files from dist
```
dist
│   ├── logger_json-0.1.0-py3-none-any.whl
│   └── logger_json-0.1.0.tar.gz
```
