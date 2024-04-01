CREATE PROCEDURE [dbo].[uspTodoGetAll]
AS
	SELECT
		Id,
		[Description],
		Completed
	FROM
		Todo
