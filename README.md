Here is your project description formatted as a professional `README.md` file, ready to copy into your GitHub repository.

Writing

# NIE Campus Connect Bot 🎓

A smart **WhatsApp and Web chatbot for NIE Mysore**, powered by Python, Flask, MySQL, and the Google Gemini API. The chatbot is designed to provide instant, accurate answers to student queries about timetables, faculty information, campus events, and other college-related topics.

## ✨ Features

- **AI-Powered NLP:** Uses the Google Gemini API to understand natural language queries such as "Who is...?", "What is the schedule for...?", and "Tell me about...".
- **Database Integration:** Connects to a MySQL database (`campus_bot5`) to retrieve accurate campus information.
- **Multi-Platform Support:**
  - **WhatsApp Integration:** Responds to student queries through WhatsApp using the Twilio API.
  - **Web API:** Provides a JSON API endpoint (`/api/chat`) for testing and integration with a web frontend.
- **Timetable Information:** Retrieves complete or day-specific timetables based on year, branch, and section.
- **Faculty Information:** Provides faculty details, office locations, and email addresses.
- **Campus Life:** Answers questions about clubs, hostels, transportation, and admissions.
- **General College Information:** Provides information about dress codes, placements, and anti-ragging policies.

## 🛠️ Tech Stack

| Technology | Purpose |
| --- | --- |
| Python 3.9+ | Backend programming |
| Flask | Web server and REST API |
| MySQL | Campus information database |
| mysql-connector-python | MySQL database connectivity |
| Google Gemini API | Natural language processing and AI responses |
| Twilio API | WhatsApp messaging integration |
| python-dotenv | Environment variable management |
| HTML, CSS, JavaScript | Web-based chatbot interface |

## 📁 Project Structure

```
nie_campus_connect/
│
├── .gitignore              # Files and directories ignored by Git
├── app.py                  # Main Flask server and Twilio webhook
├── db_connect.py            # MySQL connection and database queries
├── query_handler.py         # Query processing and Gemini API integration
├── requirements.txt         # Python dependencies
├── test_chat.html           # Web interface for testing the chatbot
├── .env                     # Environment variables and secrets
├── env.example              # Example environment configuration
│
├── sql/
│   └── campus_bot5.sql      # Database setup script
│
└── venv/                    # Python virtual environment (not committed)
```

## 🚀 Setup and Installation

Follow these steps to run the NIE Campus Connect Bot locally.

### 1\. Prerequisites

Ensure the following are installed or available:

- Python 3.9 or later
- MySQL Server (MySQL Workbench or XAMPP can be used)
- Git
- A Google Gemini API key
- A Twilio account with WhatsApp Sandbox access for WhatsApp integration
- ngrok or another tunneling service for exposing the local Flask server

### 2\. Clone the Repository

Clone the project repository and navigate to the project directory.

```
git clone https://github.com/YOUR_USERNAME/nie-campus-bot.git
cd nie-campus-bot
```

Replace `YOUR_USERNAME` with the appropriate GitHub username.

### 3\. Set Up the MySQL Database

1. Start your MySQL server.
2. Open MySQL Workbench or your preferred MySQL client.
3. Open the SQL script inside the `sql/` directory.
4. Execute the script to create the `campus_bot5` database and populate the required tables.
5. Verify that the database is accessible through `localhost:3306`.

Make sure the database name, table names, and credentials match the configuration expected by `db_connect.py`.

### 4\. Create a Python Virtual Environment

Create a virtual environment in the project directory.

**macOS/Linux:**

```
python3 -m venv venv
source venv/bin/activate
```

**Windows (Command Prompt):**

```
python -m venv venv
venv\Scripts\activate
```

**Windows (PowerShell):**

```
python -m venv venv
.\venv\Scripts\Activate.ps1
```

### 5\. Install Dependencies

Install the required Python libraries.

```
pip install -r requirements.txt
```

### 6\. Configure Environment Variables

Create a `.env` file in the project's root directory and copy the configuration template from `env.example`.

**Example****`.env`****configuration:**

```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=campus_bot5
DB_USER=root
DB_PASSWORD=your_mysql_password

GEMINI_API_KEY=your_gemini_api_key

TWILIO_ACCOUNT_SID=your_twilio_account_sid
TWILIO_AUTH_TOKEN=your_twilio_auth_token
```

Replace the placeholder values with your actual credentials. Adjust the database variable names to match those used by your application.

**Security note:** Never commit your `.env` file or expose API keys, database passwords, or Twilio credentials in a public repository. Ensure `.env` is included in `.gitignore`.

### 7\. Run the Flask Server

With the virtual environment activated, start the application.

```
python app.py
```

