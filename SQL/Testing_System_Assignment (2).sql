DROP DATABASE IF EXISTS QUAN_LY_BAI_THI;
create database QUAN_LY_BAI_THI;
use QUAN_LY_BAI_THI;
-- bảng khai báo phòng ban--
CREATE TABLE department (
    department_id 		TINYINT UNSIGNED PRIMARY KEY,
    department_name 	NVARCHAR(50) UNIQUE KEY NOT NULL 
);
--  bảng chức vụ --
CREATE TABLE position (
    position_id 		TINYINT UNSIGNED PRIMARY KEY,
    position_name 		ENUM('Dev', 'Test',' Scrum Master ',' PM') NOT NULL UNIQUE KEY
);
-- bảng báo tài khoản--
CREATE TABLE `account` (
    account_id		TINYINT UNSIGNED PRIMARY KEY,
    email 			VARCHAR(50) UNIQUE KEY NOT NULL,
    username 		VARCHAR(50) UNIQUE KEY NOT NULL,
    fullname		VARCHAR(50)	NOT NULL,
    department_id	TINYINT UNSIGNED NOT NULL,
    position_id 	TINYINT UNSIGNED NOT NULL,
    create_date		DATETIME DEFAULT NOW(),
    FOREIGN KEY(department_id) REFERENCES department (department_id),
    FOREIGN KEY(position_id) REFERENCES position (position_id)
);
-- bảng tạo group--
CREATE TABLE `group` (
    group_id 			TINYINT UNSIGNED PRIMARY KEY,
    group_name			VARCHAR(50) NOT NULL UNIQUE KEY,
    creator_id			TINYINT UNSIGNED NOT NULL,
    creat_date			DATETIME DEFAULT NOW()
);
-- bảng khai báo nhóm--
CREATE TABLE groupaccount (
    groupid			 	TINYINT UNSIGNED UNIQUE KEY NOT NULL,
    accountid			TINYINT UNIQUE KEY NOT NULL,
    joindate			DATETIME DEFAULT NOW()
);
-- loại câu hỏi --
CREATE TABLE typequesition (
    type_id			TINYINT UNSIGNED PRIMARY KEY,
    type_name 		VARCHAR(50) NOT NULL UNIQUE KEY
);
-- chủ đề câu hỏi --
CREATE TABLE categoryquestion (
    category_id		TINYINT	UNSIGNED PRIMARY KEY,
    category_name	VARCHAR(50) NOT NULL UNIQUE KEY
);
-- định danh câu hỏi--
CREATE TABLE question (
    question_id 		TINYINT UNSIGNED PRIMARY KEY,
    content				VARCHAR(100) NOT NULL UNIQUE KEY,
    category_id			TINYINT UNSIGNED NOT NULL,
    type_id				TINYINT UNSIGNED NOT NULL,
    creator_id			TINYINT UNSIGNED NOT NULL UNIQUE KEY,
    create_date			DATETIME,
    FOREIGN KEY(category_id) REFERENCES categoryquestion(category_id),
    FOREIGN KEY(type_id) REFERENCES typequesition(type_id)
);
-- câu trả lời --
CREATE TABLE answer (
    answer_id			TINYINT UNSIGNED NOT NULL,
    content				VARCHAR(200) NOT NULL,
    question_id 		TINYINT UNSIGNED NOT NULL,
    iscorrect 			ENUM('đúng','sai') NOT NULL,
    PRIMARY KEY (answer_id,question_id),
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
-- đề thi --
CREATE TABLE exam (
    exam_id 			TINYINT UNSIGNED PRIMARY KEY,
    `code`				VARCHAR(50) UNIQUE KEY NOT NULL,
    title				VARCHAR(50) UNIQUE KEY NOT NULL,
    Category_ID			TINYINT UNSIGNED UNIQUE KEY NOT NULL,
    duration			DATETIME NOT NULL,
    creator_id			TINYINT UNSIGNED UNIQUE NOT NULL,
    create_date			DATETIME DEFAULT NOW(),
    FOREIGN KEY(Category_ID) REFERENCES CategoryQuestion(Category_ID),
    FOREIGN KEY(Creator_id) 	REFERENCES `Account`(Account_ID)
);
-- bảng đề thi --
CREATE TABLE examquestion (
    exam_id 		TINYINT UNSIGNED NOT NULL,
    question_id 	TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(exam_id) REFERENCES exam(exam_id),
    FOREIGN KEY(question_id) REFERENCES question(question_id)
);
insert into Department(department_id,department_name)
Values
 (1, N'Marketing'),
 (2, N'Bán hàng'),
 (3, N'Bảo vệ'),
 (4, N'Nhân sự'),
 (5, N'Kỹ thuật');

insert into Position (Position_name)
Values
(n'Dev'),
(n'Test'),
(n'Scrum master'),
(n'pm');
-- 3
insert into Account (Email, Username, FUllName, DepartmentID, PositionID, CreateDate)
Values
('abcxyz@gmail.com', 'abcxyz', 'Abc Xyz', 1, 1, 20200901),
('abcxyz2@gmail.com', 'abcxyz2', 'Abc Xyz2', 2, 2, 20200902),
('abcxyz3@gmail.com', 'abcxyz3', 'Abc Xyz3', 3, 3, 20200903),
('abcxyz4@gmail.com', 'abcxyz4', 'Abc Xyz4', 4, 4, 20200904),
('abcxyz5@gmail.com', 'abcxyz5', 'Abc Xyz5', 5, 5, 20200905);

-- 4
insert into `Group` (GroupName, CreatorID, CreateDate)
Values
('red',1,20200901),
('white',2,20200901),
('black',3,20200901),
('orange',4,20200901),
('green',5,20200901);

-- 5
insert into GroupAccount (GroupID, AccountID, JoinDate)
VALUES
(1,1,20200901),
(2,2,20200901),
(3,3,20200901),
(4,4,20200901),
(5,5,20200901);

insert into TypeQuestion (TypeName)
VALUEs
('Essay'),
('Multiple-Choice');

insert into CategoryQuestion (CategoryName)
Values
('Java'),
('NET'),
('SQL'),
('Postman'),
('Ruby');

insert into Question (Content, CategoryID, TypeID, CreatorID, CreateDate)
Values
(n'1+1 bằng mấy', 1,1,1,20200901),
(n'2+1 bằng mấy', 1,1,1,20200901),
(n'3+1 bằng mấy', 1,1,1,20200901),
(n'4+1 bằng mấy', 1,1,1,20200901),
(n'5+1 bằng mấy', 1,1,1,20200901);

insert into Answer (Content, QuestionID, isCorrect)
values
('2',1, 1),
(not '2',1, 0),
('3',2,1),
(not'3',2,0);


insert into Exam (Code, Title,CategoryID, Duration, CreatorID, CreateDate)
Values
(101, 'Thi Lần 1', 1, '1h',1,20200901),
(102, 'Thi Lần 2', 2, '1h',2,20200901),
(103, 'Thi Lần 3', 3, '1h',3,20200901),
(104, 'Thi Lần 4', 1, '1h',4,20200901),
(105, 'Thi Lần 5', 2, '1h',5,20200901);

insert into ExamQuestion (ExamID, QuestionID)
Values
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);
