import re
import os
import json
import mysql.connector # Import mysql.connector explicitly for error handling
from db_connector import get_db_connection
import google.generativeai as genai

# --- SYSTEM INSTRUCTION ---
SYSTEM_INSTRUCTION_TEXT = f"""
    You are 'NIE Connect', the AI assistant for The National Institute of Engineering, Mysuru.
    Your goal is to answer student questions accurately using ONLY the DATABASE_DATA (JSON) provided below the question.

    **CRITICAL INSTRUCTIONS:**
    1.  **BASE YOUR ANSWER ENTIRELY ON THE PROVIDED DATABASE_DATA.** Do not use outside knowledge.
    2.  **THE DATABASE_DATA IS THE RESULT OF A SEARCH.** If the user asked about a specific person (faculty, principal, HOD), course, club, etc., and data is provided, use that data. State clearly who/what you found matching their query (e.g., "Based on your query for 'principal', I found information for Rohini Nagapadma...").
    3.  **IF DATABASE_DATA IS EMPTY (`[]`) OR NULL,** state clearly that you searched the relevant database section (e.g., faculty directory, HOD list, principal info) but couldn't find specific information matching their query. Do not invent information.
    4.  For questions about people found in the data:
        * If they are regular faculty, include full name, department, office location, and email.
        * If they are the Principal, state their name and role, and provide office/contact details found.
        * If they are an HOD, state their name, HOD role, department, and department contact email.
    5.  Answer questions about clubs, dress code, admissions, fees, placements, etc., by summarizing the relevant fields in the provided data.
    6.  For general chat (like "hello"), respond naturally and briefly as NIE Connect.
    7.  Be friendly, concise, professional, and answer in plain text (no markdown).
    8.  Location: Mysuru, Karnataka, India.
    """

