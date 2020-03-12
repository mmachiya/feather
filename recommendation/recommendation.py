import json
import sys


def recommendation_list(preference, infile, outfile) :
    
    with open(infile) as json_file:
        data = json.load(json_file)
        result = []
        for product in data:
            #need to add additional if statement for if looking for ingredients
            if preference.lower() in product['details'].lower() :
                result.append(product)

    with open(outfile, 'w', encoding="utf8") as json_file:
            json.dump(result, json_file, indent=4)

    return result

if __name__ == '__main__' :
    #testing purposes
    preference = "acne"
    infile = "ulta.json"
    outfile = "recommendation_list.json"
    recommendation_list(preference, infile, outfile)