from flask import Flask, request, jsonify
from flask_cors import CORS
from twilio.twiml.messaging_response import MessagingResponse
from query_handler import parse_user_query
import os

app = Flask(__name__)
# This allows your test.html file to talk to this server
CORS(app) 

# --- WHATSAPP BOT ENDPOINT ---
@app.route("/whatsapp", methods=["POST"])
def whatsapp_reply():
    """
    This is the main webhook that Twilio calls
    every time a user sends a message.
    """
    # Get the incoming message
    incoming_msg = request.values.get('Body', '').strip()
    
    print(f"Incoming WhatsApp message: {incoming_msg}")

    # Get the answer from our "brain"
    bot_answer = parse_user_query(incoming_msg)
    
    print(f"Bot response: {bot_answer}")

    # Create the TwiML response to send back to WhatsApp
    resp = MessagingResponse()
    msg = resp.message()
    msg.body(bot_answer)

    return str(resp)

# --- TEST API ENDPOINT ---
@app.route("/api/chat", methods=["POST"])
def api_chat():
    """
    This is the main API endpoint that the test.html file will call.
    It expects JSON and returns JSON.
    """
    try:
        data = request.json
        if not data or 'message' not in data:
            return jsonify({"error": "No message provided"}), 400
            
        incoming_msg = data.get('message', '').strip()
        
        print(f"Incoming API message: {incoming_msg}")

        # Get the answer from our "brain"
        bot_answer = parse_user_query(incoming_msg)
        
        print(f"Bot response: {bot_answer}")

        # Send the response back as JSON
        return jsonify({"response": bot_answer})

    except Exception as e:
        print(f"Error in /api/chat: {e}")
        return jsonify({"error": "An internal server error occurred"}), 500

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 5000))
    print(f"Starting Flask server on http://localhost:{port}")
    print("WhatsApp endpoint: http://localhost:{port}/whatsapp")
    print("Test API endpoint: http://localhost:{port}/api/chat")
    app.run(debug=True, port=port) 