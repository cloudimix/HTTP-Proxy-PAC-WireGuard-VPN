#!/usr/bin/env python3
import re
import json

pattern = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
with open("dynamic_inventory.txt", "r") as r:
    f = r.read()
match_object = re.findall(pattern, f)
print(json.dumps({"hosts": match_object}))
