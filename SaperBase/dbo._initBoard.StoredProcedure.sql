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
/****** Object:  StoredProcedure [dbo].[_initBoard]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[_initBoard]
GO
/****** Object:  StoredProcedure [dbo].[_initBoard]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_initBoard]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[_initBoard] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	inicjuje wystapienie struktur saperskich, @saperBoardLength okresla dlugosc boku planszy, default = 10
-- =============================================
ALTER PROCEDURE [dbo].[_initBoard]
	@boardLength int,
	@clearSlotX int,
	@clearSlotY int
AS
BEGIN
	SET NOCOUNT ON;

	declare @difficulty float = 
		(select Top(1) (case
			when Difficulty >= 0.5 then 0.49
			when Difficulty <= 0.1 then 0.1
			else 0.3
			end) 
		from gamemeta
		order by GameId desc)

	-- ustawia bomby
	update gameboard
	set Bomb = 
	(case 
		when rand(checksum(newid())) <= @difficulty then 1
		else 0
	end);
	--where SlotX <> @clearSlotX or SlotY <> @clearSlotY;

	update gameboard 
	set Bomb = 0
	where SlotX = @clearSlotX and SlotY = @clearSlotY;

	--zlicza ilosci przylegajacych bomb
	declare @i int = (select min(SlotId) from gameboard);
	declare @x int = @i;
	declare @y int = @i;

	declare @slotCount int = @boardLength * @boardLength;
	while (@i <= @slotCount)
	begin
		declare @bombCount int;
		set @bombCount = 
			(select count(*) from dbo._getSlotsInVicinity(@x, @y, 1)
			where Bomb = 1);
		
		update gameboard
		set SurroundingBombs = @bombCount
		where SlotId = @i;

		set @i = @i + 1;
		set @x = dbo._idToX(@i, @boardLength);
		set @y = dbo._idToY(@i, @boardLength);
	end;
END
GO
