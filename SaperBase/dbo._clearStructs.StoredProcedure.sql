/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2016
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [SaperBase]
GO
/****** Object:  StoredProcedure [dbo].[_clearStructs]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[_clearStructs]
GO
/****** Object:  StoredProcedure [dbo].[_clearStructs]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_clearStructs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[_clearStructs] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	czyści struktury saperskie
-- =============================================
ALTER PROCEDURE [dbo].[_clearStructs]
AS
BEGIN
	SET NOCOUNT ON;

	if OBJECT_ID(N'dbo.gamemeta', N'U') is not null
	begin
		if(dbo._isDebugMode() > 0)
			return;

		truncate table gamemeta;
	end;

    if OBJECT_ID(N'dbo.gameboard', N'U') is not null
	begin
		truncate table gameboard;
	end;
END
GO
