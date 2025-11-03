import mysql.connector
import os
from dotenv import load_dotenv
import logging

load_dotenv()

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_NAME = os.getenv("DB_NAME")

def get_db_connection():
    """Establishes and returns a MySQL database connection."""
    try:
        conn = mysql.connector.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASSWORD,
            database=DB_NAME
        )
        logging.info("Database connection successful")
        return conn
    except mysql.connector.Error as err:
        logging.error(f"Error connecting to database: {err}")
        # Consider how your app should behave if DB connection fails.
        # Maybe return None and handle it in the calling function,
        # or raise an exception.
        return None

def fetch_data(query, params=None):
    """Fetches data from the database using the provided query and parameters."""
    conn = get_db_connection()
    if conn is None:
        return None # Indicate connection failure

    cursor = None # Initialize cursor to None
    try:
        cursor = conn.cursor(dictionary=True) # Use dictionary cursor
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)

        result = cursor.fetchall()
        logging.info(f"Executed query: {query} | Params: {params} | Rows fetched: {len(result)}")
        return result
    except mysql.connector.Error as err:
        logging.error(f"Error executing query: {err}")
        logging.error(f"Query attempted: {query}")
        logging.error(f"Parameters: {params}")
        return None # Indicate query failure
    finally:
        if cursor:
            cursor.close()
        if conn and conn.is_connected():
            conn.close()
            logging.info("Database connection closed")

# --- Example Specific Fetch Functions ---

def get_faculty_details(name_like):
    """Fetches faculty details based on a partial name match."""
    query = """
        SELECT name, department, office_location, email
        FROM faculty
        WHERE name LIKE %s
    """
    # Add wildcards for partial matching
    params = (f"%{name_like}%",)
    return fetch_data(query, params)

def get_timetable(study_year, branch, section, day=None):
    """Fetches timetable for a specific class, optionally filtered by day."""
    base_query = """
        SELECT ts.day_of_week, ts.start_time, ts.end_time, c.course_name, f.name AS faculty_name, ts.room_no, ts.location, cl.class_type, cl.lab_batch
        FROM timetable_slots ts
        JOIN classes cl ON ts.class_id = cl.class_id
        JOIN courses c ON cl.course_code = c.course_code
        LEFT JOIN faculty f ON cl.faculty_id = f.id
        WHERE cl.study_year = %s AND cl.branch = %s AND cl.section = %s
    """
    params = [study_year, branch, section]

    if day:
        base_query += " AND ts.day_of_week = %s"
        params.append(day)

    base_query += " ORDER BY FIELD(ts.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), ts.start_time"

    return fetch_data(base_query, tuple(params))

def get_all_clubs():
    """Fetches details of all clubs."""
    query = "SELECT name, description, contact_person, contact_phone FROM clubs"
    return fetch_data(query)

def get_course_details(course_code_like):
    """Fetches course details based on partial code match."""
    query = "SELECT course_code, course_name, department FROM courses WHERE course_code LIKE %s"
    params = (f"%{course_code_like}%",)
    return fetch_data(query)

def get_hod_details(department_name_like):
     """Fetches HOD details for a specific department."""
     query = """
         SELECT name, hod, contact_email
         FROM departments
         WHERE name LIKE %s
     """
     params = (f"%{department_name_like}%",)
     return fetch_data(query)

# Add more specific fetch functions as needed (e.g., get_event_details, get_hostel_info, etc.)
