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
/****** Object:  StoredProcedure [dbo].[initGame]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[initGame]
GO
/****** Object:  StoredProcedure [dbo].[initGame]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[initGame]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[initGame] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	inicjuje wystapienie struktur saperskich, @saperBoardLength okresla dlugosc boku planszy, default = 10, difficulty - stopnie 1-5
-- =============================================
ALTER PROCEDURE [dbo].[initGame]
	@saperBoardLength int = 10,
	@difficulty int = 3
AS
BEGIN
	SET NOCOUNT ON;

	if(@saperBoardLength < 5)
	begin
		print(N'długość planszy nie mże być mniejsza niż 5');
		return;
	end;

    exec dbo._clearStructs;

	declare @diffFactor float = @difficulty * 0.1;
	insert into gamemeta (BoardLength, FlagChar, Difficulty) select @saperBoardLength, 'M', @diffFactor;

	declare @i int = 1;
	
	declare @slotCount int = @saperBoardLength * @saperBoardLength;
	while (@i <= @slotCount)
	begin
		insert into gameboard (SlotId, SlotX, SlotY) 
		values (
			@i, 
			dbo._idToX(@i, @saperBoardLength), 
			dbo._idToY(@i, @saperBoardLength)
		);
		set @i = @i + 1;
	end;
	
	exec dbo._printBoard;

	print(N'exec strikeSlot @slotX, @slotY by wykonać ruch. ? w polu oznacza pole nieodkryte. Powodzenia!');
END
GO
