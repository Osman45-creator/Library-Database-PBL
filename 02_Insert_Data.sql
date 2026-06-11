USE LibraryDB;
GO

INSERT INTO Category VALUES
(1, 'Fiction'), (2, 'Technology'), (3, 'Science'), (4, 'History'), (5, 'Literature');
GO

INSERT INTO Book VALUES
(101, 'Clean Code', '978-0-13-235088-4', 2008, 1200, 2),
(102, '1984', '978-0-452-28423-4', 1949, 420, 1),
(103, 'Sapiens', '978-0-06-231609-7', 2011, 850, 3),
(104, 'Pakistan: A Hard Country', '978-1-61039-021-7', 2011, 700, 4),
(105, 'The Great Gatsby', '978-0-7432-7356-5', 1925, 450, 5);
GO

INSERT INTO Member VALUES
(1, 'Usman', 'usman@email.com', '03001234567', 'Lahore', '2024-01-15', 'Student'),
(2, 'Member2', 'member2@email.com', '03001234568', 'Karachi', '2024-02-10', 'Student'),
(3, 'Member3', 'member3@email.com', '03001234569', 'Islamabad', '2024-03-05', 'Teacher');
GO

INSERT INTO Student VALUES
(1, 'STU001', 3),
(2, 'STU002', 5);
GO

INSERT INTO Teacher VALUES
(3, 'TCH001', 'Computer Science');
GO

INSERT INTO Staff VALUES
(1, 'Usman Librarian', 'Librarian', 50000),
(2, 'Ali Assistant', 'Assistant', 35000);
GO

INSERT INTO Borrowing VALUES
(1, 1, 101, 1, '2025-06-01', '2025-06-15', NULL, 0),
(2, 2, 102, 2, '2025-06-02', '2025-06-16', '2025-06-14', 0),
(3, 3, 103, 1, '2025-06-03', '2025-06-17', NULL, 0);
GO