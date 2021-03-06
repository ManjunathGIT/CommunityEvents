USE [sdbamsdapdev001]
GO
/****** Object:  StoredProcedure [metadata].[GetUSQLStoredProcedureFile]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [metadata].[GetUSQLStoredProcedureFile]
	(
	@DataFlowName VARCHAR(255),
	@USQL NVARCHAR(MAX) OUTPUT,
	@DebugMode BIT = 0
	)
AS
BEGIN
	/*for development:
	DECLARE @DataFlowName VARCHAR(255) = 'PatientsRawToBase'
	DECLARE @USQL NVARCHAR(MAX) 
	DECLARE @DebugMode BIT = 1
	*/

	IF NOT EXISTS
		(
		SELECT * FROM [metadata].[DataFlows] WHERE [DataFlowName] = @DataFlowName
		)
		BEGIN
			RAISERROR('Invalid data flow name provided.',16,1);
			RETURN;
		END

	SELECT
		@USQL = 
'/*
Adatis - Auto Generated USQL File

File Generated Date: <##CodeRefreshDate##>
*/
' + CHAR(13) + [Script] + CHAR(13) + '[' + [dbo].[GetProperty]('TransformationSchema') + '].[' + @DataFlowName + ']();
		',
		@USQL = REPLACE(@USQL,'<##TransformationDB##>',[dbo].[GetProperty]('TransformationDB')),
		@USQL = REPLACE(@USQL,'<##CodeRefreshDate##>',CONVERT(VARCHAR,GETDATE(),103))
	FROM
		[metadata].[ScriptParts]
	WHERE
		[ScriptName] = 'UseDatabase'
	
	IF @DebugMode = 1 EXEC [dbo].[usp_PrintBig] @USQL

END
GO
