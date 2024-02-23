

from flask import Flask,request
from Config import Config
from app1 import *


app = Flask(__name__)

app.config.from_object(Config)



@app.route('/chatbot')
def chatbot():
    usr=request.form.get('user')
    asking(usr)





