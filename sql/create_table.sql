-- 1 Department 部门
CREATE TABLE tbl_exam_department (
  ID   INT PRIMARY KEY,
  Name VARCHAR(255) NULL
);

-- 2 User 用户
-- 外键 2.1 多个用户属于一个部门 User 添加 Depart_ID 作为外键
CREATE TABLE tbl_exam_user (
  ID            INT PRIMARY KEY,
  Name          VARCHAR(255) NULL,
  Password      VARCHAR(255) NULL,
  Telephone     VARCHAR(255) NULL,
  Gender        VARCHAR(255) NULL,
  Age           INT    NULL,
  Department_ID INT REFERENCES tbl_exam_department (ID)
  -- 设置外键较好的方式
  -- 这样可以自定义外键的名字
  -- Department_id INT,
  -- CONSTRAINT fk_user_department FOREIGN KEY (Department_id) REFERENCES tbl_exam_department (ID)
);

-- 3 Paper 试卷
-- 外键 3.1 多个试卷属于一个部门出的 Paper 添加 Depart_ID 作为外键
-- 外键 3.2 多个试卷属于一个用户出的 Paper 添加 User_ID 作为外键
CREATE TABLE tbl_exam_paper (
  ID                 INT PRIMARY KEY,
  Type               VARCHAR(255)    NULL,
  Title              VARCHAR(255)    NULL,
  Description        VARCHAR(255)    NULL,
  TotalPoints        INT       NULL,
  CreateTime         DATE             NULL,
  AnswerQuestionTime DOUBLE PRECISION NULL,
  Department_ID      INT REFERENCES tbl_exam_department (ID),
  User_ID            INT REFERENCES tbl_exam_user (ID)
);

-- 4 Topic 知识点
-- 外键 4.1
-- 多个知识点属于一个部门出的
-- Topic 添加 Depart_ID 作为外键
CREATE TABLE tbl_exam_topic (
  ID            INT PRIMARY KEY,
  Title         VARCHAR(255) NULL,
  Department_ID INT REFERENCES tbl_exam_department (ID)
);

-- 5 SubjectType 题目类型
CREATE TABLE tbl_exam_subjecttype (
  ID       INT PRIMARY KEY,
  Name     VARCHAR(255) NULL,
  RealName VARCHAR(255) NULL
);

-- 6 SubjectLevel 题目难度
CREATE TABLE tbl_exam_subjectlevel (
  ID       INT PRIMARY KEY,
  Name     VARCHAR(255) NULL,
  RealName VARCHAR(255) NULL
);

-- 7 Subject 题目
-- 外键 7.1 多个题目属于一个用户出的  Subject 添加 User_ID 作为外键
-- 外键 7.2 多个题目属于一个部门出的  Subject 添加 Depart_ID 作为外键
-- 外键 7.3 多个题目属于一个的知识点  Subject 添加 Topic_ID 作为外键
-- 外键 7.4 多个题目属于一个题目类型  Subject 添加 SubjectType_ID 作为外键
-- 外键 7.5 多个题目属于一个题目难度  Subject 添加 SubjectLevel_ID 作为外键
CREATE TABLE tbl_exam_subject (
  ID              INT PRIMARY KEY,
  Stem            VARCHAR(255) NULL,
  UploadTime      DATE          NULL,
  Answer          VARCHAR(255) NULL,
  Analysis        VARCHAR(255) NULL,
  CheckState      VARCHAR(255) NULL,
  User_ID         INT REFERENCES tbl_exam_user (ID),
  Department_ID   INT REFERENCES tbl_exam_department (ID),
  Topic_ID        INT REFERENCES tbl_exam_topic (ID),
  SubjectType_ID  INT REFERENCES tbl_exam_subjecttype (ID),
  SubjectLevel_ID INT REFERENCES tbl_exam_subjectlevel (ID)
);

-- 8 Choice 选项
-- 外键 8.1 多个选项属于一个题目  Choice 添加 Subject_ID 作为外键
CREATE TABLE tbl_exam_choice (
  ID         INT PRIMARY KEY,
  Content    VARCHAR(255) NULL,
  Correct    INT     NULL,
  Subject_ID INT REFERENCES tbl_exam_subject (ID)
);

-- 9 PaperSubject 桥表
-- 外键 9.1 桥表添加 Paper_ID 作为外键
-- 外键 9.2 桥表添加 Subject_ID 作为外键
CREATE TABLE tbl_exam_papersubject (
  ID         INT PRIMARY KEY,
  Score      INT,
  Paper_ID   INT REFERENCES tbl_exam_paper (ID),
  Subject_ID INT REFERENCES tbl_exam_subject (ID)
);
