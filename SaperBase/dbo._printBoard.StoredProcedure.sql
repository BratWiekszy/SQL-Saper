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
/****** Object:  StoredProcedure [dbo].[_printBoard]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[_printBoard]
GO
/****** Object:  StoredProcedure [dbo].[_printBoard]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_printBoard]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[_printBoard] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	wyswietla plansze
-- =============================================
ALTER procedure [dbo].[_printBoard]
AS
BEGIN
	declare @boardLength int;
	declare @mineFlagChar char(3);

	select top (1) @boardLength = BoardLength, @mineFlagChar = FlagChar from gamemeta
	order by GameId desc;

	exec dbo._printBoardCustom @boardLength, @mineFlagChar;

	declare @struckCount int, @unminedCount int;
	
	select  @struckCount = sum(case Struck when 1 then 1 else 0 end), 
			@unminedCount = sum(case Bomb when 0 then 1 else 0 end) 
	from gameboard;

	print(N'odkryto '+ convert(char(3), @struckCount) +' na '+ convert(char(3), @unminedCount) +' pól');
END
GO
