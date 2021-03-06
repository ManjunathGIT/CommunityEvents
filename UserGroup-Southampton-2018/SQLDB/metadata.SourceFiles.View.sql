USE [sdbamsdapdev001]
GO
/****** Object:  View [metadata].[SourceFiles]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [metadata].[SourceFiles]
AS

SELECT
	o.[ObjectId] AS 'Id',
	o.[ObjectName] + '.' + ot.[ObjectTypeName] AS 'FileName',
	'ADFRoot\ForUpload\' + o.[ObjectPrefix] AS 'SourceFolder',
	'ADFDemo\Uploads\' + s.[SystemName] AS 'TargetFolder'
FROM
	[metadata].[Objects] o
	INNER JOIN [metadata].[Systems] s
		ON o.[SystemId] = s.[SystemId]
	INNER JOIN [metadata].[SystemTechnologies] st
		ON s.[SystemTechnologyId] = st.[SystemTechId]
	INNER JOIN [metadata].[ObjectTypes] ot
		ON o.[ObjectTypeId] = ot.[ObjectTypeId]
WHERE
	st.[TechnologyName] = 'File'
	AND s.[SystemName] = 'DemoSystem'
	AND o.[InUse] = 1

GO
