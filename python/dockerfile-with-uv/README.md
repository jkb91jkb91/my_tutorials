

# 1.) Docker image with uv for .whl <<< better for PRD scenarios

First info, if you install from whl, ther is no sense to use uv << its additional tool installed in the image  
```
FROM python:3.12-slim
WORKDIR /app
COPY logger_json-0.1.0-py3-none-any.whl /tmp/
RUN pip install --no-cache-dir  /tmp/logger_json-0.1.0-py3-none-any.whl
COPY main.py /app
CMD [ "python", "main.py" ]                                                                                                                                                                                       
```
But just to show how it looks:  
```
FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir uv
COPY logger_json-0.1.0-py3-none-any.whl /tmp/
RUN uv pip install --system /tmp/logger_json-0.1.0-py3-none-any.whl
COPY main.py /app
CMD ["python", "main.py"]
```
# 2.) Docker image with uv for packages from repo directly in the docker file  

```
FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir uv
RUN uv pip install --system "git+https://github.com/jkb91jkb91/my_tutorials.git#subdirectory=logging_for_SRE/logger_json"
COPY main.py /app
CMD ["python", "main.py"]
```

# 3.) Docker image with uv for packages from repo directly placed in pyproject.toml   
Prerequisuite, package in pyproject.toml  
1) locally you have to install that package  
if you dont have uv just init

```
uv init testing-docker
```

```
uv add git+https://github.com/jkb91jkb91/my_tutorials.git#subdirectory=logging_for_SRE/logger_json
```
Check pyproject.toml if dependency is there
```
root@jkb91:~/testing_docker# cat pyproject.toml
[project]
name = "testing-docker"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.12"
dependencies = [
    "logger-json",
]
[tool.uv.sources]
logger-json = { git = "https://github.com/jkb91jkb91/my_tutorials.git", subdirectory = "logging_for_SRE/logger_json" }
```

2) Above command automatically should put this dependency into pyproject.toml
Prerequisuites: install uv in dockerimage  


The simplest Dockerfile
```
FROM python:3.12-slim
WORKDIR /app
RUN pip install --no-cache-dir uv
COPY pyproject.toml uv.lock ./

RUN uv sync --no-dev # installs only runtime dependencies from lock

COPY . .
CMD ["uv", "run", "python", "main.py"]
```


Production version  
 - different layer only for dependencies >>> --no-install-project
```
FROM python:3.12-slim

WORKDIR /app

ENV UV_LINK_MODE=copy

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock ./
RUN uv sync --no-dev --no-install-project # different layer only for dependencies

COPY . .
RUN uv sync --no-dev                      # installs only runtime dependencies from lock

CMD [".venv/bin/python", "main.py"]
```
