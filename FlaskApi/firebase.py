import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred=credentials.Certificate("FirestoreDBNodeJsServer\serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db=firestore.client()

def question_number(usr):
    doc_ref = db.collection(u'ChatBot').document(usr)

    if not doc_ref.get().exists:
        doc_ref.set({})
        return str(1)
    else:
        # Retrieve the user's document data
        user_data = doc_ref.get().to_dict()
        print(user_data)
        # Calculate the length of the dictionary
        x = len(user_data) if user_data else 0
        return str(x+1)

# Update the document in Firestore
def firestore_user_inputting(usr,question_no,new_question):

    doc_ref = db.collection(u'Chatbot').document(usr)
    
    if not doc_ref.get().exists:
        doc_ref.set({})

    doc_ref.update({
        question_no: new_question
    })

# def firestore_clear_questions(usr):
#     # Specify the document reference for the user
#     doc_ref = db.collection('Chatbot').document(usr)

#     # Delete the document to clear all questions
#     doc_ref.delete()