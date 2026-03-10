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
