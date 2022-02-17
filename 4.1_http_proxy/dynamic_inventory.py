import re

pattern = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
with open("dynamic_inventory.txt", "r") as r, open("hosts.txt", "w") as w:
    f = r.read()
    match_object = re.findall(pattern, f)
    for i in match_object:
        w.write(i+"\n")
