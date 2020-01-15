from pymongo import MongoClient
# pprint library is used to make the output look more pretty
from pprint import pprint
from random import randint
import json
# connect to MongoDB, change the << MONGODB URL >> to reflect your own connection string
client = MongoClient("mongodb+srv://kristinahtran:X3fkRffQFFVPv4YH@feather-zhckq.mongodb.net/test?retryWrites=true&w=majority"
)
db=client.Feather

with open("ulta.json", "r") as file:
    distros_dict = json.load(file)
    
for entry in distros_dict:
    result=db.Products.insert_one(entry)
    print("Created {}".format(result.inserted_id))

print("finished inserting data")

#names = ['Kitchen','Animal','State', 'Tastey', 'Big','City','Fish', 'Pizza','Goat', 'Salty','Sandwich','Lazy', 'Fun']
#company_type = ['LLC','Inc','Company','Corporation']
#company_cuisine = ['Pizza', 'Bar Food', 'Fast Food', 'Italian', 'Mexican', 'American', 'Sushi Bar', 'Vegetarian']
#for x in range(1, 501):
#    business = {
#        'name' : names[randint(0, (len(names)-1))] + ' ' + names[randint(0, (len(names)-1))]  + ' ' + company_type[randint(0, (len(company_type)-1))],
#        'rating' : randint(1, 5),
#        'cuisine' : company_cuisine[randint(0, (len(company_cuisine)-1))]
#    }
#    #Step 3: Insert business object directly into MongoDB via isnert_one
#    result=db.reviews.insert_one(business)
#    #Step 4: Print to the console the ObjectID of the new document
#    print('Created {0} of 500 as {1}'.format(x,result.inserted_id))
##Step 5: Tell us that you are done
#print('finished creating 500 business reviews')
