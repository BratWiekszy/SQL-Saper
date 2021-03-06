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
/****** Object:  StoredProcedure [dbo].[_printBoardCustom]    Script Date: 01.03.2019 19:16:24 ******/
DROP PROCEDURE IF EXISTS [dbo].[_printBoardCustom]
GO
/****** Object:  StoredProcedure [dbo].[_printBoardCustom]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[_printBoardCustom]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[_printBoardCustom] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	wyswietla plansze
-- =============================================
ALTER procedure [dbo].[_printBoardCustom]
(
	@boardLength int,
	@mineFlagChar char(3) = 'M'
)
AS
BEGIN
	--SET NOCOUNT ON;

	declare @sql nvarchar(max);
	set @sql = 'select ';
	declare @i int = 1;
	-- wartosci tabeli
	declare boardCursor cursor for
	select SurroundingBombs, Struck, Bomb, Flag from gameboard
	order by SlotId;

	open boardCursor;

	declare @struck bit;
	declare @flag tinyint;
	declare @surrounding int;
	declare @bomb bit;
	declare @x int;

	declare @started bit = 0;
	declare @debugMode tinyint = dbo._isDebugMode();

	set @i = 1;
	while(@i <= @boardLength)
	begin
		if(@started = 0)
			set @started = 1;
		else
			set @sql = @sql + ' union all select ';

		set @x = 1;
		while(@x <= @boardLength)
		begin
			fetch next from boardCursor into @surrounding, @struck, @bomb, @flag;
			if(@x > 1)
				set @sql = @sql + ', ';

			set @sql = @sql + 
				(case
					when @struck = 1 or @debugMode = 2 and @bomb = 0 then '''' + convert(char(3), @surrounding) + '''' --liczba min w okolicy
					when @debugMode > 0 and @bomb = 1 then '''x''' --wyswietla mine dla celów testowania
					when @flag = 1 then '''' + @mineFlagChar + ''''
					else '''   ''' --puste pole
				end);
			set @sql = @sql + ' as ''' + convert(char(3), @x) + ''' '; --utrzymuje jednolite nazwy kolumn

			set @x = @x + 1;
		end;
		set @i = @i + 1;
	end;

	close boardCursor;
	deallocate boardCursor;

	exec sp_executesql @sql;
END
GO
