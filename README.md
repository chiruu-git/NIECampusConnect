NIE Campus Connect Bot

A smart WhatsApp & Web chatbot for NIE Mysore, powered by Python, Flask, MySQL, and the Google Gemini API. This bot is designed to instantly answer student queries about timetables, faculty, campus events, and more.

Features

AI-Powered NLP: Uses the Gemini API to understand natural language queries (e.g., "who is...?", "what is the schedule for...?", "tell me about...").

Database Integration: Connects to a campus_bot5 MySQL database to fetch real-time, accurate information.

Multi-Platform:

WhatsApp: Responds to queries directly in WhatsApp via the Twilio API.

Web API: Provides a JSON API endpoint (/api/chat) for testing or integration with a web frontend.

Core Knowledge Base:

Timetables: Fetches full or day-specific timetables for any year, branch, and section.

Faculty Info: Finds faculty details, office locations, and email addresses.

Campus Life: Provides information on clubs, hostels, transport, and admissions.

General Info: Answers questions about dress code, placements, and anti-ragging policies.

Tech Stack

Backend: Python 3.9+ with Flask

Database: MySQL (connected via mysql-connector-python)

AI & NLP: Google Gemini API (google-generativeai)

WhatsApp Integration: Twilio API

Environment: python-dotenv for managing secrets

Project Structure

nie_campus_connect/
│
├── .gitignore          # Tells Git what files to ignore (e.g., venv, .env)
├── app.py              # Main Flask server (Twilio webhook + Web API)
├── db_connect.py       # Handles all MySQL database connections and queries
├── query_handler.py    # The "brain" - processes queries and calls Gemini API
├── requirements.txt    # List of all Python libraries needed
├── test_chat.html      # A simple HTML page for testing the web API
│
├── .env                # (SECRET - Not on GitHub) Contains API keys & DB password
├── env.example         # Template for the .env file
│
├── sql/                # Folder containing the database setup script
│   └── campus_bot5.sql (or similar)
│
└── venv/               # (Ignored) Python virtual environment


Setup and Installation

Follow these steps to run the project locally.

1. Prerequisites

Python 3.9+

MySQL Server (like MySQL Workbench or XAMPP)

A Twilio account (for WhatsApp)

A Google Gemini API Key

2. Clone the Repository

git clone [https://github.com/YOUR_USERNAME/nie-campus-bot.git](https://github.com/YOUR_USERNAME/nie-campus-bot.git)
cd nie-campus-bot


3. Set Up the Database

Open MySQL Workbench.

Open and run the SQL script located in the sql/ folder to create the campus_bot5 database and populate all the tables.

Ensure your MySQL server is running on localhost:3306.

4. Set Up the Python Environment

Create a virtual environment:

python3 -m venv venv


Activate the environment:

On macOS/Linux: source venv/bin/activate

On Windows: .\venv\Scripts\activate

Install the required libraries:

pip install -r requirements.txt


5. Configure Environment Variables

Create a file named .env in the root directory.

Copy the contents of env.example into your new .env file.

Fill in your actual values for:

DB_PASSWORD (e.g., Chiru123)

TWILIO_ACCOUNT_SID

TWILIO_AUTH_TOKEN

GEMINI_API_KEY

6. Run the Server

With your virtual environment still active, start the Flask server:

python3 app.py


The server should start running on http://localhost:5000.

Usage

Testing with the Web Interface

While the server is running, open the test_chat.html file in your browser.

Type queries into the chatbox (e.g., "who is CN Chinnaswamy?") to test the API and Gemini responses.

Connecting to WhatsApp (Twilio)

The Flask server runs on http://localhost:5000. This is not accessible from the internet.

You need a tunneling service like ngrok to expose your server. Download ngrok and run:

ngrok http 5000


Ngrok will give you a public "Forwarding" URL (e.g., https://random-string.ngrok-free.app).

Go to your Twilio Console -> WhatsApp Sandbox Settings.

In the "WHEN A MESSAGE COMES IN" field, paste your ngrok URL, adding the /whatsapp route at the end:
https://random-string.ngrok-free.app/whatsapp

Save the configuration. You can now send messages to your Twilio WhatsApp number and your Flask server will respond!