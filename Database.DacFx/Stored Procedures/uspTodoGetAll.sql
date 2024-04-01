CREATE PROCEDURE [dbo].[uspTodoGetAll]
AS
	SELECT
		Id,
		[Description],
		Completed,
		[DateModified]
	FROM
		Todo
