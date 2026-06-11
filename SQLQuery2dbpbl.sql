USE master;
GO

DROP DATABASE IF EXISTS LibraryDB;
GO

CREATE DATABASE LibraryDB;
GO

USE LibraryDB;
GO

-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);
GO

-- Book Table
CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublicationYear INT,
    Price DECIMAL(10,2),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID)
);
GO

-- Member Table
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

-- Student Table
CREATE TABLE Student (
    MemberID INT PRIMARY KEY FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
    StudentID VARCHAR(20) UNIQUE NOT NULL,
    Semester INT CHECK (Semester BETWEEN 1 AND 8)
);
GO

-- Teacher Table
CREATE TABLE Teacher (
    MemberID INT PRIMARY KEY FOREIGN KEY REFERENCES Member(MemberID) ON DELETE CASCADE,
    TeacherID VARCHAR(20) UNIQUE NOT NULL,
    Department VARCHAR(50)
);
GO

-- Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2)
);
GO

-- Borrowing Table
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

-- Insert Categories
INSERT INTO Category VALUES
(1, 'Fiction'), (2, 'Technology'), (3, 'Science'), (4, 'History'), (5, 'Literature');
GO

-- Insert Books
INSERT INTO Book VALUES
(101, 'Clean Code', '978-0-13-235088-4', 2008, 1200, 2),
(102, '1984', '978-0-452-28423-4', 1949, 420, 1),
(103, 'Sapiens', '978-0-06-231609-7', 2011, 850, 3),
(104, 'Pakistan: A Hard Country', '978-1-61039-021-7', 2011, 700, 4),
(105, 'The Great Gatsby', '978-0-7432-7356-5', 1925, 450, 5);
GO

-- Insert Members
INSERT INTO Member VALUES
(1, 'Usman', 'usman@email.com', '03001234567', 'Lahore', '2024-01-15', 'Student'),
(2, 'Member2', 'member2@email.com', '03001234568', 'Karachi', '2024-02-10', 'Student'),
(3, 'Member3', 'member3@email.com', '03001234569', 'Islamabad', '2024-03-05', 'Teacher');
GO

-- Insert Students
INSERT INTO Student VALUES
(1, 'STU001', 3),
(2, 'STU002', 5);
GO

-- Insert Teachers
INSERT INTO Teacher VALUES
(3, 'TCH001', 'Computer Science');
GO

-- Insert Staff
INSERT INTO Staff VALUES
(1, 'Usman Librarian', 'Librarian', 50000),
(2, 'Ali Assistant', 'Assistant', 35000);
GO

-- Insert Borrowings
INSERT INTO Borrowing VALUES
(1, 1, 101, 1, '2025-06-01', '2025-06-15', NULL, 0),
(2, 2, 102, 2, '2025-06-02', '2025-06-16', '2025-06-14', 0),
(3, 3, 103, 1, '2025-06-03', '2025-06-17', NULL, 0);
GO

-- Queries
SELECT b.BorrowID, m.Name, bk.Title, b.BorrowDate, b.DueDate
FROM Borrowing b
JOIN Member m ON b.MemberID = m.MemberID
JOIN Book bk ON b.BookID = bk.BookID
WHERE b.ReturnDate IS NULL;
GO

SELECT m.Name, COUNT(b.BorrowID) AS TotalBorrowed
FROM Member m
LEFT JOIN Borrowing b ON m.MemberID = b.MemberID
GROUP BY m.Name;
GO

-- View
CREATE VIEW vw_ActiveBorrowings AS
SELECT b.BorrowID, m.Name, bk.Title, b.DueDate
FROM Borrowing b
JOIN Member m ON b.MemberID = m.MemberID
JOIN Book bk ON b.BookID = bk.BookID
WHERE b.ReturnDate IS NULL;
GO

SELECT * FROM vw_ActiveBorrowings;
GO

-- Trigger
CREATE TRIGGER trg_CalculateFine
ON Borrowing
AFTER UPDATE
AS
BEGIN
    UPDATE Borrowing
    SET FineAmount = DATEDIFF(DAY, DueDate, ReturnDate) * 10
    WHERE ReturnDate > DueDate;
END;
GO