CREATE TABLE [dbo].[Todo]
(
	[Id] INT NOT NULL PRIMARY KEY,
    [Description] VARCHAR(50) NOT NULL,
    [Completed] BIT NOT NULL DEFAULT 0
)
