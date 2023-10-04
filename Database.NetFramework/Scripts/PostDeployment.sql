/*
Seed initial data for testing
*/

PRINT 'Inserting data for Todos...'

SET IDENTITY_INSERT Todo ON
GO

INSERT INTO Todo
(Id, [Description], Completed)
VALUES
(1, 'Todo Task 1', 1),
(2, 'Todo Task 1', 0),
(3, 'Todo Task 1', 1),
(4, 'Todo Task 1', 1),
(5, 'Todo Task 1', 0),
(6, 'Todo Task 1', 0)
GO

SET IDENTITY_INSERT Todo OFF
GO

PRINT 'Inserting data for Todos...DONE'
