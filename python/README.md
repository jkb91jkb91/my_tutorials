## Good practices for devops

1. Minimal Example  
2. What is module/package  
3. __init__.py  and imports


#1. Minimal Example  

```
#!/usr/bin/env python3
import sys
import argparse
import logging

log = logging.getLogger("app")

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument("--env", required=True)
    return p.parse_args()

def main() -> int:
    args = parse_args()
    log.info("start env=%s", args.env)
    # ... rest of the script
    return 0

if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(name)s: %(message)s")
    sys.exit(main())
```

#2. What is module/package  
module is one file like main.py  
package is a folder with python files  like /mytools or so mostly with __init__.py inside of it  

#3. __init__.py
-today it might be empty
-it is used to mark packet 

imports:
-prefer to use explicit imports like ( *from mytool.config import load_config* )
- avoid using from x import *

Structure example:
```
mytool/
  pyproject.toml
  README.md
  src/
    mytool/
      __init__.py
      cli.py
      config.py
      aws.py
      utils.py
  tests/
    test_smoke.py
```
