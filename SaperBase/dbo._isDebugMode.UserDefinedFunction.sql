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
/****** Object:  UserDefinedFunction [dbo].[_isDebugMode]    Script Date: 01.03.2019 19:16:24 ******/
DROP FUNCTION IF EXISTS [dbo].[_isDebugMode]
GO
/****** Object:  UserDefinedFunction [dbo].[_isDebugMode]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_isDebugMode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date,,>
-- Description:	stwierdza czy ostatnia gra jest w trybie debug
-- =============================================
CREATE function [dbo].[_isDebugMode]
(
)
returns tinyint
AS
begin

	declare @debugRun tinyint = 
			(select top (1) Debug from gamemeta
			order by GameId desc);

	return @debugRun;
end
' 
END
GO
