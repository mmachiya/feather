import json
import unicodedata

with open("feather-142d2-export.json", "r", encoding='utf8') as file:
    data = json.load(file)

printable = {'Lu', 'Ll'}
def filter_non_printable(str):
    return "".join(c for c in str if unicodedata.category(c) in printable).strip('*').upper()

ndata =[]
info = {}
for i in range(len(data["ulta"])):
    info = {
        "name": data["ulta"][i]["name"],
        "category": data["ulta"][i]["category"],
        "brand": data["ulta"][i]["brand"],
        "price": data["ulta"][i]["price"],
        "details": data["ulta"][i]["details"],
        "how_to_use": data["ulta"][i]["how_to_use"],
        "ingredients":[x for x in list(map(filter_non_printable, data["ulta"][i]["ingredients"])) if x],
        "product_url": data["ulta"][i]["product_url"]
    }
    ndata.append(info)

with open("newulta2.json", "w", encoding="utf8") as f:
    json.dump(ndata,f, indent=4)