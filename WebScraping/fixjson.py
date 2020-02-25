import json
import unicodedata

with open("feather-142d2-export.json", "r", encoding='utf8') as file:
    data = json.load(file)

printable = {'Lu', 'Ll'}
def filter_non_printable(str):
    return "".join(c for c in str if unicodedata.category(c) in printable).strip('*').upper()


for i in range(len(data["ulta"])):
    data["ulta"][i]["ingredients"] = [x for x in list(map(filter_non_printable, data["ulta"][i]["ingredients"])) if x]
        
with open("newulta.json", "w", encoding="utf8") as f:
    json.dump(data,f, indent=4)