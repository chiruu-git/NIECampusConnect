-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS campus_bot3;
USE campus_bot3;

-- 2. DROP ALL TABLES (in reverse order of dependency)
DROP TABLE IF EXISTS timetable_slots, classes, courses, faculty, clubs, dress_code, anti_ragging_squad, notices, events, departments, hostels, placements, admissions, fees, transport;

-- 3. CREATE TABLES
CREATE TABLE faculty (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(100) DEFAULT NULL,
    office_location VARCHAR(255) DEFAULT NULL
);

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hod VARCHAR(100),
    contact_email VARCHAR(100)
);

CREATE TABLE courses (
    course_code VARCHAR(20) PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    department VARCHAR(100)
);

CREATE TABLE classes (

    class_id INT AUTO_INCREMENT PRIMARY KEY,

    course_code VARCHAR(20),

    -- *** MODIFICATION: faculty_id must be NULL or INT NULL. We choose INT NULL. ***

    faculty_id INT NULL, 

    study_year INT NOT NULL,

    branch VARCHAR(50) NOT NULL,

    section VARCHAR(5) NOT NULL,

    class_type VARCHAR(10) NOT NULL DEFAULT 'Lecture',

    lab_batch VARCHAR(10) DEFAULT NULL,

    FOREIGN KEY (course_code) REFERENCES courses(course_code),

    FOREIGN KEY (faculty_id) REFERENCES faculty(id)

);



CREATE TABLE timetable_slots (
    slot_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    day_of_week VARCHAR(15) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    room_no VARCHAR(50),
    location VARCHAR(100),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE TABLE dress_code (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(10) NOT NULL,
    type VARCHAR(20) NOT NULL,
    items TEXT NOT NULL
);

CREATE TABLE clubs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    contact_person VARCHAR(100),
    contact_phone VARCHAR(20)
);

CREATE TABLE anti_ragging_squad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(100),
    department VARCHAR(100),
    contact_phone VARCHAR(20)
);

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    event_date DATE,
    description TEXT
);

CREATE TABLE notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    notice_text TEXT NOT NULL,
    posted_on DATE
);

CREATE TABLE hostels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    campus VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    facilities TEXT,
    warden_name VARCHAR(100) DEFAULT NULL,
    contact_phone VARCHAR(20) DEFAULT NULL
);

CREATE TABLE placements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    officer_name VARCHAR(100) NOT NULL,
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100),
    description TEXT
);

CREATE TABLE admissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contact_person VARCHAR(100) DEFAULT 'Admissions Office',
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    website_link VARCHAR(255)
);

CREATE TABLE fees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    contact_person VARCHAR(100) DEFAULT 'Accounts Section',
    contact_email VARCHAR(100),
    contact_phone VARCHAR(20),
    payment_link VARCHAR(255)
);

CREATE TABLE transport (
    id INT AUTO_INCREMENT PRIMARY KEY,
    route_name VARCHAR(150) NOT NULL,
    description TEXT,
    contact_person VARCHAR(100) DEFAULT 'Transport Officer',
    contact_phone VARCHAR(20)
);

-- 4. INSERT STATIC DATA
INSERT INTO dress_code (category, type, items) VALUES
('Boys', 'Allowed', 'Formal Pant, Jeans Pant, Shirt, T-Shirt, Kurtha'),
('Boys', 'Not Allowed', 'Low waist jeans, Torn Jeans, Cut Jeans, Faded Jeans, T-Shirt with slogans, Shorts, Sleeveless garments'),
('Girls', 'Allowed', 'Chudidhar, Jeans pant with long tops, Long Kurtha, Formal shirt'),
('Girls', 'Not Allowed', 'Low waist jeans, Torn Jeans, Cut Jeans, Faded Jeans, Shorts, Sleeveless garments, Transparent Tops, Capri, Tight fitting clothes, Skirts, Tube tops');

INSERT INTO clubs (name, description, contact_person, contact_phone) VALUES
('NISB', 'Dream of developing innovative software, managing vast databases, or leading IT projects? The Master of Computer Applications (MCA) is your path.', 'Club Coordinator', '9876500001'),
('ONYX', 'The fusion of mathematics & AI is transforming industries...', 'Club Coordinator', '9876500002'),
('Robotics', 'We encourage, motivate and equip the students in applications of robotics...', 'Club Coordinator', '9876500003'),
('AEROTantrix', 'At Aerotantrix, we are a group of students from the NIE who aim to provide a strong conceptual & practical platform for aeromodelling ventures in multidisciplinary engineering streams.', 'Club Coordinator', '9876500004'),
('AGNIE Racing', 'We design, simulate, fabricate go-karts and compete extensively in Go-kart design challenges and are intensively planning to take part in Formula Green national level competition.', 'Club Coordinator', '9876500005'),
('Credit Circle', 'The club aims to build a prominent acknowledgement of financial literacy amongst engineering students before they start their journey in financial independence.', 'Club Coordinator', '9876500006'),
('Force Ishvaku', 'We shape the future, from 5G to AI and space tech. We design the "brains" of devices, working in cutting-edge fields like semiconductors and robotics.', 'Club Coordinator', '9876500007'),
('GeeksforGeeks', 'We conduct events for all branches mainly on the computer science domain and other core technical competencies which is helpful for the students to access placements & professional development.', 'Club Coordinator', '9876500008'),
('ISSA', 'We PROVIDES EDUCATIONAL FORUMS, PUBLICATIONS, AND PEER INTERACTION OPPORTUNITIES THAT ENHANCE THE KNOWLEDGE, SKILL, AND PROFESSIONAL GROWTH OF ITS MEMBERS.', 'Club Coordinator', '9876500009'),
('Saenieks', 'Team SAENIEKS is a national level off road racing team. We design, simulate and fabricate the whole All-terrain vehicle and compete in various national level events.', 'Club Coordinator', '9876500010'),
('UCSP', 'The fusion of mathematics & AI is transforming industries, with techniques like linear algebra, calculus, & probability driving advances in machine learning, NLP, computer vision, and analytics.', 'Club Coordinator', '9876500011'),
('VLSI Club', 'A student community dedicated to acquire and develop skills in Very Large Scale Integration (VLSI) technology.', 'Club Coordinator', '9876500012');

INSERT INTO anti_ragging_squad (name, role, department, contact_phone) VALUES
('Dr. N V Archana', 'Chairperson', 'Principal', '9900112233'),
('Sri. C N Nagesh Kumar', 'Member', 'Police Inspector, Lakshmipuram', '9900112234'),
('Dr. K M Subbaiah', 'Member', 'Professor, Industrial & Production Engg.', '9900112235');

INSERT INTO events (title, event_date, description) VALUES
('Mid-Semester Exams', '2025-09-15', 'Mid-sem exams for all departments'),
('Tech Fest "TechNIEks"', '2025-09-30', 'Annual college technical festival');

INSERT INTO notices (notice_text, posted_on) VALUES
('Re-exam forms are available in the admin office.', '2025-09-01'),
('The library will be closed on weekends for maintenance.', '2025-08-28');

INSERT INTO departments (name, hod, contact_email) VALUES
('Computer Science & Engineering', 'Dr. Anitha Raj', 'csedept@nie.ac.in'),
('Information Science & Engineering', 'Dr. HP Girish', 'isedept@nie.ac.in'),
('Electronics & Communication', 'Dr. Anita Sharma', 'ecedept@nie.ac.in');

INSERT INTO hostels (name, campus, gender, facilities, warden_name, contact_phone) VALUES
('NIE North Men\'s Hostel', 'North', 'Men', 'Wi-Fi enabled, Mess facility, Reading room, Recreation room with TV, Indoor games, Solar water heaters, 24/7 security.', 'Chief Warden - North Campus (Men)', '9876511111'),
('NIE North Women\'s Hostel', 'North', 'Women', 'Wi-Fi enabled, Mess facility, Reading room, Recreation room with TV, Indoor games, Solar water heaters, 24/7 security with female guards.', 'Chief Warden - North Campus (Women)', '9876522222'),
('NIE South Men\'s Hostel', 'South', 'Men', 'Wi-Fi connectivity, Mess facility, Common room with TV, Reading materials, Outdoor/Indoor sports facilities nearby, Hot water facility, Security.', 'Chief Warden - South Campus (Men)', '9876533333'),
('NIE South Women\'s Hostel', 'South', 'Women', 'Wi-Fi connectivity, Mess facility, Common room with TV, Reading materials, Hot water facility, 24/7 security.', 'Chief Warden - South Campus (Women)', '9876544444');

INSERT INTO placements (officer_name, contact_phone, contact_email, description)
VALUES ('Harshith Divakar', '8722266622', 'placement@nie.ac.in', 'The Training and Placement (T&P) department facilitates campus placements, internships, and provides career guidance and soft-skills training to students.');

INSERT INTO admissions (contact_email, contact_phone, website_link)
VALUES ('nie_admissions@infodesk.ac.in', '0821-2480475', 'https://www.nie.ac.in/admissions/');

INSERT INTO fees (contact_email, contact_phone, payment_link)
VALUES ('nie_accounts@feesdesk.ac.in', '0821-4004900', 'https.www.nie.ac.in/online-fee-payment');

INSERT INTO transport (route_name, description, contact_phone)
VALUES 
('NIE North Campus Routes', 'The college provides bus facilities from various prominent locations in Mysore city to the North Campus. Bus passes and route details are available at the admin office.', '9123456789'),
('North Campus to South Hostel Shuttle', 'A dedicated shuttle bus service is available for North Campus students residing in the NIE South Campus Hostels. The bus runs in the morning to the North Campus and returns to the South Campus in the evening after classes.', '9123456789');

-- This statement modifies the column to allow NULLs
ALTER TABLE classes 
MODIFY COLUMN faculty_id INT NULL;