# Configure the Gemini API
try:
    generation_config = {
      "temperature": 0.6, "top_p": 1, "top_k": 1, "max_output_tokens": 4096,
    }
    safety_settings = [
      { "category": "HARM_CATEGORY_HARASSMENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
      { "category": "HARM_CATEGORY_HATE_SPEECH", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
      { "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
      { "category": "HARM_CATEGORY_DANGEROUS_CONTENT", "threshold": "BLOCK_MEDIUM_AND_ABOVE" },
    ]
    genai.configure(api_key=os.environ.get("GEMINI_API_KEY"))
    # --- Use the correct model name confirmed from AI Studio ---
    model = genai.GenerativeModel(model_name="gemini-2.5-flash", # Confirmed model name
                                  generation_config=generation_config,
                                  safety_settings=safety_settings,
                                  system_instruction=SYSTEM_INSTRUCTION_TEXT 
                                 )
except Exception as e:
    print(f"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    print(f"CRITICAL Error configuring Gemini: {e}")
    print(f"Please check your GEMINI_API_KEY in the .env file and ensure the API is enabled.")
    print(f"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    model = None

# --- AI (GEMINI) CALLER FUNCTION (No changes needed) ---
def call_gemini_api(user_question, context_data_json):
    # ... (Keep the previous robust version of this function) ...
    if not model: return "The AI assistant is currently unavailable due to a configuration issue. Please contact support."
    prompt_parts = [ f"STUDENT'S QUESTION:\n{user_question}" ]
    prompt_parts.append(f"\nDATABASE_DATA (JSON):\n{context_data_json if context_data_json else '[]'}")
    print(f"\n--- Sending to Gemini ---")
    print(f"Context Data JSON: {context_data_json if context_data_json else 'None'}")
    print(f"-------------------------\n")
    try:
        response = model.generate_content(prompt_parts)
        print(f"\n--- Received from Gemini (Raw) ---")
        try:
            print(f"Response Object Candidates: {response.candidates}")
            print(f"Response Object Prompt Feedback: {response.prompt_feedback}")
        except Exception as inspect_err: print(f"Could not inspect response object details: {inspect_err}")

        result_text = ""; finish_reason_str = "Unknown"

        if response.candidates:
            first_candidate = response.candidates[0]
            if first_candidate.content and first_candidate.content.parts:
                result_text = "".join(part.text for part in first_candidate.content.parts if hasattr(part, 'text')).strip()
                print(f"Extracted Text (from parts): '{result_text}'")
            if hasattr(first_candidate, 'finish_reason'):
                 finish_reason_val = first_candidate.finish_reason
                 finish_reason_str = finish_reason_val.name if hasattr(finish_reason_val, 'name') else str(finish_reason_val).upper()
                 print(f"Finish Reason String: '{finish_reason_str}'")

        if not result_text:
             if response.prompt_feedback and response.prompt_feedback.block_reason:
                  block_reason_val = response.prompt_feedback.block_reason
                  block_reason_str = block_reason_val.name if hasattr(block_reason_val, 'name') else str(block_reason_val)
                  print(f"Prompt Block Reason: {block_reason_str}")
                  return f"My safety filters blocked the *request* itself (Reason: {block_reason_str}). Please rephrase your question."
             elif finish_reason_str != 'STOP' and finish_reason_str != 'Unknown':
                 print(f"Gemini API call potentially blocked or failed with reason: {finish_reason_str}.")
                 if finish_reason_str == 'SAFETY': return "My AI safety filters blocked the response due to potentially sensitive content. Please rephrase."
                 elif finish_reason_str == 'RECITATION': return "My AI detected potential recitation issues and blocked the response. Please ask differently."
                 elif finish_reason_str == 'MAX_TOKENS': return "The generated response was too long. Can you ask a more specific question?"
                 else: return f"My AI response was incomplete ({finish_reason_str}). Could you try asking again?"
             else:
                  print(f"Gemini API returned '{finish_reason_str}' but no usable text was extracted.")
                  return "My AI brain didn't generate a valid response. Could you ask differently?"
        elif result_text and finish_reason_str == 'STOP':
            print("Successful generation.")
            return result_text
        elif result_text:
             return result_text + f"\n(Note: AI generation finished unexpectedly: {finish_reason_str})"
        else:
             print("Unhandled response state.")
             return "I encountered an unexpected issue processing the AI response."

    except Exception as e:
        print(f"CRITICAL Error calling Gemini API: {e}")
        error_str = str(e).lower()
        # ... (error handling remains the same) ...
        if "api key not valid" in error_str or "api_key_invalid" in error_str or "permission denied" in error_str: return "AI API Key issue (invalid/permissions). Check .env and Google Cloud."
        elif "billing" in error_str: return "AI service request failed (billing issue?). Check Google Cloud billing."
        elif "quota" in error_str: return "AI service quota likely exceeded. Check Google Cloud limits."
        elif "resource exhausted" in error_str or "500" in error_str or "503" in error_str or "internal error" in error_str: return "AI service temporarily unavailable/overloaded. Try again soon."
        elif "deadline exceeded" in error_str or "timeout" in error_str: return "AI service request timed out. Try again."
        elif "models/" in error_str and "is not found" in error_str: return f"The specified AI model name is incorrect or not available for your API key. Check the model name in query_handler.py against Google AI Studio."
        return "I encountered an unexpected issue connecting to my AI brain. Please try again later."


# --- HELPER FUNCTIONS (No changes needed) ---
def format_response(data, single_template, multi_template_start, item_template, not_found_template):
    if not data: return not_found_template
    if isinstance(data, dict): return single_template.format(**data)
    return str(data)

def dump_to_json(data):
    def default_serializer(obj):
        if hasattr(obj, 'isoformat'): return obj.isoformat()
        raise TypeError(f"Object of type {obj.__class__.__name__} is not JSON serializable")
    return json.dumps(data if data else [], default=default_serializer)


# --- MAIN "BRAIN" FUNCTION (Added Principal Check) ---
def parse_user_query(user_text):
    conn, cursor = get_db_connection()
    if not conn: return "I'm having trouble connecting to my database right now. Please try again later."
    user_text_lower = user_text.lower().strip()
    response = ""
    try:
        # --- FAST PATH 1: HOD Query ---
        hod_match = re.search(r"hod of (cse|ise|ec|electronics)", user_text_lower)
        if hod_match:
            # ... (HOD fast path logic remains the same) ...
            print("Matched Intent: Get HOD (Fast Path)")
            dept_short_name = hod_match.group(1); dept_map = {'cse': 'Computer Science & Engineering', 'ise': 'Information Science & Engineering', 'ec': 'Electronics & Communication', 'electronics': 'Electronics & Communication'}; dept_full_name = dept_map.get(dept_short_name, 'Unknown')
            query = "SELECT hod FROM departments WHERE name = %s"; cursor.execute(query, (dept_full_name,)); result = cursor.fetchone()
            response = format_response(result, f"The HOD of {dept_full_name} is {{hod}}.", "", "", f"I couldn't find an HOD listed for {dept_full_name} in the database.")


        # --- FAST PATH 2: Timetable Query ---
        elif "timetable" in user_text_lower:
            # ... (Timetable fast path logic remains the same) ...
            print("Matched Intent: Get Timetable (Fast Path)")
            branch_match = re.search(r"\b(cse|ise|aiml)\b", user_text_lower); year_match = re.search(r"\b(1|2|3|4)(?:st|nd|rd|th)?\s+(?:year|sem|semester)\b|\b(first|second|third|fourth)\s+(?:year|sem|semester)\b", user_text_lower); section_match = re.search(r"\b(?:section|sec)\s+([a-h])\b", user_text_lower)
            if branch_match and year_match and section_match:
                branch = branch_match.group(1).upper(); branch = "AI&ML" if branch == "AIML" else branch; year_num_str = year_match.group(1); year_word_str = year_match.group(2)
                if year_num_str: year = int(year_num_str)
                else: year_map = {"first": 1, "second": 2, "third": 3, "fourth": 4}; year = year_map.get(year_word_str, 0)
                section = section_match.group(1).upper()
                if year == 0: response = "Could not determine the year. Please specify 1st, 2nd, 3rd, or 4th year."
                else:
                    print(f"Extracted: Year={year}, Branch={branch}, Section={section}"); query = """ SELECT ts.day_of_week, TIME_FORMAT(ts.start_time, '%h:%i %p') as start_time_f, TIME_FORMAT(ts.end_time, '%h:%i %p') as end_time_f, co.course_name, f.name as faculty_name, ts.room_no, ts.location, cl.class_type, cl.lab_batch FROM timetable_slots ts JOIN classes cl ON ts.class_id = cl.class_id JOIN courses co ON cl.course_code = co.course_code LEFT JOIN faculty f ON cl.faculty_id = f.id WHERE cl.study_year = %s AND cl.branch = %s AND cl.section = %s ORDER BY FIELD(ts.day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'), ts.start_time; """; cursor.execute(query, (year, branch, section)); results = cursor.fetchall()
                    if not results: response = f"Sorry, I couldn't find a timetable for {branch} {section} (Year {year}). Please double-check the details."
                    else:
                        days = {}; full_response = [f"Timetable for {branch} {section} (Year {year}):\n"]
                        for row in results: day = row['day_of_week']; location_info = f"{row['room_no'] or ''}{' (' + row['location'] + ')' if row['location'] else ''}".strip() or 'TBD'; lab_info = f" (Batch {row['lab_batch']})" if row['lab_batch'] else ""; class_type_info = f" ({row['class_type']})" if row['class_type'] and row['class_type'] != 'Lecture' else ""; days.setdefault(day, []).append(f"  {row['start_time_f']} - {row['end_time_f']}: {row['course_name']}{class_type_info}{lab_info} ({row['faculty_name'] or 'TBD'}) at {location_info}")
                        for day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']:
                            if day in days: full_response.append(f"\n--- {day} ---"); full_response.extend(days[day])
                        response = "\n".join(full_response)
            else:
                missing = [];
                if not branch_match: missing.append("branch (CSE, ISE, AI&ML)")
                if not year_match: missing.append("year (e.g., '1st year')")
                if not section_match: missing.append("section (e.g., 'section A')")
                response = f"Please provide Year, Branch, and Section for the timetable. Missing: {', '.join(missing)}.\nEx: 'timetable for 1st year cse section a'."


        # --- AI PATH: For everything else ---
        else:
            print(f"Matched Intent: AI Path for query: '{user_text}'")
            context_data = []
            data_source_name = "the college database"
            principal_query_handled = False # **NEW FLAG**

            # --- STEP 0: Specific Check for Principal ---
            # Check for "principal" before general faculty search
            if "principal" in user_text_lower:
                print("...Principal keyword detected. Searching faculty table for Principal role.")
                query_principal = "SELECT name, email, department, office_location FROM faculty WHERE department = 'Principal' OR name LIKE '%Principal%' LIMIT 1;" # Search by dept or name
                cursor.execute(query_principal)
                principal_result = cursor.fetchone() # Expecting only one principal
                if principal_result:
                    print("...Found Principal data in faculty table.")
                    context_data.append(principal_result)
                    data_source_name = "principal's information from faculty list"
                    principal_query_handled = True # Mark as handled
                else:
                    print("...Keyword 'principal' found, but no matching entry in faculty table.")
                    # Optionally, you could still search anti-ragging squad here as a fallback if needed

            # --- STEP 1: Check for Faculty/HOD Query Intent (IF NOT Principal Query) ---
            faculty_keywords = ["who is", "where is", "find", "office of", "contact", "email of", "professor", "prof", "dr", "mr", "mrs", "dr.", "mr.", "mrs."]
            is_faculty_query = any(user_text_lower.startswith(kw + " ") for kw in faculty_keywords) or any(f" {kw} " in user_text_lower for kw in faculty_keywords)

            # Only run this if the principal wasn't the specific target
            if not principal_query_handled and is_faculty_query:
                print("...Potential faculty/HOD query detected. Attempting name extraction and search.")
                match = re.search(r"(?:who is|where is|find|office of|contact|email of|professor|prof|dr\.?|mr\.?|mrs\.?)\s+((?:[A-Za-z]\.?\s?)+)\b\.?", user_text, re.IGNORECASE)
                if match:
                    name_query = match.group(1).strip().rstrip('.?')
                    for title in ["dr.", "mr.", "mrs.", "dr", "mr", "mrs"]:
                        if name_query.lower().startswith(title.lower() + " "): name_query = name_query[len(title)+1:].strip()
                    name_query = re.sub(r'\s+', ' ', name_query).strip()

                    if len(name_query) > 1:
                        print(f"...Normalized name query for faculty/HOD search: '{name_query}'")
                        data_source_name = "the faculty directory and HOD list"
                        # --- Faculty Search ---
                        print(f"...Searching faculty table for name like: '%{name_query}%'"); query_faculty = "SELECT name, department, office_location, email FROM faculty WHERE name LIKE %s;"; cursor.execute(query_faculty, (f"%{name_query}%",)); faculty_results = cursor.fetchall();
                        if faculty_results: context_data.extend(faculty_results)
                        # --- HOD Search ---
                        print(f"...Searching departments table for HOD name like: '%{name_query}%'"); query_hod_base = "SELECT hod as name, name as department, 'Main Department Office (HOD)' as office_location, contact_email as email, 'HOD' as role FROM departments WHERE hod LIKE %s;"; cursor.execute(query_hod_base, (f"%{name_query}%",)); hod_results = cursor.fetchall()
                        # --- Secondary HOD Search ---
                        if not hod_results and ' ' in name_query:
                            print("...Initial HOD search failed. Trying First Name + Last Initial."); name_parts = name_query.split()
                            if len(name_parts) >= 2: first_name = name_parts[0]; last_initial = name_parts[-1][0].upper(); search_pattern_initial = f"%{first_name}% {last_initial}%"; print(f"...Searching departments for HOD like: '{search_pattern_initial}'"); query_hod_initial = "SELECT hod as name, name as department, 'Main Department Office (HOD)' as office_location, contact_email as email, 'HOD' as role FROM departments WHERE hod LIKE %s;"; cursor.execute(query_hod_initial, (search_pattern_initial,)); hod_results = cursor.fetchall()
                        # Add unique HOD results
                        if hod_results:
                            print(f"...Found {len(hod_results)} potential HOD matches."); existing_names_lower = {item['name'].lower() for item in context_data}; added_hod_count = 0
                            for hod in hod_results:
                                hod_name_db = hod['name']; hod_name_normalized_lower = hod_name_db.lower()
                                for title in ["dr.", "mr.", "mrs.", "dr", "mr", "mrs"]:
                                    if hod_name_normalized_lower.startswith(title.lower() + " "): hod_name_normalized_lower = hod_name_normalized_lower[len(title)+1:].strip()
                                hod_name_normalized_lower = re.sub(r'\s+', ' ', hod_name_normalized_lower).strip()
                                if hod_name_normalized_lower not in existing_names_lower:
                                    if 'role' not in hod: hod['role'] = 'HOD';
                                    context_data.append(hod); existing_names_lower.add(hod_name_normalized_lower); added_hod_count += 1
                                else: print(f"...Skipping duplicate HOD '{hod['name']}'.")
                            if added_hod_count > 0: print(f"...Added {added_hod_count} unique HOD(s).")
                        else: print("...No HOD matches found.")
                    else: print("...Extracted name too short for faculty/HOD search.")
                else: print("...Faculty keyword found, but could not extract a plausible name after it.")

            # --- STEP 2: Check Other Keywords if NO context data was found from Step 0 or Step 1 ---
            if not context_data:
                # Reset data_source_name if prior searches failed
                if is_faculty_query or principal_query_handled: data_source_name = "the college database"

                print("...No specific person data found or query failed. Checking other general keywords.")
                if "club" in user_text_lower: print("...Fetching club data"); data_source_name="the list of clubs"; cursor.execute("SELECT name, description, contact_person, contact_phone FROM clubs"); context_data = cursor.fetchall()
                elif "dress code" in user_text_lower or "wear" in user_text_lower: print("...Fetching dress code data"); data_source_name="the dress code policy"; cursor.execute("SELECT category, type, items FROM dress_code"); context_data = cursor.fetchall()
                elif "admission" in user_text_lower or "apply" in user_text_lower or "join nie" in user_text_lower : print("...Fetching admissions data"); data_source_name="admissions information"; cursor.execute("SELECT contact_person, contact_email, contact_phone, website_link FROM admissions"); context_data = cursor.fetchall()
                # ... (rest of the elif conditions for fee, placement, hostel, etc. remain the same) ...
                elif "fee" in user_text_lower or "payment" in user_text_lower or "pay tuition" in user_text_lower: print("...Fetching fees data"); data_source_name="fees and payment information"; cursor.execute("SELECT contact_person, contact_email, contact_phone, payment_link FROM fees"); context_data = cursor.fetchall()
                elif "placement" in user_text_lower: print("...Fetching placements data"); data_source_name="placement office information"; cursor.execute("SELECT officer_name, contact_phone, contact_email, description FROM placements"); context_data = cursor.fetchall()
                elif "hostel" in user_text_lower or "stay" in user_text_lower or "accommodation" in user_text_lower or "warden" in user_text_lower: print("...Fetching hostel data"); data_source_name="hostel information"; cursor.execute("SELECT name, campus, gender, facilities, warden_name, contact_phone FROM hostels"); context_data = cursor.fetchall()
                elif "transport" in user_text_lower or "bus" in user_text_lower or "route" in user_text_lower or "shuttle" in user_text_lower: print("...Fetching transport data"); data_source_name="transport information"; cursor.execute("SELECT route_name, description, contact_person, contact_phone FROM transport"); context_data = cursor.fetchall()
                elif "ragging" in user_text_lower or "squad" in user_text_lower or "discipline" in user_text_lower: print("...Fetching anti-ragging squad data"); data_source_name="the anti-ragging squad details"; cursor.execute("SELECT name, role, department, contact_phone FROM anti_ragging_squad"); context_data = cursor.fetchall()
                elif "event" in user_text_lower or "calendar" in user_text_lower or "upcoming" in user_text_lower: print("...Fetching events data"); data_source_name="the events calendar"; cursor.execute("SELECT title, event_date, description FROM events ORDER BY event_date DESC LIMIT 10"); context_data = cursor.fetchall()
                elif "notice" in user_text_lower or "announcement" in user_text_lower or "update" in user_text_lower: print("...Fetching notices data"); data_source_name="recent notices"; cursor.execute("SELECT notice_text, posted_on FROM notices ORDER BY posted_on DESC LIMIT 5"); context_data = cursor.fetchall()
                elif "course" in user_text_lower or "subject" in user_text_lower or re.search(r"\b[A-Z0-9]{6,10}\b", user_text.upper()):
                    course_code_match = re.search(r"\b([A-Z0-9]{6,10})\b", user_text.upper())
                    if course_code_match:
                         course_code = course_code_match.group(1); print(f"...Fetching specific course data: {course_code}"); data_source_name=f"course {course_code}"; query = "SELECT course_code, course_name, department FROM courses WHERE course_code = %s"; cursor.execute(query, (course_code,)); context_data = cursor.fetchall()
                    else: print("...Fetching general course data (keyword match)"); data_source_name = "the course list"; cursor.execute("SELECT course_code, course_name, department FROM courses LIMIT 20"); context_data = cursor.fetchall()
                else: print("...No specific context keywords matched.")


            # --- STEP 3: Call Gemini ---
            print(f"--- Data Fetched for AI ---")
            print(f"Context Data Sent: {'Yes (' + str(len(context_data)) + ' entries)' if context_data else 'No'}")
            # Adjust reported source name based on what happened
            if not context_data and principal_query_handled: data_source_name = "principal's information" # If principal search failed
            elif not context_data and is_faculty_query: data_source_name = "the faculty directory and HOD list" # If faculty search failed
            elif not context_data: data_source_name = "the college database" # Generic if nothing specific matched or found
            print(f"Data Source Name Reported: {data_source_name}")
            print(f"---------------------------\n")

            modified_user_question = f"{user_text} (Data searched from {data_source_name})" if context_data else user_text
            response = call_gemini_api(modified_user_question, dump_to_json(context_data))

    except mysql.connector.Error as db_err:
        print(f"DATABASE Error in parse_user_query: {db_err}")
        response = "I'm having trouble accessing database information. Please try again later."
    except Exception as e:
        print(f"CRITICAL Error in parse_user_query: {e}")
        response = "I encountered an internal error. Please try rephrasing or contact support."
    finally:
        if cursor: cursor.close()
        if conn and conn.is_connected(): conn.close()

    return response.strip() if isinstance(response, str) else response

# --- Standalone Testing Block (Optional) ---
if __name__ == '__main__':
    test_queries = [
        "who is principal of nie",        # <-- Test case
        "where can i find dr anitha raj",
        "timetable for 3rd year ise section c",
        "tell me about clubs",
        "hod of cse",
        "contact placement office",
        "how to contact placement office",
        "placement office",
        "hello there",
        "what is the dress code"
    ]
    for test_query in test_queries:
        print(f"\n=========================\nTesting query: '{test_query}'")
        result = parse_user_query(test_query)
        print("\n--- Final Bot Response ---")
        print(result)
        print("------------------------")