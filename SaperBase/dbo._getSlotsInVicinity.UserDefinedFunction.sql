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
/****** Object:  UserDefinedFunction [dbo].[_getSlotsInVicinity]    Script Date: 01.03.2019 19:16:24 ******/
DROP FUNCTION IF EXISTS [dbo].[_getSlotsInVicinity]
GO
/****** Object:  UserDefinedFunction [dbo].[_getSlotsInVicinity]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_getSlotsInVicinity]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date,,>
-- Description:	zwraca pola w danej odleglosci od podanych współrzędnych
-- =============================================
CREATE function [dbo].[_getSlotsInVicinity]
(
	@slotX int,
	@slotY int,
	@distance int = 1 
)
returns table
AS
return 
(
	select * from gameboard
	where SlotX between @slotX - @distance and @slotX + @distance and
		  SlotY between @slotY - @distance and @slotY + @distance
);
' 
END
GO
