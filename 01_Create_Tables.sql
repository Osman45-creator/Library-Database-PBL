CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);
GO

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublicationYear INT,
    Price DECIMAL(10,2),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID)
);
GO

CREATE TABLE Member (
    MemberID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    JoinDate DATE NOT NULL,
    MemberType VARCHAR(10) CHECK (MemberType IN ('Student', 'Teacher'))
);
GO

CREATE TABLE Student (
    MemberID INT PRIMARY KEY FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
    StudentID VARCHAR(20) UNIQUE NOT NULL,
    Semester INT CHECK (Semester BETWEEN 1 AND 8)
);
GO

CREATE TABLE Teacher (
    MemberID INT PRIMARY KEY FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
    TeacherID VARCHAR(20) UNIQUE NOT NULL,
    Department VARCHAR(50)
);
GO

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

CREATE TABLE Borrowing (
    BorrowID INT PRIMARY KEY,
    MemberID INT FOREIGN KEY REFERENCES Member(MemberID),
    BookID INT FOREIGN KEY REFERENCES Book(BookID),
    StaffID INT FOREIGN KEY REFERENCES Staff(StaffID),
    BorrowDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    FineAmount DECIMAL(10,2) DEFAULT 0
);
GO