
from PyPDF2 import PdfReader
from langchain.text_splitter import RecursiveCharacterTextSplitter
import os
from langchain_google_genai import GoogleGenerativeAIEmbeddings
import google.generativeai as genai
from langchain.vectorstores import FAISS
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.chains.question_answering import load_qa_chain
from langchain.prompts import PromptTemplate
from configparser import ConfigParser
from firebase import firestore_user_inputting,question_number#firestore_clear_questions



config = ConfigParser()
config.read('cred.ini')
api_key = config['gemini_ai']['API_KEY']
os.environ["GOOGLE_API_KEY"] = api_key


pdf_path="data.pdf"

def get_pdf_text(pdf_docs):
    text=""
    for pdf in pdf_docs:
        pdf_reader= PdfReader(pdf)
        for page in pdf_reader.pages:
            text+= page.extract_text()
    return  text





def get_text_chunks(text):
    text_splitter = RecursiveCharacterTextSplitter(chunk_size=10000, chunk_overlap=1000)
    chunks = text_splitter.split_text(text)
    return chunks


def get_vector_store(text_chunks):
    embeddings = GoogleGenerativeAIEmbeddings(model = "models/embedding-001")
    vector_store = FAISS.from_texts(text_chunks, embedding=embeddings)
    vector_store.save_local("faiss_index")


def get_conversational_chain():
    prompt_template = """
    You are GrubAI, a friendly assistant who works for the app Grub. You must answer any questions related to the app Grub. 
    You will be provided with data which will help you to answer questions related to the app. 
    The data will be given in the format:
    Now you should only answer according to this data only.
    
    If it Tells Show stores Near me respond with all names Of store provided in data

    Also, there should be no response to any unethical prompts.

    Data:\n {context}?\n
    Question: \n{question}\n

    Answer:
    """

    model = ChatGoogleGenerativeAI(model="gemini-pro", temperature=0.3)

    # Update the input_variables to match the expected variables of your chain
    prompt = PromptTemplate(template=prompt_template, input_variables=["context", "question"])
    chain = load_qa_chain(model, chain_type="stuff", prompt=prompt)

    return chain




def user_input(user_question):
    embeddings = GoogleGenerativeAIEmbeddings(model = "models/embedding-001")
    
    new_db = FAISS.load_local("faiss_index", embeddings)
    docs = new_db.similarity_search(user_question)

    chain = get_conversational_chain()

    
    response = chain(
        {"input_documents":docs, "question": user_question}
        , return_only_outputs=True)

    return response['output_text']




def asking(usr,user_question):
    print(user_question)
    if user_question.lower() == 'exit' or user_question.lower()=='quit':
        # firestore_clear_questions(usr)
        print("Thank You For Using GrubAI.") 
    data_text = get_pdf_text(pdf_docs=[pdf_path])
    data_text_chunks = get_text_chunks(data_text)
    get_vector_store(data_text_chunks)
    x=user_input(user_question)
    j=question_number(usr)
    question_no="QA"+j
    new_question = {"Q": user_question,"A": x}
    firestore_user_inputting(usr,question_no,new_question)
    return x




# asking("User1")
