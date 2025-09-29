import time
import requests
import os
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

CONFIG_PATH = "/app/targets.conf"
INTERVAL_SECONDS = 60
LOG_PATH = "/tmp/domain_status.log"

def read_domains(path):
    if not os.path.isfile(path):
        print("CONFIG FILE DOES NOT EXIST")
        exit(1)
    with open(path, "r") as f:
        return [line.strip() for line in f if line.strip()]

def check_domain(domain):
    try:
        response = requests.get(domain, verify=False, timeout=5)
        return response.status_code
    except Exception as e:
        return f"ERROR"
        
def main():
    while True:
        domains = read_domains(CONFIG_PATH)
        for domain in domains:
            status = check_domain(domain)
            log_line = f"DATADOG={domain}:{status}"
            print(log_line)
            with open(LOG_PATH, "a") as log_file:
                log_file.write(log_line + "\n")
        time.sleep(INTERVAL_SECONDS)


if __name__ == "__main__":
    main()


