import mysql.connector
import os
from dotenv import load_dotenv

# Load all the variables from our .env file
load_dotenv()

def get_db_connection():
    """Establishes a connection to the MySQL database."""
    try:
        conn = mysql.connector.connect(
            host=os.environ.get('DB_HOST'),
            user=os.environ.get('DB_USER'),
            password=os.environ.get('DB_PASSWORD'),
            database=os.environ.get('DB_NAME')
        )
        # Use a dictionary cursor to get results as {column: value}
        return conn, conn.cursor(dictionary=True)
    except mysql.connector.Error as err:
        print(f"Error connecting to database: {err}")
        return None, None