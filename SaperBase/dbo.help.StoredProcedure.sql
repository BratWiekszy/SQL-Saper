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
/****** Object:  StoredProcedure [dbo].[help]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[help]
GO
/****** Object:  StoredProcedure [dbo].[help]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[help]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[help] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Description:	help 
-- =============================================
ALTER PROCEDURE [dbo].[help] 
AS
BEGIN
	--SET NOCOUNT ON;

    print(N'To je poradnik do sapera. By grać, zacznik od: '+char(13)+
	'exec initGame @saperBoardLength = 10, @difficulty = 3; minimalna szerokość planszy to 5, maksymalna 99, diffuculty jest w przedzialne 1-5, potem:' +char(13)+
	'exec strikeSlot x, y; gdzie x i y są liczbami zczytanymi z planszy, funkcja odkrywa dane. pole. Dodatkowo:' +char(13)+
	'exec flagSlot x, y, @customMineChar = ''M''; oznacza pole jako minę, znak miny jest konfigurowalny. By odznaczyć pole:' +char(13)+
	'exec unflagSlot x, y; Powodzenia!');
END
GO
