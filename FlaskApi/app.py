
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from flask import Flask, jsonify, request
from Config import Config
from chatbot import *
import requests
import json

app = Flask(__name__)

app.config.from_object(Config)


def text_to_pdf(content, output_filename):
    c = canvas.Canvas(output_filename, pagesize=letter)
    width, height = letter
    c.setFont("Helvetica", 10)

    # Ensure content is a string
    content_str = content

    # Add newline after every 50 characters
    content_str = '\n'.join(content_str[i:i+50]
                            for i in range(0, len(content_str), 50))

    lines = content_str.split('\n')
    y = height - 50

    # Customize the formatting as needed
    line_height = 15  # Adjust as needed
    x_start = 50       # Adjust as needed

    for line in lines:
        # Check if there's enough space on the current page
        if y - line_height < 70:
            c.showPage()  # Start a new page
            y = height - 50  # Reset the y-coordinate for the new page

        c.drawString(x_start, y, line)
        y -= line_height  # Add extra space between lines if needed

    c.save()


@app.route('/calling', methods=["POST"])
def calling():

    try:
        api_url = "http://127.0.0.1:5000/CommerceNearMeRouter/AllItemsGeneral"
        longitude = request.json.get('longitude')
        latitude = request.json.get('latitude')
        usr = request.json['user']
        user_question = request.json['prompt']

        request_data = {
            "sorts": "dist",
            "location": [longitude, latitude],
            "maxDist": 100000
        }

        # Make a POST request to the API
        response = requests.post(api_url, json=request_data)
        if response.status_code == 200:
            api_response = response.json()
            # Access the result variable from the JSON response
            result_variable = api_response.get("result")
            json_data = str(result_variable)
            text_to_pdf(json_data, "data.pdf")
            finalResponse = chatbot(usr, user_question)
            return finalResponse
        else:
            # Return an error response to the client
            return jsonify({"error": f"Error: {response.status_code} - {response.text}"}), response.status_code

    except Exception as e:
        # Return an error response to the client
        return jsonify({"error": f"Error: {e}"}), 500


# @app.route('/chatbot',methods=["POST"])
def chatbot(usr, user_question):
    data = asking(usr, user_question)
    output = {"response": data}
    return jsonify(output)
