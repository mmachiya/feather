ingredients = []

with open("ingredients.json", "r", encoding='utf8') as file:
    ingredients = file.readlines()
ingredients = [x.strip() for x in ingredients]
ingredients.sort(key=str.lower)
with open("ingredients_sorted.txt", "w", encoding ='utf8') as file2:
    for line in ingredients:
        file2.write(line+"\n")