USE LibraryDB;
GO

-- Query 1: Active Borrowings (Join)
SELECT b.BorrowID, m.Name, bk.Title, b.BorrowDate, b.DueDate
FROM Borrowing b
JOIN Member m ON b.MemberID = m.MemberID
JOIN Book bk ON b.BookID = bk.BookID
WHERE b.ReturnDate IS NULL;
GO

-- Query 2: Total Borrowed per Member (Aggregation)
SELECT m.Name, COUNT(b.BorrowID) AS TotalBorrowed
FROM Member m
LEFT JOIN Borrowing b ON m.MemberID = b.MemberID
GROUP BY m.Name;
GO

-- Query 3: Books borrowed more than once (Subquery)
SELECT Title FROM Book
WHERE BookID IN (
    SELECT BookID FROM Borrowing
    GROUP BY BookID HAVING COUNT(*) > 1
);
GO