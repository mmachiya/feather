import firebase_admin
import unicodedata
from firebase_admin import credentials
from firebase_admin import db



# Fetch the service account key JSON file contents
cred = credentials.Certificate('feather-142d2-firebase-adminsdk-5ouhg-76a45cf783.json')
# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://feather-142d2.firebaseio.com/'
})


ref = db.reference('ulta')
snapshot = ref.order_by_key().get()

printable = {'Lu', 'Ll'}
def filter_non_printable(str):
    return "".join(c for c in str if unicodedata.category(c) in printable)

ingredients = []
for val in snapshot:
    for ingredient in val["ingredients"]:
        filtered = filter_non_printable(ingredient).strip('*').upper()
        if filtered not in ingredients and len(filtered) > 0:
            ingredients.append(filtered)

with open("ingredients.json", "w", encoding='utf8') as file:
    for item in ingredients:
        file.write(item+"\n")

