import json

def filter_out_allergy(allergy, infile):
    #filters out products that contain ALLERGY in its ingredients
    print(allergy)
    with open(infile) as json_file:
        data = json.load(json_file)
        result = []
        for product in data:
            exist = 0;
            for ingredient in product['ingredients']:
                if allergy.lower() in ingredient.lower():
                    exist = 1
                else:
                    continue
            if (exist == 0):
                result.append(product)

    return result

def filter_out_allergies(allergies, infile, outfile):
    #filters out products that contain any of the ALLERGIES
    result = filter_out_allergy(allergies[0], infile)
    with open(outfile, 'w', encoding="utf8") as json_file:
        json.dump(result, json_file, indent=4)

    #if more than one allergy, use the outfile as the input and repeat until all allergies are done
    if len(allergies) > 1:
        for x in range(1, len(allergies)):
            result = filter_out_allergy(allergies[x], outfile)
            
            with open(outfile, 'w', encoding="utf8") as json_file:
                json.dump(result, json_file, indent=4)

    return result

if __name__ == '__main__' :

    #for testing
    infile = 'ulta.json'
    outfile = 'filtered_allergies.json'
    allergies = ["ABIESSIBIRICAOIL", "ACACIACONCINNAFRUITEXTRACT", "ABIESSIBIRICAFIRNEEDLEESSENTIALOIL", "SODIUMHYROXIDE", "GLYCERIN", "VEGETABLEGLYCERIN", "ALKYBENZOATE"]
    filter_out_allergies(allergies, infile, outfile)

    #print(filtered_allergies)
    
    