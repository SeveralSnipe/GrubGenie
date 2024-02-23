import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred=credentials.Certificate("FirestoreDBNodeJsServer\serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db=firestore.client()


# Update the document in Firestore
def firestore_user_inputting(usr,question_no,new_question):

    doc_ref = db.collection(u'Chatbot').document(usr)
    
    if not doc_ref.get().exists:
        doc_ref.set({})

    doc_ref.update({
        question_no: new_question
    })

def firestore_clear_questions(usr):
    # Specify the document reference for the user
    doc_ref = db.collection('Chatbot').document(usr)

    # Delete the document to clear all questions
    doc_ref.delete()