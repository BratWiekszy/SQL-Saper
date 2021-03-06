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
/****** Object:  StoredProcedure [dbo].[flagSlot]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[flagSlot]
GO
/****** Object:  StoredProcedure [dbo].[flagSlot]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[flagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[flagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje oflagowanie danego pola miną. Można podać własny znak min
-- =============================================
ALTER PROCEDURE [dbo].[flagSlot]
	@slotXCoord int,
	@slotYCoord int,
	@customMineChar char(3) = 'M'
AS
BEGIN
	SET NOCOUNT ON;

	declare @flag bit = 
		(select Top(1) Flag from gameboard
		where SlotX = @slotXCoord and SlotY = @slotYCoord);

	if (@flag = 1)
	begin
		exec dbo._printBoard;

		print(N'to pole jest już oflagowane miną, spróbuj inne');
		return;
	end;

	exec dbo._flagSlot @slotXCoord, @slotYCoord, 1;

	update gamemeta
	Set FlagChar = @customMineChar
	where GameId = (select max(GameId) from gamemeta);
END
GO
