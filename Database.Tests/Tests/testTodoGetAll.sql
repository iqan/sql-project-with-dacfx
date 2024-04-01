CREATE SCHEMA [testTodoGetAll]
    AUTHORIZATION [dbo];
GO
 
EXECUTE sp_addextendedproperty @name = N'tSQLt.TestClass', @value = 1, @level0type = N'SCHEMA', @level0name = N'testTodoGetAll';
GO

CREATE PROCEDURE testTodoGetAll.[SetUp]
AS
BEGIN
    PRINT 'Running setup for testTodoGetAll';
    EXEC tSQLt.FakeTable 'Todo';
END
GO

CREATE PROCEDURE testTodoGetAll.[test that it returns all todo items]
AS
BEGIN
  -------------------- ASSEMBLE --------------------
  CREATE TABLE [testTodoGetAll].[Actual] ( [Id] INT, [Description] VARCHAR(50), [Completed] BIT, [DateModified] DATETIME2 );
  CREATE TABLE [testTodoGetAll].[Expected] ( [Id] INT, [Description] VARCHAR(50), [Completed] BIT, [DateModified] DATETIME2 );

  INSERT INTO [dbo].[Todo] (Id, [Description], Completed, DateModified)
  VALUES
  (1, 'Do 123', 0, '2024-01-01 00:00:00'),
  (2, 'Clean 456', 0, '2024-01-01 00:00:00'),
  (3, 'Go to 789', 1, '2024-01-01 00:00:00');

  INSERT INTO [testTodoGetAll].[Expected]
  VALUES
  (1, 'Do 123', 0, '2024-01-01 00:00:00'),
  (2, 'Clean 456', 0, '2024-01-01 00:00:00'),
  (3, 'Go to 789', 1, '2024-01-01 00:00:00');

  --------------------  ACT   --------------------
  INSERT INTO [testTodoGetAll].[Actual] EXEC [dbo].[uspTodoGetAll];

  -------------------- ASSERT --------------------
  EXEC tSQLt.AssertEqualsTable '[testTodoGetAll].[Expected]','[testTodoGetAll].[Actual]';
END

GO