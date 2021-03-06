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
/****** Object:  StoredProcedure [dbo].[_flagSlot]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[_flagSlot]
GO
/****** Object:  StoredProcedure [dbo].[_flagSlot]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_flagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[_flagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje odkrycie pola o danych współrzędnych x, y (>= 1), inaczej ruch
-- =============================================
ALTER PROCEDURE [dbo].[_flagSlot]
	@slotXCoord int,
	@slotYCoord int, 
	@flag tinyint
AS
BEGIN
	SET NOCOUNT ON;

    if ((select count(*) from gameboard) = 0)
	begin
		print(N'wywolaj initGame @saperBoardLength przez rozpoczęciem gry');
		return;
	end;

	if (@flag is null)
	begin
		print(N'wspolrzedne sa poza zakresem planszy');
		return;
	end;

	update gameboard
	set Flag = @flag
	where SlotX = @slotXCoord and SlotY = @slotYCoord;

	exec dbo._printBoard;
END
GO
