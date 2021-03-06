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
/****** Object:  StoredProcedure [dbo].[unflagSlot]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[unflagSlot]
GO
/****** Object:  StoredProcedure [dbo].[unflagSlot]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[unflagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[unflagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 26.02
-- Description:	powoduje reset oflagowania danego pola.
-- =============================================
ALTER PROCEDURE [dbo].[unflagSlot]
	@slotXCoord int,
	@slotYCoord int
AS
BEGIN
	SET NOCOUNT ON;

	declare @flag bit = 
		(select Top(1) Flag from gameboard
		where SlotX = @slotXCoord and SlotY = @slotYCoord);

	if (@flag = 0)
	begin
		exec dbo._printBoard;

		print(N'to pole nie jest oflagowane miną, spróbuj inne');
		return;
	end;

	exec dbo._flagSlot @slotXCoord, @slotYCoord, 0;
END
GO
