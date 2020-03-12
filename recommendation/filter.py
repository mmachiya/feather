import json


def filter_list(term, category, infile, outfile) :
    #type -> [brand, category]
    with open(infile) as json_file:
        data = json.load(json_file)
        result = []
        for product in data:
            #need to add additional if statement for if looking for ingredients
            if term.lower() in product[category].lower() :
                result.append(product)

        with open(outfile, 'w', encoding="utf8") as json_file:
        	json.dump(result, json_file, indent=4)

    return result


if __name__ == '__main__' :
    #for testing purposes
    term = "ULTA"
    category = "brand"
    infile = 'ulta.json'
    outfile = "filtered_list.json"

    result = filter_list(term, category, infile, outfile)