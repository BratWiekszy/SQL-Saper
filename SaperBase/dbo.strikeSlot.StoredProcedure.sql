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
/****** Object:  StoredProcedure [dbo].[strikeSlot]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[strikeSlot]
GO
/****** Object:  StoredProcedure [dbo].[strikeSlot]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[strikeSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[strikeSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje odkrycie pola o danych współrzędnych x, y (>= 1), inaczej ruch
-- =============================================
ALTER PROCEDURE [dbo].[strikeSlot]
	@slotXCoord int,
	@slotYCoord int
AS
BEGIN
	SET NOCOUNT ON;

    if ((select count(*) from gameboard) = 0)
	begin
		print(N'wywolaj initGame @saperBoardLength przez rozpoczęciem gry');
		return;
	end;

	declare @struck bit = 
		(select Top(1) Struck from gameboard
		where SlotX = @slotXCoord and SlotY = @slotYCoord);

	declare @boardLength int = 
		(select top(1) BoardLength from gamemeta
		order by GameId desc);

	if (@struck = 1)
	begin
		exec dbo._printBoard;

		print(N'to pole zostało już odkryte, spróbuj innego');
		return;
	end;

	if (@struck is null)
	begin
		print(N'wspolrzedne sa poza zakresem planszy');
		return;
	end;

	declare @isInitialized bit = 
		(select top(1) Initialized from gamemeta
		order by GameId desc);

	-- inicjalizacja planszy przy pierwszym ruchu
	if(@isInitialized = 0)
	begin
		exec dbo._initBoard @boardLength, @slotXCoord, @slotYCoord;

		update gamemeta 
		set Initialized = 1
		where GameId = (select max(GameId) from gamemeta);
	end;

	/*
	update gameboard
	set Struck = 1
	where SlotX = @slotXCoord and SlotY = @slotYCoord;*/

	declare @bomb bit = 
		(select Top(1) Bomb from gameboard
		where SlotX = @slotXCoord and SlotY = @slotYCoord);

	if(@bomb = 1)
	begin
		print(N'natrafiono na minę! Jaka szkoda, gra niestety się kończy :( Spróbuj zagrać ponownie, może tym razem się uda');
		exec dbo._clearStructs;
		return;
	end;

	update gameboard
	set Struck = 1
	where Bomb = 0 and 
		SlotX <= @slotXCoord + 1 and SlotX >= @slotXCoord - 1 and
		SlotY <= @slotYCoord + 1 and SlotY >= @slotYCoord - 1;

	declare @struckCount int;
	declare @unminedCount int;

	select  @struckCount = sum(case Struck when 1 then 1 else 0 end), 
			@unminedCount = sum(case Bomb when 0 then 1 else 0 end) 
	from gameboard;

	if(@struckCount = @unminedCount)
	begin
		print(N'Brawo! Udało Ci się wygrać! Może następna gra?');
		exec dbo._clearStructs;
		return;
	end;

	exec dbo._printBoard;
END
GO