-- 5. INSERT FACULTY DATA
INSERT INTO faculty (id, name, email, department, office_location) VALUES
(1, 'Mrs Sandhya M K', 'sandhyamk@nie.ac.in', NULL, NULL),
(2, 'Dr. Chandra', 'sharath.chandra@nie.ac.in', NULL, NULL),
(3, 'Dr. Mahesh M', 'maheshm@nie.ac.in', NULL, NULL),
(4, 'Dr. Suresh Kumar S', 'sureshkumars@nie.ac.in', NULL, NULL),
(5, 'Prof. Deepak P', 'deepakp@nie.ac.in', NULL, NULL),
(6, 'Mr. Nitesh KA', 'niteshka@nie.ac.in', NULL, NULL),
(7, 'Mrs Rashmi.M', 'rashmim@nie.ac.in', NULL, NULL),
(8, 'Mr. Madhu MS', 'madhums@nie.ac.in', NULL, NULL),
(9, 'Dr. BM Sankarshan', 'sankarshanbm@nie.ac.in', NULL, NULL),
(10, 'Dr. Prithvi C', 'prithvi.mech@nie.ac.in', NULL, NULL),
(11, 'Mrs. Ashwini D S', 'ashwinids@nie.ac.in', NULL, NULL),
(12, 'Ms. Divyashree M.S', 'divyas@nie.ac.in', NULL, NULL),
(13, 'Mr. Shishirranjan', 'sr@college.edu', NULL, NULL),
(14, 'Dr Shivrajkumar', 'shivarajmacs@nie.ac.in', NULL, NULL),
(15, 'Dr. Vinaykumar D C', 'vinaykumardc@nie.ac.in', NULL, NULL),
(16, 'Prof. Nandini T S', 'nandinits.ip@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(17, 'Dr. Latha BM', 'lathabm@nie.ac.in', NULL, NULL),
(18, 'Mrs. Harshini C', 'harshinic@nie.ac.in', NULL, NULL),
(19, 'Smt. Shraddha Marathe', 'shraddhamarathe@nie.ac.in', NULL, NULL),
(20, 'Prof. Srikanth NS', 'srikanthns43@nie.ac.in', NULL, NULL),
(21, 'Prof. Sanjaya Kumar V', 'sanjayakumarv@nie.ac.in', NULL, NULL),
(22, 'Mrs Amruthashree VM', 'amruthasreevm@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(23, 'Mr Srinivas S V', 'srinivasasv@nie.ac.in', NULL, NULL),
(24, 'Mr. Karthik V', 'karthikv@nie.ac.in', NULL, NULL),
(25, 'Dr. Sathisha H M', 'sathishahm@nie.ac.in', NULL, NULL),
(26, 'Dr. T Raghavendra', 'raghu@nie.ac.in', NULL, NULL),
(27, 'Mr. Janardhana Swamy G B', 'gbjanardhanaswamy@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(28, 'Dr. Vinuth M', 'vinuthm@nie.ac.in', NULL, NULL),
(29, 'Ms. Sushma MK', 'sushmamk@nie.ac.in', NULL, NULL),
(30, 'Mrs. Chaithra M', 'chaithram@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(31, 'Mr. Santosh B K', 'santhoshbk@nie.ac.in', NULL, NULL),
(32, 'Mr. Vinesh A', 'vinesha@nie.ac.in', NULL, NULL),
(33, 'Mr Darshan NS', 'darshanns@nie.ac.in', NULL, NULL),
(34, 'Dr. Sayantan Halder', 'sayantanhalder@nie.ac.in', NULL, NULL),
(35, 'Mr Manoj S Sogi', 'manojnsogi@nie.ac.in', NULL, NULL),
(36, 'Dr Suhas BN', 'suhasbn@nie.ac.in', NULL, NULL),
(37, 'Mrs. Zaiba Farheen', 'zaibafarheen@nie.ac.in', NULL, NULL),
(38, 'Ms. Savitha S Sridharmurthy', 'savithasridharamurthy@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(39, 'Dr Bhuvan E Nalige', 'bhuvanenalige@nie.ac.in', NULL, NULL),
(40, 'Dr. G. S. Nanjundaswamy', 'nanjundaswamygs@nie.ac.in', NULL, NULL),
(41, 'Mr. Bharath G', 'bharathg@nie.ac.in', NULL, NULL),
(42, 'Dr. Snigdharani Panda', 'snigdharani@nie.ac.in', NULL, NULL),
(43, 'Ms. Lavanya K B', 'lavanyakb@nie.ac.in', NULL, NULL),
(44, 'Ms Krupa N', 'krupa@nie.ac.in', NULL, NULL),
(45, 'Mrs. Veena Mohan', 'veenamohanm@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(46, 'Mrs. Mahe Mubeen Akthar', 'mahemubeenakhtard@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(47, 'Dr. Narender M', 'narender@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(48, 'Ms. Soujanya K V', 'soujanyakv@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(49, 'Mr. Gajendra L', 'gajendral@nie.ac.in', NULL, NULL),
(50, 'Mrs. Padmavathi K', 'padmavatik@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(51, 'Mrs. Vidya NL', 'vidyanl@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(52, 'Dr. Naveen S Pagad', 'naveenspagad@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(53, 'Mr. Joyan Prajwal Alvares', 'joyanprajwalalvares@nie.ac.in', NULL, NULL),
(54, 'Mr Darshan N S', 'darshans@nie.ac.in', NULL, NULL),
(55, 'Miss Sneha S', 'snehas@nie.ac.in', NULL, NULL),
(56, 'Dr. Lokesh S', 'lokesh.sl29@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(57, 'Dr. Shabana Sultana', 'shabana@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(58, 'Mr. Sumanth CM', 'sumanthcm@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(59, 'Mrs. Priyanka R V', 'priyankarv@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(60, 'Mr. Mahesha A M', 'maheshaam@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(61, 'Dr SV Roopa', 'svrroopa@nie.ac.in', NULL, NULL),
(62, 'Mrs Lavanya.K.B', 'lavnyakb@nie.ac.in', NULL, NULL),
(63, 'Mr N S Tejas', 'tejasns@nie.ac.in', NULL, NULL),
(64, 'Mrs. Smitha B', 'smithab@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(65, 'Dr. CK Vanamala', 'ckvanamala@nie.ac.in', 'General/Other', 'Autonomous cell'),
(66, 'Mr. CN Chinnaswamy', 'chinnaswamycn@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(67, 'Ms. Meghana NR', 'meghananr@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(68, 'Ms. Prajakta M', 'prajakta@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(69, 'Dr. Bhat Geetalaxmi Jairam', 'bgj@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(70, 'Mr. Rampur Srinath', 'rampursrinath@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(71, 'Ms. Supriya S', 'supriyashivaswamy@nie.ac.in', NULL, NULL),
(72, 'Dr. Sanjith S Anchan', 'sanjithsanchan@nie.ac.in', NULL, NULL),
(73, 'Ms. Spoorthy BN', 'spoorthibn@nie.ac.in', NULL, NULL),
(74, 'Dr. BM Nandini', 'nandinibm@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(75, 'Dr. Rajeshwari D', 'drrajeshwari@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(76, 'Dr. Shashank D', 'shashank@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(77, 'Ms. Sandhya N', 'sandhyan@nie.ac.in', NULL, NULL),
(78, 'Dr. U Anil', 'unnamanil@nie.ac.in', NULL, NULL),
(79, 'Dr. K Raghuveer', 'ragh@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(80, 'Ms. Padma MT', 'padmamt@nie.ac.in', 'General/Other', 'Staff room 2 - 3rd floor lab building'),
(81, 'Dr. S Kuzhalvaimozhi', 'kuzhali_mozhi@nie.ac.in', NULL, NULL),
(82, 'Ms. Prathibha B S', 'prathibha@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(83, 'Mr. Suhas B R', 'suhasbharadwajr@nie.ac.in', NULL, NULL),
(84, 'Dr. P Devaki', 'devaki@nie.ac.in', 'General/Other', 'Staff room 1 - 1st floor lab building'),
(85, 'Dr. Suhaas KP', 'suhaaskp@nie.ac.in', 'General/Other', 'Autonomous cell'),
(86, 'Ms. Bhavani R', 'bhavanir@nie.ac.in', NULL, NULL),
(87, 'Ms. Lammiya Huda', 'lammiyahuda@nie.ac.in', NULL, NULL),
(88, 'Dr. HP Girish', 'hpgirish@nie.ac.in', NULL, NULL),
(89, 'Mr. N Rajesh', 'nrajesh@nie.ac.in', NULL, NULL),
(90, 'Ms. ShalParni PY', 'shalparnipy@nie.ac.in', NULL, NULL),
(91, 'Mrs.Poornima .N', 'poorniman@nie.ac.in', NULL, NULL),
(92, 'Mr. Nishanth R', 'nishanthr@nie.ac.in', NULL, NULL),
(93, 'Mr. Gowtham R Naik', 'gowthamr@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(94, 'Mrs.Padmini.M.S', 'padminims@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(95, 'Ms.Sumana.K.M', 'sumanakm@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(96, 'Ms.Bhagyashree Katti', 'bhagyashreekatti@nie.ac.in', NULL, NULL),
(97, 'Mr. Shashank T', 'shashankt@nie.ac.in', NULL, NULL),
(98, 'Dr. C Vidya Raj', 'cvr@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(99, 'Mrs Usha K patil', 'ushakp@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(100, 'Dr. Rashmi.M. R', 'rashmimr@nie.ac.in', NULL, NULL),
(101, 'Ms. Harshitha HS', 'harshithahs@nie.ac.in', NULL, NULL),
(102, 'Dr. Usha M S', 'ushams@nie.ac.in', NULL, NULL),
(103, 'Ms. Bhuvana S', 'bhuvanas@nie.ac.in', NULL, NULL),
(104, 'Mr. Mohamad Adnan', 'madnan@nie.ac.in', NULL, NULL),
(106, 'Dr. V K Annapurna', 'annapurnavk@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(107, 'Ms. Divyashree R', 'divyashreer@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(112, 'Mrs. Shilpashree', 'shilpashrees@nie.ac.in', NULL, NULL),
(113, 'Dr. BRV', 'brvishwanath@nie.ac.in', NULL, NULL),
(114, 'Dr. Jayasri B S', 'jayasribs@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(116, 'Dr. Anitha Raghavendra', 'anitharaghavendra@nie.ac.in', NULL, NULL),
(117, 'Mr. Balaji V', 'balajiv@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'),
(118, 'Mrs.Nithya M R', 'nithyamr@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab');
-- 6. INSERT COURSES DATA
INSERT INTO courses (course_code, course_name, department) VALUES
('1BMACS101', 'Applied Mathematics - I for CSE Stream', 'Mathematics'), ('1BPHCS102', 'Applied Physics for CSE Stream', 'Physics'), ('1BCEDCS103', 'Computer-Aided Engineering Drawing for CSE stream', 'CSE'), ('1BESC104C', 'Introduction to Electronics & Communication Engineering', 'ECE'), ('1BEIT105', 'Programming in C', 'CSE'), ('1BPOPL107', 'C Programming Lab', 'CSE'), ('1BPHCSL102', 'Applied Physics Laboratory for CSE Stream', 'Physics'), ('1BKSK109', 'Samskrutika Kannada', 'Humanities'), ('1BKBK109', 'Balake Kannada', 'Humanities'), ('1BPRJ158', 'Interdisciplinary Project Based Learning', 'General'), ('1BCHCS102', 'Applied Chemistry for CSE Stream', 'Chemistry'), ('1BAIA103', 'Introduction to AI and Applications', 'CSE'), ('1BESC104D', 'Introduction to Mechanical Engineering', 'Mechanical'), ('1BENGL106', 'Communication Skills', 'Humanities'), ('1BCHCSL102', 'Applied Chemistry Lab for CSE Stream', 'Chemistry'), ('1BIDTL158', 'Innovation and Design Thinking Lab', 'General'), ('1BICO107', 'Indian Constitution & Engineering Ethics', 'Humanities'),
('BCS301', 'Mathematics for Computer Science', 'Mathematics'), ('BCS302', 'Digital Design & Computer Organization', 'CSE'), ('BCS303', 'Operating Systems', 'CSE'), ('BCS304', 'Data Structures and Applications', 'CSE'), ('BCSL305', 'Data Structures Laboratory', 'CSE'), ('BCS306A', 'ESC Object Oriented Programming with Java', 'CSE'), ('BSCK307', 'Social Connect and Responsibility', 'Humanities'), ('BCS358D', 'AEC Data visualization with Python', 'CSE'), ('BNSK359', 'National Service Scheme (NSS)', 'General'), ('BPEK359', 'Physical Education (PE) (Sports & Athletics)', 'General'), ('BYOK359', 'Yoga', 'General'),
('BIS501', 'Software Engineering & Project Management', 'ISE'), ('BIS502', 'Computer Networks', 'ISE'), ('BIS503', 'Theory of Computation', 'ISE'), ('BIS505', 'Cloud Computing', 'ISE'), ('BIS516B', 'Artificial Intelligence', 'ISE'), ('BIS516C', 'Distributed Systems', 'ISE'), ('BIS516D', 'Unix System Programming', 'ISE'), ('BRMIS557', 'Research Methodology and IPR', 'ISE'), ('BISL504', 'Data Visualization Lab', 'ISE'), ('BIS586', 'Minor Project', 'ISE'), ('BESK508', 'Environmental Studies', 'General'), ('BNSK559', 'National Service Scheme (NSS)', 'General'), ('BPEK559', 'Physical Education (PE)', 'General'), ('BYOK559', 'Yoga', 'General'),
('BCS501', 'Software Engineering & Project Management', 'CSE'), ('BCS502', 'Computer Networks', 'CSE'), ('BCS503', 'Automata Theory and Computation', 'CSE'), ('BCSL504', 'Full Stack Development Lab', 'CSE'), ('BCS505', 'Full Stack Development', 'CSE'), ('BCS516B', 'Artificial Intelligence', 'CSE'), ('BCS586', 'Minor Project', 'CSE'), ('BRMCS557', 'Research Methodology and IPR', 'CSE'),
('BCI516B', 'Information Retrieval', 'CSE'), ('BCI586', 'Minor Project', 'CSE'), ('BCS701', 'Cryptography & Network Security', 'CSE'), ('BCS702', 'Parallel Computing', 'CSE'), ('BCS713X', 'Professional Elective Course (Group III)', 'CSE'), ('BCS713A', 'Deep Learning', 'CSE'), ('BCS713C', 'NoSQL', 'CSE'), ('BCI713D', 'Big Data Analytics', 'CSE'), ('BCS754X', 'Open Elective Course (Group II)', 'General'), ('BCS785', 'Major Project', 'CSE'), ('BCS786', 'Major Project', 'CSE'), ('BCI701', 'Natural Language Processing', 'CSE'), ('BCI702', 'Machine Learning - II', 'CSE'), ('BCI713X', 'Professional Elective Course (AI&ML)', 'CSE'), ('BCI785', 'Major Project', 'CSE');

-- 7. INSERT CLASSES DATA (All 22 Sections)
INSERT INTO faculty (id, name, email, department, office_location) VALUES
-- Missing ID 105
(105, 'Dr. Rajeshwari K', 'rajeshwari.k@nie.ac.in', 'General/Other', 'Admin Block, Ground Floor'),
-- Missing ID 108
(108, 'Prof. Vinod S', 'vinods.prof@nie.ac.in', 'ECE', 'ECE Staff Room 2'),
-- Missing ID 109
(109, 'Mrs. Lakshmi Devi', 'lakshmi.d@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
-- Missing ID 110
(110, 'Mr. Chethan M', 'chethan.m@nie.ac.in', 'Information Science & Engineering', 'ISE Lab Annex'),
-- Missing ID 111
(111, 'Dr. Ayesha Begum', 'ayesha.b@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
-- Missing ID 115
(115, 'Prof. Sanjana R', 'sanjana.r@nie.ac.in', 'Electronics & Communication', 'EC HOD Chamber Annex');

INSERT INTO faculty (id, name, email, department, office_location) VALUES
(105, 'Dr. Aruna R', 'aruna.r@nie.ac.in', 'CSE', 'Cse staff room 2 - 2nd floor lab building'), -- Referenced by class_id 410
(108, 'Dr. Vinod S', 'vinods.prof@nie.ac.in', 'ECE', 'ECE Staff Room 2'),
(109, 'Mrs. Lakshmi Devi', 'lakshmi.d@nie.ac.in', 'CSE', 'Cse- staff room, 2nd floor lab'),
(110, 'Mr. Chethan M', 'chethan.m@nie.ac.in', 'Information Science & Engineering', 'ISE Lab Annex'),
(111, 'Dr. Ayesha Begum', 'ayesha.b@nie.ac.in', 'CSE', 'Staff room 1- 1st floor lab building. Cse'),
(115, 'Dr. S. K. Singh', 'sksingh@nie.ac.in', 'CSE', 'Cse staff room 1 - 2nd floor lab building'); -- Referenced by class_ids 478, 482, 491
INSERT INTO classes (class_id, course_code, faculty_id, study_year, branch, section, class_type, lab_batch) VALUES
(1, '1BMACS101', 1, 1, 'CSE', 'A', 'Lecture', NULL), (2, '1BPHCS102', 2, 1, 'CSE', 'A', 'Lecture', NULL), (3, '1BCEDCS103', 3, 1, 'CSE', 'A', 'Lab', NULL), (4, '1BESC104C', 6, 1, 'CSE', 'A', 'Lecture', NULL), (5, '1BEIT105', 7, 1, 'CSE', 'A', 'Lecture', NULL), (6, '1BPOPL107', 7, 1, 'CSE', 'A', 'Lab', 'A1'), (7, '1BPOPL107', 7, 1, 'CSE', 'A', 'Lab', 'A2'), (8, '1BPHCSL102', 2, 1, 'CSE', 'A', 'Lab', 'A1'), (9, '1BPHCSL102', 2, 1, 'CSE', 'A', 'Lab', 'A2'), (10, '1BKSK109', 8, 1, 'CSE', 'A', 'Lecture', NULL), (11, '1BKBK109', 8, 1, 'CSE', 'A', 'Lecture', NULL), (12, '1BPRJ158', NULL, 1, 'CSE', 'A', 'Lab', NULL),
(13, '1BMACS101', 1, 1, 'CSE', 'B', 'Lecture', NULL), (14, '1BPHCS102', 9, 1, 'CSE', 'B', 'Lecture', NULL), (15, '1BCEDCS103', 10, 1, 'CSE', 'B', 'Lab', NULL), (16, '1BESC104C', 11, 1, 'CSE', 'B', 'Lecture', NULL), (17, '1BEIT105', 12, 1, 'CSE', 'B', 'Lecture', NULL), (18, '1BPOPL107', 12, 1, 'CSE', 'B', 'Lab', 'B1'), (19, '1BPOPL107', 12, 1, 'CSE', 'B', 'Lab', 'B2'), (20, '1BPHCSL102', 9, 1, 'CSE', 'B', 'Lab', 'B1'), (21, '1BPHCSL102', 9, 1, 'CSE', 'B', 'Lab', 'B2'), (22, '1BKSK109', 13, 1, 'CSE', 'B', 'Lecture', NULL), (23, '1BKBK109', 13, 1, 'CSE', 'B', 'Lecture', NULL), (24, '1BPRJ158', NULL, 1, 'CSE', 'B', 'Lab', NULL),
(25, '1BMACS101', 14, 1, 'CSE', 'C', 'Lecture', NULL), (26, '1BPHCS102', 15, 1, 'CSE', 'C', 'Lecture', NULL), (27, '1BCEDCS103', 10, 1, 'CSE', 'C', 'Lab', NULL), (28, '1BESC104C', 11, 1, 'CSE', 'C', 'Lecture', NULL), (29, '1BEIT105', 18, 1, 'CSE', 'C', 'Lecture', NULL), (30, '1BPOPL107', 18, 1, 'CSE', 'C', 'Lab', 'C1'), (31, '1BPOPL107', 18, 1, 'CSE', 'C', 'Lab', 'C2'), (32, '1BPHCSL102', 15, 1, 'CSE', 'C', 'Lab', 'C1'), (33, '1BPHCSL102', 15, 1, 'CSE', 'C', 'Lab', 'C2'), (34, '1BKSK109', 8, 1, 'CSE', 'C', 'Lecture', NULL), (35, '1BKBK109', 8, 1, 'CSE', 'C', 'Lecture', NULL), (36, '1BPRJ158', NULL, 1, 'CSE', 'C', 'Lab', NULL),
(37, '1BMACS101', 1, 1, 'CSE', 'D', 'Lecture', NULL), (38, '1BPHCS102', 19, 1, 'CSE', 'D', 'Lecture', NULL), (39, '1BCEDCS103', 20, 1, 'CSE', 'D', 'Lab', NULL), (40, '1BESC104C', 6, 1, 'CSE', 'D', 'Lecture', NULL), (41, '1BEIT105', 22, 1, 'CSE', 'D', 'Lecture', NULL), (42, '1BPOPL107', 22, 1, 'CSE', 'D', 'Lab', 'D1'), (43, '1BPOPL107', 22, 1, 'CSE', 'D', 'Lab', 'D2'), (44, '1BPHCSL102', 19, 1, 'CSE', 'D', 'Lab', 'D1'), (45, '1BPHCSL102', 19, 1, 'CSE', 'D', 'Lab', 'D2'), (46, '1BKSK109', 8, 1, 'CSE', 'D', 'Lecture', NULL), (47, '1BKBK109', 8, 1, 'CSE', 'D', 'Lecture', NULL), (48, '1BPRJ158', NULL, 1, 'CSE', 'D', 'Lab', NULL),
(49, '1BMACS101', 23, 1, 'CSE', 'E', 'Lecture', NULL), (50, '1BPHCS102', 24, 1, 'CSE', 'E', 'Lecture', NULL), (51, '1BCEDCS103', 25, 1, 'CSE', 'E', 'Lab', NULL), (52, '1BESC104C', 11, 1, 'CSE', 'E', 'Lecture', NULL), (53, '1BEIT105', 27, 1, 'CSE', 'E', 'Lecture', NULL), (54, '1BPOPL107', 27, 1, 'CSE', 'E', 'Lab', 'E1'), (55, '1BPOPL107', 27, 1, 'CSE', 'E', 'Lab', 'E2'), (56, '1BPHCSL102', 24, 1, 'CSE', 'E', 'Lab', 'E1'), (57, '1BPHCSL102', 24, 1, 'CSE', 'E', 'Lab', 'E2'), (58, '1BKSK109', 8, 1, 'CSE', 'E', 'Lecture', NULL), (59, '1BKBK109', 8, 1, 'CSE', 'E', 'Lecture', NULL), (60, '1BPRJ158', NULL, 1, 'CSE', 'E', 'Lab', NULL),
(61, '1BMACS101', 23, 1, 'CSE', 'F', 'Lecture', NULL), (62, '1BCHCS102', 28, 1, 'CSE', 'F', 'Lecture', NULL), (63, '1BAIA103', 29, 1, 'CSE', 'F', 'Lecture', NULL), (64, '1BESC104D', 10, 1, 'CSE', 'F', 'Lecture', NULL), (65, '1BEIT105', 30, 1, 'CSE', 'F', 'Lecture', NULL), (66, '1BENGL106', 31, 1, 'CSE', 'F', 'Lecture', NULL), (67, '1BPOPL107', 30, 1, 'CSE', 'F', 'Lab', 'F1'), (68, '1BPOPL107', 30, 1, 'CSE', 'F', 'Lab', 'F2'), (69, '1BCHCSL102', 28, 1, 'CSE', 'F', 'Lab', 'F1'), (70, '1BCHCSL102', 28, 1, 'CSE', 'F', 'Lab', 'F2'), (71, '1BIDTL158', 5, 1, 'CSE', 'F', 'Lab', NULL), (72, '1BICO107', 32, 1, 'CSE', 'F', 'Lecture', NULL),
(73, '1BMACS101', 33, 1, 'CSE', 'G', 'Lecture', NULL), (74, '1BCHCS102', 34, 1, 'CSE', 'G', 'Lecture', NULL), (75, '1BAIA103', 18, 1, 'CSE', 'G', 'Lecture', NULL), (76, '1BESC104D', 3, 1, 'CSE', 'G', 'Lecture', NULL), (77, '1BEIT105', 35, 1, 'CSE', 'G', 'Lecture', NULL), (78, '1BENGL106', 31, 1, 'CSE', 'G', 'Lecture', NULL), (79, '1BPOPL107', 35, 1, 'CSE', 'G', 'Lab', 'G1'), (80, '1BPOPL107', 35, 1, 'CSE', 'G', 'Lab', 'G2'), (81, '1BCHCSL102', 34, 1, 'CSE', 'G', 'Lab', 'G1'), (82, '1BCHCSL102', 34, 1, 'CSE', 'G', 'Lab', 'G2'), (83, '1BIDTL158', 3, 1, 'CSE', 'G', 'Lab', NULL), (84, '1BICO107', 32, 1, 'CSE', 'G', 'Lecture', NULL),
(85, '1BMACS101', 36, 1, 'CSE', 'H', 'Lecture', NULL), (86, '1BCHCS102', 28, 1, 'CSE', 'H', 'Lecture', NULL), (87, '1BAIA103', 37, 1, 'CSE', 'H', 'Lecture', NULL), (88, '1BESC104D', 4, 1, 'CSE', 'H', 'Lecture', NULL), (89, '1BEIT105', 38, 1, 'CSE', 'H', 'Lecture', NULL), (90, '1BENGL106', 31, 1, 'CSE', 'H', 'Lecture', NULL), (91, '1BPOPL107', 38, 1, 'CSE', 'H', 'Lab', 'H1'), (92, '1BPOPL107', 38, 1, 'CSE', 'H', 'Lab', 'H2'), (93, '1BCHCSL102', 28, 1, 'CSE', 'H', 'Lab', 'H1'), (94, '1BCHCSL102', 28, 1, 'CSE', 'H', 'Lab', 'H2'), (95, '1BIDTL158', 17, 1, 'CSE', 'H', 'Lab', NULL), (96, '1BICO107', 32, 1, 'CSE', 'H', 'Lecture', NULL),
(97, '1BMACS101', 39, 1, 'AI&ML', 'A', 'Lecture', NULL), (98, '1BCHCS102', 40, 1, 'AI&ML', 'A', 'Lecture', NULL), (99, '1BAIA103', 41, 1, 'AI&ML', 'A', 'Lecture', NULL), (100, '1BESC104D', 5, 1, 'AI&ML', 'A', 'Lecture', NULL), (101, '1BEIT105', 30, 1, 'AI&ML', 'A', 'Lecture', NULL), (102, '1BENGL106', 31, 1, 'AI&ML', 'A', 'Lecture', NULL), (103, '1BPOPL107', 30, 1, 'AI&ML', 'A', 'Lab', 'A1'), (104, '1BPOPL107', 30, 1, 'AI&ML', 'A', 'Lab', 'A2'), (105, '1BCHCSL102', 40, 1, 'AI&ML', 'A', 'Lab', 'A1'), (106, '1BCHCSL102', 40, 1, 'AI&ML', 'A', 'Lab', 'A2'), (107, '1BIDTL158', 3, 1, 'AI&ML', 'A', 'Lab', NULL), (108, '1BICO107', 32, 1, 'AI&ML', 'A', 'Lecture', NULL),
(109, '1BMACS101', 23, 1, 'AI&ML', 'B', 'Lecture', NULL), (110, '1BCHCS102', 42, 1, 'AI&ML', 'B', 'Lecture', NULL), (111, '1BAIA103', 43, 1, 'AI&ML', 'B', 'Lecture', NULL), (112, '1BESC104D', 21, 1, 'AI&ML', 'B', 'Lecture', NULL), (113, '1BEIT105', 7, 1, 'AI&ML', 'B', 'Lecture', NULL), (114, '1BENGL106', 31, 1, 'AI&ML', 'B', 'Lecture', NULL), (115, '1BPOPL107', 7, 1, 'AI&ML', 'B', 'Lab', 'B1'), (116, '1BPOPL107', 7, 1, 'AI&ML', 'B', 'Lab', 'B2'), (117, '1BCHCSL102', 42, 1, 'AI&ML', 'B', 'Lab', 'B1'), (118, '1BCHCSL102', 42, 1, 'AI&ML', 'B', 'Lab', 'B2'), (119, '1BIDTL158', 4, 1, 'AI&ML', 'B', 'Lab', NULL), (120, '1BICO107', 32, 1, 'AI&ML', 'B', 'Lecture', NULL),
(121, 'BCS301', 44, 2, 'CSE', 'A', 'Lecture', NULL), (122, 'BCS302', 45, 2, 'CSE', 'A', 'Lecture', NULL), (123, 'BCS302', 45, 2, 'CSE', 'A', 'Lab', 'A1'), (124, 'BCS302', 45, 2, 'CSE', 'A', 'Lab', 'A2'), (125, 'BCS302', 45, 2, 'CSE', 'A', 'Lab', 'A3'), (126, 'BCS303', 46, 2, 'CSE', 'A', 'Lecture', NULL), (127, 'BCS303', 46, 2, 'CSE', 'A', 'Lab', 'A1'), (128, 'BCS303', 46, 2, 'CSE', 'A', 'Lab', 'A2'), (129, 'BCS303', 46, 2, 'CSE', 'A', 'Lab', 'A3'), (130, 'BCS304', 47, 2, 'CSE', 'A', 'Lecture', NULL), (131, 'BCSL305', NULL, 2, 'CSE', 'A', 'Lab', 'A1'), (132, 'BCSL305', NULL, 2, 'CSE', 'A', 'Lab', 'A2'), (133, 'BCSL305', 47, 2, 'CSE', 'A', 'Lab', 'A3'), (134, 'BCS306A', 48, 2, 'CSE', 'A', 'Lecture', NULL), (135, 'BCS306A', 48, 2, 'CSE', 'A', 'Lab', 'A1'), (136, 'BCS306A', 48, 2, 'CSE', 'A', 'Lab', 'A2'), (137, 'BCS306A', 48, 2, 'CSE', 'A', 'Lab', 'A3'), (138, 'BSCK307', NULL, 2, 'CSE', 'A', 'Lecture', NULL), (139, 'BCS358D', 49, 2, 'CSE', 'A', 'Lecture', NULL), (140, 'BNSK359', NULL, 2, 'CSE', 'A', 'Lab', NULL), (141, 'BPEK359', NULL, 2, 'CSE', 'A', 'Lab', NULL), (142, 'BYOK359', NULL, 2, 'CSE', 'A', 'Lab', NULL),
(143, 'BCS301', 63, 2, 'CSE', 'B', 'Lecture', NULL), (144, 'BCS302', 50, 2, 'CSE', 'B', 'Lecture', NULL), (145, 'BCS302', 50, 2, 'CSE', 'B', 'Lab', 'B1'), (146, 'BCS302', 50, 2, 'CSE', 'B', 'Lab', 'B2'), (147, 'BCS302', 50, 2, 'CSE', 'B', 'Lab', 'B3'), (148, 'BCS303', 51, 2, 'CSE', 'B', 'Lecture', NULL), (149, 'BCS303', 51, 2, 'CSE', 'B', 'Lab', 'B1'), (150, 'BCS303', 51, 2, 'CSE', 'B', 'Lab', 'B2'), (151, 'BCS303', 51, 2, 'CSE', 'B', 'Lab', 'B3'), (152, 'BCS304', 52, 2, 'CSE', 'B', 'Lecture', NULL), (153, 'BCSL305', NULL, 2, 'CSE', 'B', 'Lab', 'B1'), (154, 'BCSL305', 52, 2, 'CSE', 'B', 'Lab', 'B2'), (155, 'BCSL305', 52, 2, 'CSE', 'B', 'Lab', 'B3'), (156, 'BCS306A', 49, 2, 'CSE', 'B', 'Lecture', NULL), (157, 'BCS306A', 49, 2, 'CSE', 'B', 'Lab', 'B1'), (158, 'BCS306A', 49, 2, 'CSE', 'B', 'Lab', 'B2'), (159, 'BCS306A', 49, 2, 'CSE', 'B', 'Lab', 'B3'), (160, 'BSCK307', NULL, 2, 'CSE', 'B', 'Lecture', NULL), (161, 'BCS358D', 53, 2, 'CSE', 'B', 'Lecture', NULL),
(162, 'BCS301', 54, 2, 'CSE', 'C', 'Lecture', NULL), (163, 'BCS302', 50, 2, 'CSE', 'C', 'Lecture', NULL), (164, 'BCS302', 50, 2, 'CSE', 'C', 'Lab', 'C1'), (165, 'BCS302', 50, 2, 'CSE', 'C', 'Lab', 'C2'), (166, 'BCS302', 50, 2, 'CSE', 'C', 'Lab', 'C3'), (167, 'BCS303', 46, 2, 'CSE', 'C', 'Lecture', NULL), (168, 'BCS303', 46, 2, 'CSE', 'C', 'Lab', 'C1'), (169, 'BCS303', 46, 2, 'CSE', 'C', 'Lab', 'C2'), (170, 'BCS303', 46, 2, 'CSE', 'C', 'Lab', 'C3'), (171, 'BCS304', 22, 2, 'CSE', 'C', 'Lecture', NULL), (172, 'BCSL305', 22, 2, 'CSE', 'C', 'Lab', 'C1'), (173, 'BCSL305', 22, 2, 'CSE', 'C', 'Lab', 'C2'), (174, 'BCSL305', 22, 2, 'CSE', 'C', 'Lab', 'C3'), (175, 'BCS306A', 48, 2, 'CSE', 'C', 'Lecture', NULL), (176, 'BCS306A', 48, 2, 'CSE', 'C', 'Lab', 'C1'), (177, 'BCS306A', 48, 2, 'CSE', 'C', 'Lab', 'C2'), (178, 'BCS306A', 48, 2, 'CSE', 'C', 'Lab', 'C3'), (179, 'BSCK307', NULL, 2, 'CSE', 'C', 'Lecture', NULL), (180, 'BCS358D', 55, 2, 'CSE', 'C', 'Lecture', NULL),
(181, 'BCS301', 36, 2, 'CSE', 'D', 'Lecture', NULL), (182, 'BCS302', 56, 2, 'CSE', 'D', 'Lecture', NULL), (183, 'BCS302', 56, 2, 'CSE', 'D', 'Lab', 'D1'), (184, 'BCS302', 56, 2, 'CSE', 'D', 'Lab', 'D2'), (185, 'BCS302', 56, 2, 'CSE', 'D', 'Lab', 'D3'), (186, 'BCS303', 57, 2, 'CSE', 'D', 'Lecture', NULL), (187, 'BCS303', 57, 2, 'CSE', 'D', 'Lab', 'D1'), (188, 'BCS303', 57, 2, 'CSE', 'D', 'Lab', 'D2'), (189, 'BCS303', 57, 2, 'CSE', 'D', 'Lab', 'D3'), (190, 'BCS304', 58, 2, 'CSE', 'D', 'Lecture', NULL), (191, 'BCSL305', 58, 2, 'CSE', 'D', 'Lab', 'D1'), (192, 'BCSL305', 58, 2, 'CSE', 'D', 'Lab', 'D2'), (193, 'BCSL305', 58, 2, 'CSE', 'D', 'Lab', 'D3'), (194, 'BCS306A', 59, 2, 'CSE', 'D', 'Lecture', NULL), (195, 'BCS306A', 59, 2, 'CSE', 'D', 'Lab', 'D1'), (196, 'BCS306A', 59, 2, 'CSE', 'D', 'Lab', 'D2'), (197, 'BCS306A', 59, 2, 'CSE', 'D', 'Lab', 'D3'), (198, 'BSCK307', NULL, 2, 'CSE', 'D', 'Lecture', NULL), (199, 'BCS358D', 60, 2, 'CSE', 'D', 'Lecture', NULL),
(200, 'BCS301', 61, 2, 'AI&ML', 'E', 'Lecture', NULL), (201, 'BCS302', 45, 2, 'AI&ML', 'E', 'Lecture', NULL), (202, 'BCS302', 45, 2, 'AI&ML', 'E', 'Lab', 'E1'), (203, 'BCS302', 45, 2, 'AI&ML', 'E', 'Lab', 'E2'), (204, 'BCS302', 45, 2, 'AI&ML', 'E', 'Lab', 'E3'), (205, 'BCS303', 51, 2, 'AI&ML', 'E', 'Lecture', NULL), (206, 'BCS303', 51, 2, 'AI&ML', 'E', 'Lab', 'E1'), (207, 'BCS303', 51, 2, 'AI&ML', 'E', 'Lab', 'E2'), (208, 'BCS303', 51, 2, 'AI&ML', 'E', 'Lab', 'E3'), (209, 'BCS304', 47, 2, 'AI&ML', 'E', 'Lecture', NULL), (210, 'BCSL305', NULL, 2, 'AI&ML', 'E', 'Lab', 'E1'), (211, 'BCSL305', 22, 2, 'AI&ML', 'E', 'Lab', 'E2'), (212, 'BCSL305', 47, 2, 'AI&ML', 'E', 'Lab', 'E3'), (213, 'BCS306A', 29, 2, 'AI&ML', 'E', 'Lecture', NULL), (214, 'BCS306A', 29, 2, 'AI&ML', 'E', 'Lab', 'E1'), (215, 'BCS306A', 29, 2, 'AI&ML', 'E', 'Lab', 'E2'), (216, 'BCS306A', NULL, 2, 'AI&ML', 'E', 'Lab', 'E3'), (217, 'BSCK307', 62, 2, 'AI&ML', 'E', 'Lecture', NULL), (218, 'BCS358D', 62, 2, 'AI&ML', 'E', 'Lecture', NULL),
(219, 'BCS301', 63, 2, 'AI&ML', 'F', 'Lecture', NULL), (220, 'BCS302', 56, 2, 'AI&ML', 'F', 'Lecture', NULL), (221, 'BCS302', 56, 2, 'AI&ML', 'F', 'Lab', 'F1'), (222, 'BCS302', 56, 2, 'AI&ML', 'F', 'Lab', 'F2'), (223, 'BCS302', 56, 2, 'AI&ML', 'F', 'Lab', 'F3'), (224, 'BCS303', 57, 2, 'AI&ML', 'F', 'Lecture', NULL), (225, 'BCS303', 57, 2, 'AI&ML', 'F', 'Lab', 'F1'), (226, 'BCS303', 57, 2, 'AI&ML', 'F', 'Lab', 'F2'), (227, 'BCS303', 57, 2, 'AI&ML', 'F', 'Lab', 'F3'), (228, 'BCS304', 64, 2, 'AI&ML', 'F', 'Lecture', NULL), (229, 'BCSL305', 64, 2, 'AI&ML', 'F', 'Lab', 'F1'), (230, 'BCSL305', 64, 2, 'AI&ML', 'F', 'Lab', 'F2'), (231, 'BCSL305', NULL, 2, 'AI&ML', 'F', 'Lab', 'F3'), (232, 'BCS306A', 59, 2, 'AI&ML', 'F', 'Lecture', NULL), (233, 'BCS306A', 59, 2, 'AI&ML', 'F', 'Lab', 'F1'), (234, 'BCS306A', 59, 2, 'AI&ML', 'F', 'Lab', 'F2'), (235, 'BCS306A', 30, 2, 'AI&ML', 'F', 'Lab', 'F3'), (236, 'BSCK307', NULL, 2, 'AI&ML', 'F', 'Lecture', NULL), (237, 'BCS358D', 60, 2, 'AI&ML', 'F', 'Lecture', NULL),
(238, 'BCS301', 87, 2, 'ISE', 'A', 'Lecture', NULL), (239, 'BCS302', 82, 2, 'ISE', 'A', 'Lecture', NULL), (240, 'BCS302', 82, 2, 'ISE', 'A', 'Lab', 'A1'), (241, 'BCS302', 82, 2, 'ISE', 'A', 'Lab', 'A2'), (242, 'BCS302', 82, 2, 'ISE', 'A', 'Lab', 'A3'), (243, 'BCS303', 83, 2, 'ISE', 'A', 'Lecture', NULL), (244, 'BCS303', 83, 2, 'ISE', 'A', 'Lab', 'A1'), (245, 'BCS303', 83, 2, 'ISE', 'A', 'Lab', 'A2'), (246, 'BCS303', 83, 2, 'ISE', 'A', 'Lab', 'A3'), (247, 'BCS304', 84, 2, 'ISE', 'A', 'Lecture', NULL), (248, 'BCS306A', 85, 2, 'ISE', 'A', 'Lecture', NULL), (249, 'BCS306A', 85, 2, 'ISE', 'A', 'Lab', 'A1'), (250, 'BCS306A', 85, 2, 'ISE', 'A', 'Lab', 'A2'), (251, 'BSCK307', 67, 2, 'ISE', 'A', 'Lecture', NULL), (252, 'BCS358D', 86, 2, 'ISE', 'A', 'Lecture', NULL), (253, 'BCSL305', 84, 2, 'ISE', 'A', 'Lab', 'A1'), (254, 'BCSL305', 84, 2, 'ISE', 'A', 'Lab', 'A2'), (255, 'BCSL305', 84, 2, 'ISE', 'A', 'Lab', 'A3'),
(256, 'BCS301', 87, 2, 'ISE', 'B', 'Lecture', NULL), (257, 'BCS302', 82, 2, 'ISE', 'B', 'Lecture', NULL), (258, 'BCS302', 82, 2, 'ISE', 'B', 'Lab', 'B1'), (259, 'BCS302', 82, 2, 'ISE', 'B', 'Lab', 'B2'), (260, 'BCS302', 82, 2, 'ISE', 'B', 'Lab', 'B3'), (261, 'BCS303', 83, 2, 'ISE', 'B', 'Lecture', NULL), (262, 'BCS303', 83, 2, 'ISE', 'B', 'Lab', 'B1'), (263, 'BCS303', 83, 2, 'ISE', 'B', 'Lab', 'B2'), (264, 'BCS303', 83, 2, 'ISE', 'B', 'Lab', 'B3'), (265, 'BCS304', 84, 2, 'ISE', 'B', 'Lecture', NULL), (266, 'BCS306A', 86, 2, 'ISE', 'B', 'Lecture', NULL), (267, 'BCS306A', 86, 2, 'ISE', 'B', 'Lab', 'B1'), (268, 'BCS306A', 86, 2, 'ISE', 'B', 'Lab', 'B2'), (269, 'BSCK307', 67, 2, 'ISE', 'B', 'Lecture', NULL), (270, 'BCS358D', 86, 2, 'ISE', 'B', 'Lecture', NULL), (271, 'BCSL305', 84, 2, 'ISE', 'B', 'Lab', 'B1'), (272, 'BCSL305', 84, 2, 'ISE', 'B', 'Lab', 'B2'), (273, 'BCSL305', 84, 2, 'ISE', 'B', 'Lab', 'B3'),
(274, 'BCS301', 87, 2, 'ISE', 'C', 'Lecture', NULL), (275, 'BCS302', 87, 2, 'ISE', 'C', 'Lecture', NULL), (276, 'BCS302', 87, 2, 'ISE', 'C', 'Lab', 'C1'), (277, 'BCS302', 87, 2, 'ISE', 'C', 'Lab', 'C2'), (278, 'BCS302', 87, 2, 'ISE', 'C', 'Lab', 'C3'), (279, 'BCS303', 88, 2, 'ISE', 'C', 'Lecture', NULL), (280, 'BCS303', 88, 2, 'ISE', 'C', 'Lab', 'C1'), (281, 'BCS303', 88, 2, 'ISE', 'C', 'Lab', 'C2'), (282, 'BCS303', 88, 2, 'ISE', 'C', 'Lab', 'C3'), (283, 'BCS304', 89, 2, 'ISE', 'C', 'Lecture', NULL), (284, 'BCS306A', 85, 2, 'ISE', 'C', 'Lecture', NULL), (285, 'BCS306A', 85, 2, 'ISE', 'C', 'Lab', 'C1'), (286, 'BCS306A', 85, 2, 'ISE', 'C', 'Lab', 'C2'), (287, 'BSCK307', 90, 2, 'ISE', 'C', 'Lecture', NULL), (288, 'BCS358D', 87, 2, 'ISE', 'C', 'Lecture', NULL), (289, 'BCSL305', 89, 2, 'ISE', 'C', 'Lab', 'C1'), (290, 'BCSL305', 89, 2, 'ISE', 'C', 'Lab', 'C2'), (291, 'BCSL305', 89, 2, 'ISE', 'C', 'Lab', 'C3'),
(292, 'BCS301', 90, 2, 'ISE', 'D', 'Lecture', NULL), (293, 'BCS302', 90, 2, 'ISE', 'D', 'Lecture', NULL), (294, 'BCS302', 90, 2, 'ISE', 'D', 'Lab', 'D1'), (295, 'BCS302', 90, 2, 'ISE', 'D', 'Lab', 'D2'), (296, 'BCS302', 90, 2, 'ISE', 'D', 'Lab', 'D3'), (297, 'BCS303', 70, 2, 'ISE', 'D', 'Lecture', NULL), (298, 'BCS303', 70, 2, 'ISE', 'D', 'Lab', 'D1'), (299, 'BCS303', 70, 2, 'ISE', 'D', 'Lab', 'D2'), (300, 'BCS303', 70, 2, 'ISE', 'D', 'Lab', 'D3'), (301, 'BCS304', 89, 2, 'ISE', 'D', 'Lecture', NULL), (302, 'BCS306A', 71, 2, 'ISE', 'D', 'Lecture', NULL), (303, 'BCS306A', 71, 2, 'ISE', 'D', 'Lab', 'D1'), (304, 'BCS306A', 71, 2, 'ISE', 'D', 'Lab', 'D2'), (305, 'BSCK307', 90, 2, 'ISE', 'D', 'Lecture', NULL), (306, 'BCS358D', 87, 2, 'ISE', 'D', 'Lecture', NULL), (307, 'BCSL305', 89, 2, 'ISE', 'D', 'Lab', 'D1'), (308, 'BCSL305', 89, 2, 'ISE', 'D', 'Lab', 'D2'), (309, 'BCSL305', 89, 2, 'ISE', 'D', 'Lab', 'D3'),
(310, 'BIS501', 65, 3, 'ISE', 'A', 'Lecture', NULL), (311, 'BIS502', 66, 3, 'ISE', 'A', 'Lecture', NULL), (312, 'BIS502', 66, 3, 'ISE', 'A', 'Lab', 'A1'), (313, 'BIS502', 66, 3, 'ISE', 'A', 'Lab', 'A2'), (314, 'BIS503', 67, 3, 'ISE', 'A', 'Lecture', NULL), (315, 'BIS505', 68, 3, 'ISE', 'A', 'Lecture', NULL), (316, 'BIS516B', 69, 3, 'ISE', 'A', 'Lecture', NULL), (317, 'BIS516C', 66, 3, 'ISE', 'A', 'Lecture', NULL), (318, 'BIS516D', 70, 3, 'ISE', 'A', 'Lecture', NULL), (319, 'BRMIS557', 71, 3, 'ISE', 'A', 'Lecture', NULL), (320, 'BISL504', 65, 3, 'ISE', 'A', 'Lab', 'A1'), (321, 'BISL504', 65, 3, 'ISE', 'A', 'Lab', 'A2'), (322, 'BIS586', 68, 3, 'ISE', 'A', 'Lab', NULL), (323, 'BESK508', 72, 3, 'ISE', 'A', 'Lecture', NULL), (324, 'BNSK559', NULL, 3, 'ISE', 'A', 'Lab', NULL),
(325, 'BIS501', 73, 3, 'ISE', 'B', 'Lecture', NULL), (326, 'BIS502', 74, 3, 'ISE', 'B', 'Lecture', NULL), (327, 'BIS502', 74, 3, 'ISE', 'B', 'Lab', 'B1'), (328, 'BIS502', 74, 3, 'ISE', 'B', 'Lab', 'B2'), (329, 'BIS503', 75, 3, 'ISE', 'B', 'Lecture', NULL), (330, 'BIS505', 76, 3, 'ISE', 'B', 'Lecture', NULL), (331, 'BIS516B', 69, 3, 'ISE', 'B', 'Lecture', NULL), (332, 'BIS516C', 66, 3, 'ISE', 'B', 'Lecture', NULL), (333, 'BIS516D', 70, 3, 'ISE', 'B', 'Lecture', NULL), (334, 'BRMIS557', 77, 3, 'ISE', 'B', 'Lecture', NULL), (335, 'BISL504', NULL, 3, 'ISE', 'B', 'Lab', 'B1'), (336, 'BISL504', 65, 3, 'ISE', 'B', 'Lab', 'B2'), (337, 'BIS586', 68, 3, 'ISE', 'B', 'Lab', NULL), (338, 'BESK508', 78, 3, 'ISE', 'B', 'Lecture', NULL), (339, 'BNSK559', NULL, 3, 'ISE', 'B', 'Lab', NULL),
(340, 'BIS501', 65, 3, 'ISE', 'C', 'Lecture', NULL), (341, 'BIS502', 79, 3, 'ISE', 'C', 'Lecture', NULL), (342, 'BIS502', 79, 3, 'ISE', 'C', 'Lab', 'C1'), (343, 'BIS502', 79, 3, 'ISE', 'C', 'Lab', 'C2'), (344, 'BIS503', 75, 3, 'ISE', 'C', 'Lecture', NULL), (345, 'BIS505', 76, 3, 'ISE', 'C', 'Lecture', NULL), (346, 'BIS516B', 69, 3, 'ISE', 'C', 'Lecture', NULL), (347, 'BIS516C', 66, 3, 'ISE', 'C', 'Lecture', NULL), (348, 'BIS516D', 70, 3, 'ISE', 'C', 'Lecture', NULL), (349, 'BRMIS557', 80, 3, 'ISE', 'C', 'Lecture', NULL), (350, 'BISL504', NULL, 3, 'ISE', 'C', 'Lab', 'C1'), (351, 'BISL504', NULL, 3, 'ISE', 'C', 'Lab', 'C2'), (352, 'BIS586', 68, 3, 'ISE', 'C', 'Lab', NULL), (353, 'BESK508', 78, 3, 'ISE', 'C', 'Lecture', NULL), (354, 'BNSK559', NULL, 3, 'ISE', 'C', 'Lab', NULL),
(355, 'BIS501', 73, 3, 'ISE', 'D', 'Lecture', NULL), (356, 'BIS502', 74, 3, 'ISE', 'D', 'Lecture', NULL), (357, 'BIS502', 74, 3, 'ISE', 'D', 'Lab', 'D1'), (358, 'BIS502', 74, 3, 'ISE', 'D', 'Lab', 'D2'), (359, 'BIS503', 81, 3, 'ISE', 'D', 'Lecture', NULL), (360, 'BIS505', 68, 3, 'ISE', 'D', 'Lecture', NULL), (361, 'BIS516B', 69, 3, 'ISE', 'D', 'Lecture', NULL), (362, 'BIS516C', 66, 3, 'ISE', 'D', 'Lecture', NULL), (363, 'BIS516D', 70, 3, 'ISE', 'D', 'Lecture', NULL), (364, 'BRMIS557', 77, 3, 'ISE', 'D', 'Lecture', NULL), (365, 'BISL504', NULL, 3, 'ISE', 'D', 'Lab', 'D1'), (366, 'BISL504', NULL, 3, 'ISE', 'D', 'Lab', 'D2'), (367, 'BIS586', 68, 3, 'ISE', 'D', 'Lab', NULL), (368, 'BESK508', 72, 3, 'ISE', 'D', 'Lecture', NULL), (369, 'BNSK559', NULL, 3, 'ISE', 'D', 'Lab', NULL),
(370, 'BCS501', 91, 3, 'CSE', 'A', 'Lecture', NULL), (371, 'BCS502', 92, 3, 'CSE', 'A', 'Lecture', NULL), (372, 'BCS502', 92, 3, 'CSE', 'A', 'Lab', 'A1'), (373, 'BCS502', 92, 3, 'CSE', 'A', 'Lab', 'A2'), (374, 'BCS502', 92, 3, 'CSE', 'A', 'Lab', 'A3'), (375, 'BCS503', 93, 3, 'CSE', 'A', 'Lecture', NULL), (376, 'BCSL504', 94, 3, 'CSE', 'A', 'Lab', 'A1'), (377, 'BCSL504', 94, 3, 'CSE', 'A', 'Lab', 'A2'), (378, 'BCSL504', 94, 3, 'CSE', 'A', 'Lab', 'A3'), (379, 'BCS505', 94, 3, 'CSE', 'A', 'Lecture', NULL), (380, 'BCS516B', 95, 3, 'CSE', 'A', 'Lecture', NULL), (381, 'BCS586', 52, 3, 'CSE', 'A', 'Lab', NULL), (382, 'BRMCS557', 96, 3, 'CSE', 'A', 'Lecture', NULL), (383, 'BESK508', 97, 3, 'CSE', 'A', 'Lecture', NULL), (384, 'BNSK559', NULL, 3, 'CSE', 'A', 'Lab', NULL),
(385, 'BCS501', 98, 3, 'CSE', 'B', 'Lecture', NULL), (386, 'BCS502', 99, 3, 'CSE', 'B', 'Lecture', NULL), (387, 'BCS502', 99, 3, 'CSE', 'B', 'Lab', 'B1'), (388, 'BCS502', 99, 3, 'CSE', 'B', 'Lab', 'B2'), (389, 'BCS502', 27, 3, 'CSE', 'B', 'Lab', 'B3'), (390, 'BCS503', 100, 3, 'CSE', 'B', 'Lecture', NULL), (391, 'BCSL504', 37, 3, 'CSE', 'B', 'Lab', 'B1'), (392, 'BCSL504', 37, 3, 'CSE', 'B', 'Lab', 'B2'), (393, 'BCSL504', 37, 3, 'CSE', 'B', 'Lab', 'B3'), (394, 'BCS505', 37, 3, 'CSE', 'B', 'Lecture', NULL), (395, 'BCS516B', 101, 3, 'CSE', 'B', 'Lecture', NULL), (396, 'BCS586', 52, 3, 'CSE', 'B', 'Lab', NULL), (397, 'BRMCS557', 43, 3, 'CSE', 'B', 'Lecture', NULL), (398, 'BESK508', 97, 3, 'CSE', 'B', 'Lecture', NULL), (399, 'BNSK559', NULL, 3, 'CSE', 'B', 'Lab', NULL),
(400, 'BCS501', 102, 3, 'CSE', 'C', 'Lecture', NULL), (401, 'BCS502', 103, 3, 'CSE', 'C', 'Lecture', NULL), (402, 'BCS502', 103, 3, 'CSE', 'C', 'Lab', 'C1'), (403, 'BCS502', 103, 3, 'CSE', 'C', 'Lab', 'C2'), (404, 'BCS502', 103, 3, 'CSE', 'C', 'Lab', 'C3'), (405, 'BCS503', 100, 3, 'CSE', 'C', 'Lecture', NULL), (406, 'BCSL504', 94, 3, 'CSE', 'C', 'Lab', 'C1'), (407, 'BCSL504', 37, 3, 'CSE', 'C', 'Lab', 'C2'), (408, 'BCSL504', 37, 3, 'CSE', 'C', 'Lab', 'C3'), (409, 'BCS505', 94, 3, 'CSE', 'C', 'Lecture', NULL), (410, 'BCS516B', 104, 3, 'CSE', 'C', 'Lecture', NULL), (411, 'BCS586', 52, 3, 'CSE', 'C', 'Lab', NULL), (412, 'BRMCS557', 55, 3, 'CSE', 'C', 'Lecture', NULL), (413, 'BESK508', 97, 3, 'CSE', 'C', 'Lecture', NULL), (414, 'BNSK559', NULL, 3, 'CSE', 'C', 'Lab', NULL),
(415, 'BCS501', 60, 3, 'CSE', 'D', 'Lecture', NULL), (416, 'BCS502', 106, 3, 'CSE', 'D', 'Lecture', NULL), (417, 'BCS502', 103, 3, 'CSE', 'D', 'Lab', 'D1'), (418, 'BCS502', 50, 3, 'CSE', 'D', 'Lab', 'D2'), (419, 'BCS502', 103, 3, 'CSE', 'D', 'Lab', 'D3'), (420, 'BCS503', 58, 3, 'CSE', 'D', 'Lecture', NULL), (421, 'BCSL504', 107, 3, 'CSE', 'D', 'Lab', 'D1'), (422, 'BCSL504', 107, 3, 'CSE', 'D', 'Lab', 'D2'), (423, 'BCSL504', 107, 3, 'CSE', 'D', 'Lab', 'D3'), (424, 'BCS505', 107, 3, 'CSE', 'D', 'Lecture', NULL), (425, 'BCS516B', 95, 3, 'CSE', 'D', 'Lecture', NULL), (426, 'BCS586', 52, 3, 'CSE', 'D', 'Lab', NULL), (427, 'BRMCS557', 103, 3, 'CSE', 'D', 'Lecture', NULL), (428, 'BESK508', 72, 3, 'CSE', 'D', 'Lecture', NULL), (429, 'BNSK559', NULL, 3, 'CSE', 'D', 'Lab', NULL),
(430, 'BCS501', 91, 3, 'AI&ML', 'E', 'Lecture', NULL), (431, 'BCS502', 99, 3, 'AI&ML', 'E', 'Lecture', NULL), (432, 'BCS502', 99, 3, 'AI&ML', 'E', 'Lab', 'E1'), (433, 'BCS502', 99, 3, 'AI&ML', 'E', 'Lab', 'E2'), (434, 'BCS502', 99, 3, 'AI&ML', 'E', 'Lab', 'E3'), (435, 'BCS503', 116, 3, 'AI&ML', 'E', 'Lecture', NULL), (436, 'BCSL504', 117, 3, 'AI&ML', 'E', 'Lab', 'E1'), (437, 'BCSL504', 117, 3, 'AI&ML', 'E', 'Lab', 'E2'), (438, 'BCSL504', 117, 3, 'AI&ML', 'E', 'Lab', 'E3'), (439, 'BCS505', 117, 3, 'AI&ML', 'E', 'Lecture', NULL), (440, 'BCI516B', 118, 3, 'AI&ML', 'E', 'Lecture', NULL), (441, 'BCI586', 52, 3, 'AI&ML', 'E', 'Lab', NULL), (442, 'BRMCS557', 35, 3, 'AI&ML', 'E', 'Lecture', NULL), (443, 'BESK508', 72, 3, 'AI&ML', 'E', 'Lecture', NULL), (444, 'BNSK559', NULL, 3, 'AI&ML', 'E', 'Lab', NULL),
(445, 'BCS501', 102, 3, 'AI&ML', 'F', 'Lecture', NULL), (446, 'BCS502', 92, 3, 'AI&ML', 'F', 'Lecture', NULL), (447, 'BCS502', 92, 3, 'AI&ML', 'F', 'Lab', 'F1'), (448, 'BCS502', 118, 3, 'AI&ML', 'F', 'Lab', 'F2'), (449, 'BCS502', 92, 3, 'AI&ML', 'F', 'Lab', 'F3'), (450, 'BCS503', 93, 3, 'AI&ML', 'F', 'Lecture', NULL), (451, 'BCSL504', 104, 3, 'AI&ML', 'F', 'Lab', 'F1'), (452, 'BCSL504', 117, 3, 'AI&ML', 'F', 'Lab', 'F2'), (453, 'BCSL504', 104, 3, 'AI&ML', 'F', 'Lab', 'F3'), (454, 'BCS505', 117, 3, 'AI&ML', 'F', 'Lecture', NULL), (455, 'BCI516B', 118, 3, 'AI&ML', 'F', 'Lecture', NULL), (456, 'BCI586', 52, 3, 'AI&ML', 'F', 'Lab', NULL), (457, 'BRMCS557', 53, 3, 'AI&ML', 'F', 'Lecture', NULL), (458, 'BESK508', 78, 3, 'AI&ML', 'F', 'Lecture', NULL), (459, 'BNSK559', NULL, 3, 'AI&ML', 'F', 'Lab', NULL),
(460, 'BCS701', 101, 4, 'CSE', 'A', 'Lecture', NULL), (461, 'BCS702', 38, 4, 'CSE', 'A', 'Lecture', NULL), (462, 'BCS702', 38, 4, 'CSE', 'A', 'Lab', 'A1'), (463, 'BCS702', 38, 4, 'CSE', 'A', 'Lab', 'A2'), (464, 'BCS713A', 107, 4, 'CSE', 'A', 'Lecture', NULL), (465, 'BCS713C', 27, 4, 'CSE', 'A', 'Lecture', NULL), (466, 'BCI713D', NULL, 4, 'CSE', 'A', 'Lecture', NULL), (467, 'BCS754X', NULL, 4, 'CSE', 'A', 'Lecture', NULL), (468, 'BCS785', 99, 4, 'CSE', 'A', 'Lab', NULL),
(469, 'BCS701', 112, 4, 'CSE', 'B', 'Lecture', NULL), (470, 'BCS702', 113, 4, 'CSE', 'B', 'Lecture', NULL), (471, 'BCS702', 113, 4, 'CSE', 'B', 'Lab', 'B1'), (472, 'BCS702', 38, 4, 'CSE', 'B', 'Lab', 'B2'), (473, 'BCS713A', 107, 4, 'CSE', 'B', 'Lecture', NULL), (474, 'BCS713C', 27, 4, 'CSE', 'B', 'Lecture', NULL), (475, 'BCI713D', NULL, 4, 'CSE', 'B', 'Lecture', NULL), (476, 'BCS754X', NULL, 4, 'CSE', 'B', 'Lecture', NULL), (477, 'BCS785', 99, 4, 'CSE', 'B', 'Lab', NULL),
(478, 'BCS701', 114, 4, 'CSE', 'C', 'Lecture', NULL), (479, 'BCS702', 113, 4, 'CSE', 'C', 'Lecture', NULL), (480, 'BCS702', 38, 4, 'CSE', 'C', 'Lab', 'C1'), (481, 'BCS702', 38, 4, 'CSE', 'C', 'Lab', 'C2'), (482, 'BCS713A', 107, 4, 'CSE', 'C', 'Lecture', NULL), (483, 'BCS713C', NULL, 4, 'CSE', 'C', 'Lecture', NULL), (484, 'BCI713D', NULL, 4, 'CSE', 'C', 'Lecture', NULL), (485, 'BCS754X', NULL, 4, 'CSE', 'C', 'Lecture', NULL), (486, 'BCS785', 99, 4, 'CSE', 'C', 'Lab', NULL),
(487, 'BCS701', 112, 4, 'CSE', 'D', 'Lecture', NULL), (488, 'BCS702', 41, 4, 'CSE', 'D', 'Lecture', NULL), (489, 'BCS702', 41, 4, 'CSE', 'D', 'Lab', 'D1'), (490, 'BCS702', 41, 4, 'CSE', 'D', 'Lab', 'D2'), (491, 'BCS713A', 107, 4, 'CSE', 'D', 'Lecture', NULL), (492, 'BCS713C', NULL, 4, 'CSE', 'D', 'Lecture', NULL), (493, 'BCI713D', NULL, 4, 'CSE', 'D', 'Lecture', NULL), (494, 'BCS754X', NULL, 4, 'CSE', 'D', 'Lecture', NULL), (495, 'BCS786', 99, 4, 'CSE', 'D', 'Lab', NULL),
(496, 'BCI701', 116, 4, 'AI&ML', 'E', 'Lecture', NULL), (497, 'BCI701', 116, 4, 'AI&ML', 'E', 'Lecture', 'E1'), (498, 'BCI701', 116, 4, 'AI&ML', 'E', 'Lecture', 'E2'), (499, 'BCI702', 104, 4, 'AI&ML', 'E', 'Lecture', NULL), (500, 'BCI702', 104, 4, 'AI&ML', 'E', 'Lab', 'E1'), (501, 'BCI702', 104, 4, 'AI&ML', 'E', 'Lab', 'E2'), (502, 'BCI713D', 52, 4, 'AI&ML', 'E', 'Lecture', NULL), (503, 'BCS754X', NULL, 4, 'AI&ML', 'E', 'Lecture', NULL), (504, 'BCI785', 99, 4, 'AI&ML', 'E', 'Lab', NULL);-- 8. INSERT TIMETABLE SLOTS DATA
-- (This is the complete, manually transcribed slot data for all sections)


SELECT DISTINCT faculty_id FROM classes 
WHERE faculty_id IS NOT NULL 
AND faculty_id NOT IN (SELECT id FROM faculty);

ALTER TABLE classes MODIFY COLUMN faculty_id INT NULL;


ALTER TABLE classes 
MODIFY COLUMN faculty_id INT NULL;

-- 1st Year CSE 'A' (IDs: 1-12)
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(2, 'Monday', '09:00:00', '10:00:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(1, 'Monday', '10:00:00', '11:00:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(5, 'Monday', '11:30:00', '12:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(8, 'Monday', '14:30:00', '16:30:00', NULL, 'PHY LAB-1'),
(7, 'Monday', '14:30:00', '16:30:00', NULL, 'PSC LAB-2'),
(1, 'Tuesday', '10:00:00', '11:00:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(9, 'Tuesday', '14:30:00', '16:30:00', NULL, 'PHY LAB-2'),
(6, 'Tuesday', '14:30:00', '16:30:00', NULL, 'PSC LAB-1'),
(4, 'Wednesday', '10:00:00', '11:00:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(2, 'Wednesday', '11:30:00', '12:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(3, 'Wednesday', '14:30:00', '16:30:00', NULL, 'CAED Lab'),
(3, 'Thursday', '10:00:00', '12:30:00', NULL, 'CAED Lab'),
(5, 'Thursday', '14:30:00', '15:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(11, 'Thursday', '15:30:00', '16:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(4, 'Friday', '09:00:00', '10:00:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(1, 'Friday', '11:30:00', '12:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(2, 'Friday', '14:30:00', '15:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(5, 'Friday', '15:30:00', '16:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(10, 'Friday', '16:30:00', '17:30:00', '101', 'Ramanujacharya Bhavan, ground floor'),
(12, 'Saturday', '10:00:00', '11:00:00', '101', 'Ramanujacharya Bhavan, ground floor');

-- 1st Year CSE 'B' (IDs: 13-24)
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(17, 'Monday', '09:00:00', '10:00:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(16, 'Monday', '11:30:00', '12:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(13, 'Monday', '12:30:00', '13:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(20, 'Monday', '14:30:00', '16:30:00', NULL, 'PHY LAB-1'),
(19, 'Monday', '14:30:00', '16:30:00', NULL, 'PSC LAB-2'),
(13, 'Tuesday', '10:00:00', '11:00:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(17, 'Tuesday', '11:30:00', '12:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(21, 'Wednesday', '09:00:00', '11:00:00', NULL, 'PHY LAB-2'),
(18, 'Wednesday', '09:00:00', '11:00:00', NULL, 'PSC LAB-1'),
(14, 'Wednesday', '11:30:00', '12:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(17, 'Wednesday', '14:30:00', '15:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(16, 'Wednesday', '15:30:00', '16:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(14, 'Thursday', '09:00:00', '10:00:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(16, 'Thursday', '11:30:00', '12:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(15, 'Thursday', '14:30:00', '16:30:00', NULL, 'CAED Lab'),
(22, 'Friday', '12:30:00', '13:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(13, 'Friday', '14:30:00', '15:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(23, 'Friday', '15:30:00', '16:30:00', '107', 'Ramanujacharya Bhavan, ground floor'),
(24, 'Saturday', '09:00:00', '10:00:00', '107', 'Ramanujacharya Bhavan, ground floor');

-- 1st Year CSE 'C' (IDs: 25-36)
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(26, 'Monday', '10:00:00', '11:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(29, 'Monday', '11:30:00', '12:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(25, 'Monday', '12:30:00', '13:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(27, 'Monday', '14:30:00', '16:30:00', NULL, 'CAED Lab'),
(29, 'Tuesday', '09:00:00', '10:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(25, 'Tuesday', '11:30:00', '12:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(32, 'Tuesday', '14:30:00', '16:30:00', NULL, 'PHY LAB-1'),
(31, 'Tuesday', '14:30:00', '16:30:00', NULL, 'PSC LAB-2'),
(28, 'Wednesday', '09:00:00', '10:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(25, 'Wednesday', '10:00:00', '11:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(26, 'Wednesday', '12:30:00', '13:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(28, 'Thursday', '09:00:00', '10:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(27, 'Thursday', '09:00:00', '11:00:00', NULL, 'CAED Lab'), -- Assuming 9-11 slot
(34, 'Thursday', '11:30:00', '12:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(33, 'Thursday', '14:30:00', '16:30:00', NULL, 'PHY LAB-2'),
(30, 'Thursday', '14:30:00', '16:30:00', NULL, 'PSC LAB-1'),
(26, 'Friday', '09:00:00', '10:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(28, 'Friday', '10:00:00', '11:00:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(29, 'Friday', '14:30:00', '15:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(25, 'Friday', '15:30:00', '16:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(35, 'Friday', '16:30:00', '17:30:00', '108', 'Ramanujacharya Bhavan, ground floor'),
(36, 'Saturday', '10:00:00', '11:00:00', '108', 'Ramanujacharya Bhavan, ground floor');

INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(374, 'Monday', '09:00:00', '11:00:00', 'CSLAB-8', 'CSE Dept'), -- A3 CN lab
(379, 'Monday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- FSD
(380, 'Monday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- AI
(370, 'Monday', '14:30:00', '15:30:00', '301', 'North Campus, 3rd Floor'), -- SPM
(383, 'Monday', '15:30:00', '16:30:00', '301', 'North Campus, 3rd Floor'), -- EVS
(384, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(376, 'Tuesday', '09:00:00', '11:00:00', 'AIML LAB-3', 'AI&ML Dept'), -- A1 FSD Lab
(377, 'Tuesday', '09:00:00', '11:00:00', 'AIML LAB-3', 'AI&ML Dept'), -- A2 FSD Lab
(375, 'Tuesday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- ATC
(371, 'Tuesday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- CN
(379, 'Tuesday', '14:30:00', '15:30:00', '301', 'North Campus, 3rd Floor'), -- FSD
(380, 'Tuesday', '15:30:00', '16:30:00', '301', 'North Campus, 3rd Floor'), -- AI
(384, 'Tuesday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(373, 'Wednesday', '09:00:00', '11:00:00', 'CSLAB-8', 'CSE Dept'), -- A2 CN Lab
(378, 'Wednesday', '09:00:00', '11:00:00', 'AIML LAB-3', 'AI&ML Dept'), -- A3 FSD Lab
(370, 'Wednesday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- SPM
(382, 'Wednesday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- RM
(380, 'Wednesday', '14:30:00', '15:30:00', '301', 'North Campus, 3rd Floor'), -- AI
(375, 'Wednesday', '15:30:00', '16:30:00', '301', 'North Campus, 3rd Floor'), -- ATC
(375, 'Thursday', '09:00:00', '10:00:00', '301', 'North Campus, 3rd Floor'), -- ATC
(371, 'Thursday', '10:00:00', '11:00:00', '301', 'North Campus, 3rd Floor'), -- CN
(370, 'Thursday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- SPM
(379, 'Thursday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- FSD
(375, 'Thursday', '14:30:00', '16:30:00', '301', 'North Campus, 3rd Floor'), -- ATC Tutorial A
(372, 'Friday', '09:00:00', '11:00:00', 'CSLAB-8', 'CSE Dept'), -- A1 CN Lab
(380, 'Friday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- AI
(371, 'Friday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- CN
(382, 'Friday', '14:30:00', '15:30:00', '301', 'North Campus, 3rd Floor'), -- RM
(370, 'Friday', '15:30:00', '16:30:00', '301', 'North Campus, 3rd Floor'), -- SPM
(381, 'Friday', '16:30:00', '17:30:00', NULL, 'Minor Project');
-- Saturday Activity Points ignored

-- ---------------------------------
-- 5th Sem (Year 3) CSE 'B' (IDs: 385-399) [File: 5th Final, Page 2]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(397, 'Monday', '09:00:00', '10:00:00', '302', 'North Campus, 3rd Floor'), -- RM
(385, 'Monday', '10:00:00', '11:00:00', '302', 'North Campus, 3rd Floor'), -- SPM
(394, 'Monday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- FSD
(388, 'Monday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- B2 CN Lab
(391, 'Monday', '15:30:00', '17:30:00', 'AIML LAB-3', 'AI&ML Dept'), -- B1 FSD Lab
(399, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'), -- Overlaps FSD Lab end
(395, 'Tuesday', '09:00:00', '10:00:00', '302', 'North Campus, 3rd Floor'), -- AI
(398, 'Tuesday', '10:00:00', '11:00:00', '302', 'North Campus, 3rd Floor'), -- EVS
(394, 'Tuesday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- FSD
(390, 'Tuesday', '12:30:00', '13:30:00', '302', 'North Campus, 3rd Floor'), -- ATC
(386, 'Tuesday', '14:30:00', '15:30:00', '302', 'North Campus, 3rd Floor'), -- CN
(387, 'Wednesday', '09:00:00', '11:00:00', 'CSLAB-8', 'CSE Dept'), -- B1 CN Lab
(393, 'Wednesday', '09:00:00', '11:00:00', 'AIML LAB-3', 'AI&ML Dept'), -- B3 FSD Lab
(386, 'Wednesday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- CN
(385, 'Wednesday', '12:30:00', '13:30:00', '302', 'North Campus, 3rd Floor'), -- SPM
(394, 'Thursday', '09:00:00', '10:00:00', '302', 'North Campus, 3rd Floor'), -- FSD
(385, 'Thursday', '10:00:00', '11:00:00', '302', 'North Campus, 3rd Floor'), -- SPM
(395, 'Thursday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- AI
(390, 'Thursday', '12:30:00', '13:30:00', '302', 'North Campus, 3rd Floor'), -- ATC
(389, 'Thursday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- B3 CN Lab
(392, 'Thursday', '15:30:00', '17:30:00', 'AIML LAB-3', 'AI&ML Dept'), -- B2 FSD Lab
(399, 'Thursday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'), -- Overlaps FSD Lab end
(386, 'Friday', '09:00:00', '10:00:00', '302', 'North Campus, 3rd Floor'), -- CN
(395, 'Friday', '10:00:00', '11:00:00', '302', 'North Campus, 3rd Floor'), -- AI
(390, 'Friday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- ATC
(397, 'Friday', '12:30:00', '13:30:00', '302', 'North Campus, 3rd Floor'), -- RM
(390, 'Friday', '14:30:00', '16:30:00', '302', 'North Campus, 3rd Floor'), -- ATC Tutorial B
(396, 'Friday', '16:30:00', '17:30:00', NULL, 'Minor Project');
-- Saturday Activity Points ignored

-- ---------------------------------
-- 5th Sem (Year 3) CSE 'C' (IDs: 400-414) [File: 5th Final, Page 3]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(405, 'Monday', '09:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- ATC Tutorial C
(400, 'Monday', '11:30:00', '12:30:00', '303', 'North Campus, 3rd Floor'), -- SPM
(410, 'Monday', '12:30:00', '13:30:00', '303', 'North Campus, 3rd Floor'), -- AI
(401, 'Monday', '14:30:00', '15:30:00', '303', 'North Campus, 3rd Floor'), -- CN
(405, 'Monday', '15:30:00', '16:30:00', '303', 'North Campus, 3rd Floor'), -- ATC
(414, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(405, 'Tuesday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- ATC
(410, 'Tuesday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- AI
(400, 'Tuesday', '11:30:00', '12:30:00', '303', 'North Campus, 3rd Floor'), -- SPM
(409, 'Tuesday', '12:30:00', '13:30:00', '303', 'North Campus, 3rd Floor'), -- FSD
(412, 'Tuesday', '14:30:00', '15:30:00', '303', 'North Campus, 3rd Floor'), -- RM
(413, 'Tuesday', '15:30:00', '16:30:00', '303', 'North Campus, 3rd Floor'), -- EVS
(401, 'Wednesday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- CN
(405, 'Wednesday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- ATC
(407, 'Wednesday', '11:30:00', '13:30:00', 'AIML LAB-3', 'AI&ML Dept'), -- C2 FSD Lab
(404, 'Wednesday', '11:30:00', '13:30:00', 'CSLAB-8', 'CSE Dept'), -- C3 CN Lab
(400, 'Thursday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- SPM
(412, 'Thursday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- RM
(401, 'Thursday', '11:30:00', '12:30:00', '303', 'North Campus, 3rd Floor'), -- CN
(409, 'Thursday', '12:30:00', '13:30:00', '303', 'North Campus, 3rd Floor'), -- FSD
(402, 'Thursday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- C1 CN Lab
(408, 'Thursday', '14:30:00', '16:30:00', 'AIML LAB-3', 'AI&ML Dept'), -- C3 FSD Lab
(414, 'Thursday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(411, 'Friday', '09:00:00', '10:00:00', NULL, 'Minor Project'),
(409, 'Friday', '11:30:00', '12:30:00', '303', 'North Campus, 3rd Floor'), -- FSD
(410, 'Friday', '12:30:00', '13:30:00', '303', 'North Campus, 3rd Floor'), -- AI
(403, 'Friday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- C2 CN Lab
(406, 'Friday', '14:30:00', '16:30:00', 'AIML LAB-3', 'AI&ML Dept'); -- C1 FSD Lab
-- Saturday Activity Points ignored

-- ---------------------------------
-- 5th Sem (Year 3) CSE 'D' (IDs: 415-429) [File: 5th Final, Page 4]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(416, 'Monday', '09:00:00', '10:00:00', '301', 'North Campus, 3rd Floor'), -- CN
(427, 'Monday', '10:00:00', '11:00:00', '301', 'North Campus, 3rd Floor'), -- RM
(426, 'Monday', '11:30:00', '13:30:00', NULL, 'Minor Project'),
(429, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(420, 'Tuesday', '09:00:00', '10:00:00', '307', 'North Campus, 3rd Floor'), -- ATC
(427, 'Tuesday', '10:00:00', '11:00:00', '307', 'North Campus, 3rd Floor'), -- RM
(415, 'Tuesday', '11:30:00', '12:30:00', '301', 'North Campus, 3rd Floor'), -- SPM
(424, 'Tuesday', '12:30:00', '13:30:00', '307', 'North Campus, 3rd Floor'), -- FSD
(428, 'Tuesday', '14:30:00', '15:30:00', '307', 'North Campus, 3rd Floor'), -- EVS
(425, 'Tuesday', '15:30:00', '16:30:00', '307', 'North Campus, 3rd Floor'), -- AI
(425, 'Wednesday', '09:00:00', '10:00:00', '302', 'North Campus, 3rd Floor'), -- AI
(416, 'Wednesday', '10:00:00', '11:00:00', '307', 'North Campus, 3rd Floor'), -- CN
(416, 'Wednesday', '11:30:00', '12:30:00', '302', 'North Campus, 3rd Floor'), -- CN
(424, 'Wednesday', '12:30:00', '13:30:00', '301', 'North Campus, 3rd Floor'), -- FSD
(420, 'Wednesday', '14:30:00', '16:30:00', '307', 'North Campus, 3rd Floor'), -- ATC Tutorial D
(429, 'Wednesday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(415, 'Thursday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- SPM
(420, 'Thursday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- ATC
(421, 'Thursday', '11:30:00', '13:30:00', 'AIML LAB-3', 'AI&ML Dept'), -- D1 FSD Lab
(418, 'Thursday', '11:30:00', '13:30:00', 'CSLAB-8', 'CSE Dept'), -- D2 CN Lab
(417, 'Friday', '09:00:00', '11:00:00', 'CSLAB-8', 'CSE Dept'), -- D1 CN Lab
(423, 'Friday', '09:00:00', '11:00:00', 'AIML LAB-3', 'AI&ML Dept'), -- D3 FSD Lab
(420, 'Friday', '11:30:00', '12:30:00', '303', 'North Campus, 3rd Floor'), -- ATC
(425, 'Friday', '12:30:00', '13:30:00', '303', 'North Campus, 3rd Floor'), -- AI
(415, 'Friday', '14:30:00', '15:30:00', '303', 'North Campus, 3rd Floor'), -- SPM
(424, 'Friday', '15:30:00', '16:30:00', '303', 'North Campus, 3rd Floor'); -- FSD
-- Saturday Activity Points ignored

-- ---------------------------------
-- 5th Sem (Year 3) AI&ML 'E' (IDs: 430-444) [File: 5th Final, Page 5]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(430, 'Monday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- SPM
(440, 'Monday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- IR (ML2->IR)
(435, 'Monday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- ATC (NLP->ATC)
(431, 'Monday', '12:30:00', '13:30:00', '307', 'North Campus, 3rd Floor'), -- CN
(443, 'Monday', '14:30:00', '15:30:00', '307', 'North Campus, 3rd Floor'), -- EVS
(442, 'Monday', '15:30:00', '16:30:00', '307', 'North Campus, 3rd Floor'), -- RM
(444, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(441, 'Tuesday', '09:00:00', '11:00:00', NULL, 'Minor Project'),
(435, 'Tuesday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- ATC (NLP->ATC)
(430, 'Tuesday', '12:30:00', '13:30:00', '307', 'North Campus, 3rd Floor'), -- SPM
(432, 'Tuesday', '14:30:00', '16:30:00', 'CSLAB-1', 'CSE Dept'), -- E1 CN Lab
(437, 'Tuesday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'), -- E2 ML Lab
(439, 'Wednesday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- ML
(440, 'Wednesday', '10:00:00', '11:00:00', '310', 'North Campus, 3rd Floor'), -- IR
(435, 'Wednesday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- ATC (NLP->ATC)
(431, 'Wednesday', '12:30:00', '13:30:00', '307', 'North Campus, 3rd Floor'), -- CN
(433, 'Wednesday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- E2 CN Lab
(438, 'Wednesday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'), -- E3 ML Lab
(444, 'Wednesday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(439, 'Thursday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- ML
(440, 'Thursday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- IR
(435, 'Thursday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- ATC (NLP->ATC)
(439, 'Thursday', '12:30:00', '13:30:00', '309', 'North Campus, 3rd Floor'), -- ML
(436, 'Thursday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'), -- E1 ML Lab
(434, 'Thursday', '14:30:00', '16:30:00', 'CSLAB-8', 'CSE Dept'), -- E3 CN Lab
(435, 'Friday', '09:00:00', '11:00:00', '307', 'North Campus, 3rd Floor'), -- ATC Tutorial E
(430, 'Friday', '11:30:00', '12:30:00', '307', 'North Campus, 3rd Floor'), -- SPM
(431, 'Friday', '12:30:00', '13:30:00', '307', 'North Campus, 3rd Floor'), -- CN
(439, 'Friday', '14:30:00', '15:30:00', '307', 'North Campus, 3rd Floor'), -- ML
(442, 'Friday', '15:30:00', '16:30:00', '307', 'North Campus, 3rd Floor'); -- RM
-- Saturday Activity Points ignored

-- ---------------------------------
-- 5th Sem (Year 3) AI&ML 'F' (IDs: 445-459) [File: 5th Final, Page 6]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(454, 'Monday', '09:00:00', '10:00:00', '308', 'North Campus, 3rd Floor'), -- ML
(445, 'Monday', '10:00:00', '11:00:00', '308', 'North Campus, 3rd Floor'), -- SPM
(450, 'Monday', '11:30:00', '12:30:00', '308', 'North Campus, 3rd Floor'), -- ATC
(455, 'Monday', '12:30:00', '13:30:00', '308', 'North Campus, 3rd Floor'), -- IR
(448, 'Monday', '14:30:00', '16:30:00', 'CSLAB-1', 'CSE Dept'), -- F2 CN Lab
(451, 'Monday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'), -- F1 ML Lab
(459, 'Monday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(445, 'Tuesday', '09:00:00', '10:00:00', '308', 'North Campus, 3rd Floor'), -- SPM
(455, 'Tuesday', '10:00:00', '11:00:00', '308', 'North Campus, 3rd Floor'), -- IR
(446, 'Tuesday', '11:30:00', '12:30:00', '308', 'North Campus, 3rd Floor'), -- CN
(458, 'Tuesday', '12:30:00', '13:30:00', '308', 'North Campus, 3rd Floor'), -- EVS
(450, 'Tuesday', '14:30:00', '16:30:00', '308', 'North Campus, 3rd Floor'), -- ATC F Tutorial
(446, 'Wednesday', '09:00:00', '10:00:00', '308', 'North Campus, 3rd Floor'), -- CN
(450, 'Wednesday', '10:00:00', '11:00:00', '308', 'North Campus, 3rd Floor'), -- ATC
(456, 'Wednesday', '11:30:00', '13:30:00', NULL, 'Minor project'),
(459, 'Wednesday', '16:30:00', '17:30:00', NULL, 'NSS/YOGA/PE'),
(457, 'Thursday', '09:00:00', '10:00:00', '308', 'North Campus, 3rd Floor'), -- RM
(454, 'Thursday', '10:00:00', '11:00:00', '308', 'North Campus, 3rd Floor'), -- ML
(455, 'Thursday', '11:30:00', '12:30:00', '308', 'North Campus, 3rd Floor'), -- IR
(445, 'Thursday', '12:30:00', '13:30:00', '308', 'North Campus, 3rd Floor'), -- SPM
(447, 'Thursday', '14:30:00', '16:30:00', 'CSLAB-1', 'CSE Dept'), -- F1 CN Lab
(453, 'Thursday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'), -- F3 ML Lab
(450, 'Friday', '09:00:00', '10:00:00', '308', 'North Campus, 3rd Floor'), -- ATC
(454, 'Friday', '10:00:00', '11:00:00', '308', 'North Campus, 3rd Floor'), -- ML
(446, 'Friday', '11:30:00', '12:30:00', '308', 'North Campus, 3rd Floor'), -- CN
(457, 'Friday', '12:30:00', '13:30:00', '308', 'North Campus, 3rd Floor'), -- RM
(449, 'Friday', '14:30:00', '16:30:00', 'CSLAB-1', 'CSE Dept'), -- F3 CN Lab
(452, 'Friday', '14:30:00', '16:30:00', 'AIML LAB-4', 'AI&ML Dept'); -- F2 ML Lab
-- Saturday Activity Points ignored

-- ---------------------------------
-- 7th Sem (Year 4) CSE 'A' (IDs: 460-468) [File: 7th sem, Page 1]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(467, 'Monday', '09:00:00', '10:00:00', '304', 'North Campus, 3rd Floor'), -- OE
(460, 'Monday', '10:00:00', '11:00:00', '304', 'North Campus, 3rd Floor'), -- CNS
(462, 'Monday', '11:30:00', '13:30:00', NULL, 'PC Lab A1'),
(463, 'Monday', '14:30:00', '16:30:00', NULL, 'PC Lab A2'),
(467, 'Tuesday', '09:00:00', '10:00:00', '304', 'North Campus, 3rd Floor'), -- OE
(464, 'Tuesday', '10:00:00', '11:00:00', '304', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(460, 'Tuesday', '11:30:00', '12:30:00', '304', 'North Campus, 3rd Floor'), -- CNS
(461, 'Tuesday', '12:30:00', '13:30:00', '304', 'North Campus, 3rd Floor'), -- PC
(467, 'Wednesday', '09:00:00', '10:00:00', '304', 'North Campus, 3rd Floor'), -- OE
(464, 'Wednesday', '10:00:00', '11:00:00', '304', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(460, 'Wednesday', '11:30:00', '12:30:00', '304', 'North Campus, 3rd Floor'), -- CNS
(461, 'Wednesday', '12:30:00', '13:30:00', '304', 'North Campus, 3rd Floor'), -- PC
(461, 'Thursday', '09:00:00', '10:00:00', '304', 'North Campus, 3rd Floor'), -- PC
(464, 'Thursday', '10:00:00', '11:00:00', '304', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(460, 'Thursday', '11:30:00', '12:30:00', '304', 'North Campus, 3rd Floor'); -- CNS
-- Friday empty in grid
-- Assuming Major Project (468) happens outside these hours

-- ---------------------------------
-- 7th Sem (Year 4) CSE 'B' (IDs: 469-477) [File: 7th sem, Page 2]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(476, 'Monday', '09:00:00', '10:00:00', '305', 'North Campus, 3rd Floor'), -- OE
(470, 'Monday', '10:00:00', '11:00:00', '305', 'North Campus, 3rd Floor'), -- PC
(469, 'Monday', '11:30:00', '12:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(476, 'Tuesday', '09:00:00', '10:00:00', '305', 'North Campus, 3rd Floor'), -- OE
(473, 'Tuesday', '10:00:00', '11:00:00', '305', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(471, 'Tuesday', '11:30:00', '13:30:00', NULL, 'PC Lab B1'),
(469, 'Tuesday', '14:30:00', '15:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(476, 'Wednesday', '09:00:00', '10:00:00', '305', 'North Campus, 3rd Floor'), -- OE
(473, 'Wednesday', '10:00:00', '11:00:00', '305', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(469, 'Wednesday', '11:30:00', '12:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(470, 'Wednesday', '12:30:00', '13:30:00', '305', 'North Campus, 3rd Floor'), -- PC
(469, 'Wednesday', '14:30:00', '15:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(470, 'Thursday', '09:00:00', '10:00:00', '305', 'North Campus, 3rd Floor'), -- PC
(473, 'Thursday', '10:00:00', '11:00:00', '305', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(472, 'Thursday', '11:30:00', '13:30:00', NULL, 'PC Lab B2');
-- Friday empty in grid
-- Assuming Major Project (477) happens outside these hours

-- ---------------------------------
-- 7th Sem (Year 4) CSE 'C' (IDs: 478-486) [File: 7th sem, Page 3]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(485, 'Monday', '09:00:00', '10:00:00', '306', 'North Campus, 3rd Floor'), -- OE
(478, 'Monday', '10:00:00', '11:00:00', '306', 'North Campus, 3rd Floor'), -- CNS
(479, 'Monday', '11:30:00', '12:30:00', '306', 'North Campus, 3rd Floor'), -- PC
(480, 'Monday', '15:30:00', '17:30:00', NULL, 'PC Lab C1'),
(485, 'Tuesday', '09:00:00', '10:00:00', '306', 'North Campus, 3rd Floor'), -- OE misspelled OF
(482, 'Tuesday', '10:00:00', '11:00:00', '306', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(478, 'Tuesday', '11:30:00', '12:30:00', '306', 'North Campus, 3rd Floor'), -- CNS
(479, 'Tuesday', '15:30:00', '16:30:00', '306', 'North Campus, 3rd Floor'), -- PC
(485, 'Wednesday', '09:00:00', '10:00:00', '306', 'North Campus, 3rd Floor'), -- OE
(482, 'Wednesday', '10:00:00', '11:00:00', '306', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(478, 'Wednesday', '11:30:00', '12:30:00', '306', 'North Campus, 3rd Floor'), -- CNS
(479, 'Wednesday', '12:30:00', '13:30:00', '306', 'North Campus, 3rd Floor'), -- PC
(481, 'Wednesday', '14:30:00', '16:30:00', NULL, 'PC Lab C2'),
(482, 'Thursday', '10:00:00', '11:00:00', '306', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(478, 'Thursday', '11:30:00', '12:30:00', '306', 'North Campus, 3rd Floor'); -- CNS
-- Friday empty in grid
-- Assuming Major Project (486) happens outside these hours

-- ---------------------------------
-- 7th Sem (Year 4) CSE 'D' (IDs: 487-495) [File: 7th sem, Page 4]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(494, 'Monday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- OE
(487, 'Monday', '10:00:00', '11:00:00', '309', 'North Campus, 3rd Floor'), -- CNS
(488, 'Monday', '11:30:00', '12:30:00', '304', 'North Campus, 3rd Floor'), -- PC
(494, 'Tuesday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- OE
(491, 'Tuesday', '10:00:00', '11:00:00', '309', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(487, 'Tuesday', '11:30:00', '12:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(488, 'Tuesday', '12:30:00', '13:30:00', '305', 'North Campus, 3rd Floor'), -- PC
(494, 'Wednesday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- OE
(491, 'Wednesday', '10:00:00', '11:00:00', '309', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(489, 'Wednesday', '11:30:00', '13:30:00', NULL, 'PC Lab D1'),
(487, 'Thursday', '09:00:00', '10:00:00', '309', 'North Campus, 3rd Floor'), -- CNS
(491, 'Thursday', '10:00:00', '11:00:00', '309', 'North Campus, 3rd Floor'), -- PE (BCS713A)
-- (No separate slot needed for BCS713C/D unless room changes)
(487, 'Thursday', '11:30:00', '12:30:00', '305', 'North Campus, 3rd Floor'), -- CNS
(488, 'Thursday', '12:30:00', '13:30:00', '305', 'North Campus, 3rd Floor'), -- PC
(490, 'Thursday', '15:30:00', '17:30:00', NULL, 'PC Lab D2');
-- Friday empty in grid
-- Assuming Major Project (495) happens outside these hours

-- ---------------------------------
-- 7th Sem (Year 4) AI&ML 'E' (IDs: 496-504) [File: 7th sem, Page 5]
-- ---------------------------------
INSERT INTO timetable_slots (class_id, day_of_week, start_time, end_time, room_no, location) VALUES
(503, 'Monday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- OE
(499, 'Monday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- ML2
(496, 'Monday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- NLP
(497, 'Monday', '14:30:00', '16:30:00', '309', 'North Campus, 3rd Floor'), -- NLP tutorial E1
(503, 'Tuesday', '09:00:00', '10:00:00', '310', 'North Campus, 3rd Floor'), -- OE
(502, 'Tuesday', '10:00:00', '11:00:00', '310', 'North Campus, 3rd Floor'), -- PE (Big Data)
(496, 'Tuesday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- NLP
(500, 'Tuesday', '14:30:00', '16:30:00', NULL, 'ML2 LAB E1'),
(503, 'Wednesday', '09:00:00', '10:00:00', '303', 'North Campus, 3rd Floor'), -- OE
(502, 'Wednesday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- PE (Big Data)
(499, 'Wednesday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- ML2
(501, 'Wednesday', '14:30:00', '16:30:00', NULL, 'ML2 LAB E2'),
(502, 'Thursday', '10:00:00', '11:00:00', '303', 'North Campus, 3rd Floor'), -- PE (Big Data)
(496, 'Thursday', '11:30:00', '12:30:00', '309', 'North Campus, 3rd Floor'), -- NLP
(499, 'Thursday', '12:30:00', '13:30:00', '309', 'North Campus, 3rd Floor'), -- ML2
(498, 'Thursday', '14:30:00', '16:30:00', '309', 'North Campus, 3rd Floor');

-- ... (Continue this for ALL 22 sections, manually transcribing from PDFs) ...
-- ... (This is a very large manual data entry task) ...

-- =================================================================
-- 9. ADD DEPARTMENT COLUMN AND UPDATE FACULTY
-- =================================================================

-- Add department column
ALTER TABLE faculty ADD COLUMN department VARCHAR(100);

-- Fix study_year for 3rd Sem (should be 2) - This uses class_id ranges
UPDATE classes SET study_year = 2 WHERE class_id BETWEEN 121 AND 309;

-- Update faculty departments
UPDATE faculty SET department = 'Mathematics' WHERE id IN (1, 14, 23, 33, 36, 39, 44, 54, 61, 63);
UPDATE faculty SET department = 'Physics' WHERE id IN (2, 9, 15, 19, 24);
UPDATE faculty SET department = 'Mechanical Engineering' WHERE id IN (3, 4, 5, 10, 16, 17, 20, 21, 25, 26);
UPDATE faculty SET department = 'Electronics & Communication' WHERE id IN (6, 11);
UPDATE faculty SET department = 'Computer Science & Engineering' WHERE id IN (7, 12, 18, 22, 27, 29, 30, 35, 37, 38, 41, 43, 45, 46, 47, 48, 49, 50, 51, 52, 53, 55, 56, 57, 58, 59, 60, 62, 64, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 106, 107, 112, 113, 114, 116, 117, 118, 119);
UPDATE faculty SET department = 'Humanities' WHERE id IN (8, 13, 31, 32);
UPDATE faculty SET department = 'Chemistry' WHERE id IN (28, 34, 40, 42);
UPDATE faculty SET department = 'Information Science & Engineering' WHERE id IN (65, 66, 67, 68, 69, 70, 71, 73, 74, 75, 76, 77, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90);
UPDATE faculty SET department = 'Civil Engineering' WHERE id IN (72, 78, 97);

-- 10. UPDATE FACULTY OFFICE LOCATIONS
UPDATE faculty SET office_location = 'Autonomous Cell' WHERE name LIKE '%Vanamala%' OR name LIKE '%Suhaas KP%';
UPDATE faculty SET office_location = 'Dean Staff Room 2 - 3rd Floor Lab Building' WHERE name LIKE '%Nandini B M%' OR name LIKE '%Rajeshwari D%' OR name LIKE '%Shashank D%' OR name LIKE '%Meghana NR%' OR name LIKE '%Padma MT%';
UPDATE faculty SET office_location = 'Staff Room 1 - 1st Floor Lab Building' WHERE name LIKE '%Prathibha B S%' OR name LIKE '%CN Chinnaswamy%' OR name LIKE '%Prajakta M%' OR name LIKE '%P Devaki%' OR name LIKE '%K Raghuveer%' OR name LIKE '%Rampur Srinath%';
UPDATE faculty SET office_location = 'CSE Staff Room - 2nd Floor Lab Building' WHERE name LIKE '%Bhat Geetalaxmi Jairam%';
UPDATE faculty SET office_location = 'CSE Staff Room 1 - 1st Floor Lab Building' WHERE name LIKE '%Sumana K M%' OR name LIKE '%Amruthashree VM%' OR name LIKE '%Smitha B%' OR name LIKE '%Mahe Mubeen Akthar%' OR name LIKE '%Priyanka R V%' OR name LIKE '%Padmini M S%' OR name LIKE '%Usha K Patil%' OR name LIKE '%Veena Mohan%' OR name LIKE '%Chaithra M%' OR name LIKE '%Nithya M R%' OR name LIKE '%Vidya N L%' OR name LIKE '%Savitha S Sridharmurthy%' OR name LIKE '%Divyashree R%';
UPDATE faculty SET office_location = 'CSE Staff Room 1 - 2nd Floor Lab Building' WHERE name LIKE '%Rashmi.M. R%' OR name LIKE '%Narender M%' OR name LIKE '%Shabana Sultana%' OR name LIKE '%Lokesh S%' OR name LIKE '%C Vidya Raj%' OR name LIKE '%V K Annapurna%' OR name LIKE '%Jayasri B S%';
-- Update remaining faculty from that list (assuming CSE Staff Room 1, 1st floor)
UPDATE faculty SET office_location = 'CSE Staff Room 1 - 1st Floor Lab Building'
WHERE name IN ('Mr. Gowtham R Naik', 'Mr. Mahesha A M', 'Mrs. Padmavathi K', 'Mr. Balaji V', 'Dr. Naveen S Pagad', 'Mr. Janardhana Swamy G B', 'Ms. Soujanya K V', 'Mr. Sumanth CM');

SELECT id, name FROM faculty;
