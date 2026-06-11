USE LibraryDB;
GO

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

-- Test Trigger
UPDATE Borrowing SET ReturnDate = '2025-06-20' WHERE BorrowID = 1;
SELECT * FROM Borrowing;
GO