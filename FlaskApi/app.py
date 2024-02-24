

from flask import Flask, jsonify,request
from Config import Config
from chatbot import *


app = Flask(__name__)

app.config.from_object(Config)



@app.route('/chatbot',methods=["POST"])
def chatbot():
    usr=request.json['user']
    user_question=request.json['prompt']
    data=asking(usr,user_question)
    output={"response":data}

    return jsonify(output)





