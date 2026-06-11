USE LibraryDB;
GO

CREATE VIEW vw_ActiveBorrowings AS
SELECT b.BorrowID, m.Name, bk.Title, b.DueDate
FROM Borrowing b
JOIN Member m ON b.MemberID = m.MemberID
JOIN Book bk ON b.BookID = bk.BookID
WHERE b.ReturnDate IS NULL;
GO

SELECT * FROM vw_ActiveBorrowings;
GO