If the application starts successfully, the Flask development server should be accessible at:

```
http://localhost:5000
```

## 💬 Usage

### Testing with the Web Interface

1. Start the Flask server.
2. Open `test_chat.html` in your web browser.
3. Enter a question in the chat interface.
4. View the response returned by the chatbot.

**Example queries:**

- Who is CN Chinnaswamy?
- What is the timetable for the third-year CSE section?
- What classes are scheduled for Monday?
- Where is a particular faculty member's office?
- Tell me about the clubs at NIE Mysore.
- What are the hostel and transportation facilities?
- What is the college dress code?
- Tell me about placement opportunities.

The accuracy of responses depends on the information available in the database and the application's query-processing logic.

### Using the Web API

The application exposes a JSON API endpoint at `/api/chat`.

The following example demonstrates how to test it using `curl`:

```
curl -X POST http://localhost:5000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Who is CN Chinnaswamy?"}'
```

The expected response format depends on the implementation of `app.py`. The request field shown above assumes the API accepts a JSON property named `message`.

### Connecting WhatsApp Using Twilio

To receive WhatsApp messages, the Flask server must be accessible over the internet. A local address such as `http://localhost:5000` cannot be accessed directly by Twilio.

#### Step 1: Start ngrok

Install ngrok and run:

```
ngrok http 5000
```

ngrok will generate a public HTTPS forwarding URL, similar to:

```
https://your-ngrok-domain.ngrok-free.app
```

Use the actual URL generated by your ngrok session.

#### Step 2: Configure the Twilio WhatsApp Sandbox

1. Sign in to the Twilio Console.
2. Open the WhatsApp Sandbox settings.
3. Find the **WHEN A MESSAGE COMES IN** webhook field.
4. Enter your ngrok URL followed by `/whatsapp`:```
   https://your-ngrok-domain.ngrok-free.app/whatsapp
   ```
5. Select the appropriate HTTP method, typically `POST`.
6. Save the configuration.

#### Step 3: Test WhatsApp Messaging

1. Follow Twilio's instructions to connect your WhatsApp account to the Sandbox.
2. Send a message to the Sandbox WhatsApp number.
3. Verify that the Flask server receives the webhook request.
4. Confirm that the bot processes the query and returns a response.

**Note:** The webhook path must match the route defined in `app.py`. Keep the Flask server and ngrok running while testing.

## 🗄️ Database Overview

The chatbot uses the MySQL database `campus_bot5` to retrieve campus-related information.

The database may contain information related to:

- Student timetables
- Faculty details and contact information
- Academic departments and sections
- Campus clubs and activities
- Hostel and transportation facilities
- Admissions and placement information
- College policies and general FAQs

The exact tables, columns, and supported queries depend on the SQL setup script and the implementation of `db_connect.py`.

## 🔐 Security Best Practices

- Store credentials in environment variables instead of hardcoding them.
- Keep `.env`, virtual environments, and other sensitive files out of version control.
- Use a dedicated MySQL user with only the permissions required by the application.
- Validate incoming API requests and handle malformed input safely.
- Verify Twilio webhook signatures before trusting incoming WhatsApp requests.
- Avoid logging API keys, passwords, or sensitive student information.
- Use appropriate error handling for database and Gemini API failures.
- Deploy production workloads using a production-ready WSGI server rather than Flask's development server.

## 🧪 Troubleshooting

| Problem | Suggested solution |
| --- | --- |
| MySQL connection failed | Verify that MySQL is running and check the database credentials in `.env`. |
| Gemini API errors | Confirm that `GEMINI_API_KEY` is valid and that the configured model is available. |
| Missing Python modules | Activate the virtual environment and run `pip install -r requirements.txt`. |
| Web API not responding | Check that Flask is running and verify the `/api/chat` route and request format. |
| WhatsApp messages receive no response | Verify the Twilio webhook URL, HTTP method, ngrok tunnel, and Flask route. |
| Database queries return no results | Check that the SQL script was imported and that the required tables contain data. |

## 🔮 Future Enhancements

- Student authentication and personalized academic information.
- Automated timetable reminders and event notifications.
- Support for additional regional languages.
- Admin dashboard for managing campus information.
- Improved query analytics and feedback collection.
- Deployment to a cloud hosting platform for continuous availability.

## 🤝 Contributing

Contributions, suggestions, and bug reports are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push the branch to your fork.
5. Open a pull request describing your changes.

## 📄 License

Add a license file to the repository if you intend to distribute this project publicly. Until a license is specified, the project's reuse and distribution terms are not explicitly defined.

---

**Developed for NIE Mysore** 🎓

_Making campus information more accessible through AI-powered conversations._
