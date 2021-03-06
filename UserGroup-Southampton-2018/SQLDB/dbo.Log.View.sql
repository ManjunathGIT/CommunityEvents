USE [sdbamsdapdev001]
GO
/****** Object:  View [dbo].[Log]    Script Date: 06/06/2018 14:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Log]
AS


SELECT
	ll.[LogId],
	o.[ObjectName],
	ll.[Status],
	ll.[LogDate]
 FROM 
	[dbo].[LoadingLog] ll
	INNER JOIN [metadata].[Objects] o
		ON ll.[ObjectId] = o.[ObjectId]
GO
