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
/****** Object:  UserDefinedFunction [dbo].[_idToX]    Script Date: 01.03.2019 19:16:24 ******/
DROP FUNCTION IF EXISTS [dbo].[_idToX]
GO
/****** Object:  UserDefinedFunction [dbo].[_idToX]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_idToX]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[_idToX]
(
	@id int,
	@boardLength int
)
RETURNS int
AS
BEGIN
	if(@id % @boardLength = 0)
		return @boardLength;
	
	return @id % @boardLength;
END
' 
END
GO
