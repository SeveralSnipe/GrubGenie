import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred=credentials.Certificate("FirestoreDBNodeJsServer\serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db=firestore.client()

def question_number(usr):
    doc_ref = db.collection(u'Chatbot').document(usr)
    
    if not doc_ref.get().exists:
        doc_ref.set({})

    # Retrieve the user's document data
    user_data = doc_ref.get().to_dict()

    # Check if the user_data exists and has questions
    if user_data and 'questions' in user_data:
        # Calculate the length of the list of questions
        length_of_questions = len(user_data['questions'])
        print(f"Length of questions for {usr}: {length_of_questions}")
        return length_of_questions
    else:
        print(f"No questions found for {usr}")
        return 0

# Example usage
question_number("User2")