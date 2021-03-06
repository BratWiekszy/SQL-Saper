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
/****** Object:  StoredProcedure [unflagSlot]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [unflagSlot]
GO
/****** Object:  StoredProcedure [strikeSlot]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [strikeSlot]
GO
/****** Object:  StoredProcedure [initGame]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [initGame]
GO
/****** Object:  StoredProcedure [help]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [help]
GO
/****** Object:  StoredProcedure [flagSlot]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [flagSlot]
GO
/****** Object:  StoredProcedure [_printBoardCustom]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [_printBoardCustom]
GO
/****** Object:  StoredProcedure [_printBoard]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [_printBoard]
GO
/****** Object:  StoredProcedure [_initBoard]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [_initBoard]
GO
/****** Object:  StoredProcedure [_flagSlot]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [_flagSlot]
GO
/****** Object:  StoredProcedure [_clearStructs]    Script Date: 01.03.2019 19:21:24 ******/
DROP PROCEDURE IF EXISTS [_clearStructs]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gamemeta]') AND type in (N'U'))
ALTER TABLE [gamemeta] DROP CONSTRAINT IF EXISTS [DF__gamemeta__Inital__286302EC]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gameboard]') AND type in (N'U'))
ALTER TABLE [gameboard] DROP CONSTRAINT IF EXISTS [DF__gameboard__Struc__24927208]
GO
/****** Object:  Table [gamemeta]    Script Date: 01.03.2019 19:21:24 ******/
DROP TABLE IF EXISTS [gamemeta]
GO
/****** Object:  UserDefinedFunction [_getSlotsInVicinity]    Script Date: 01.03.2019 19:21:24 ******/
DROP FUNCTION IF EXISTS [_getSlotsInVicinity]
GO
/****** Object:  Table [gameboard]    Script Date: 01.03.2019 19:21:24 ******/
DROP TABLE IF EXISTS [gameboard]
GO
/****** Object:  UserDefinedFunction [_isDebugMode]    Script Date: 01.03.2019 19:21:24 ******/
DROP FUNCTION IF EXISTS [_isDebugMode]
GO
/****** Object:  UserDefinedFunction [_idToY]    Script Date: 01.03.2019 19:21:24 ******/
DROP FUNCTION IF EXISTS [_idToY]
GO
/****** Object:  UserDefinedFunction [_idToX]    Script Date: 01.03.2019 19:21:24 ******/
DROP FUNCTION IF EXISTS [_idToX]
GO
USE [master]
GO
/****** Object:  Database [SaperBase]    Script Date: 01.03.2019 19:21:24 ******/
DROP DATABASE IF EXISTS [SaperBase]
GO
/****** Object:  Database [SaperBase]    Script Date: 01.03.2019 19:21:24 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'SaperBase')
BEGIN
CREATE DATABASE [SaperBase]
END
GO
ALTER DATABASE [SaperBase] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SaperBase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SaperBase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SaperBase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SaperBase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SaperBase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SaperBase] SET ARITHABORT OFF 
GO
ALTER DATABASE [SaperBase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SaperBase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SaperBase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SaperBase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SaperBase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SaperBase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SaperBase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SaperBase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SaperBase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SaperBase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SaperBase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SaperBase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SaperBase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SaperBase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SaperBase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SaperBase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SaperBase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SaperBase] SET RECOVERY FULL 
GO
ALTER DATABASE [SaperBase] SET  MULTI_USER 
GO
ALTER DATABASE [SaperBase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SaperBase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SaperBase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SaperBase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SaperBase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SaperBase', N'ON'
GO
ALTER DATABASE [SaperBase] SET QUERY_STORE = OFF
GO
USE [SaperBase]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [SaperBase]
GO
/****** Object:  UserDefinedFunction [_idToX]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_idToX]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [_idToX]
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
/****** Object:  UserDefinedFunction [_idToY]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_idToY]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [_idToY]
(
	@id int,
	@boardLength int
)
RETURNS int
AS
BEGIN
	return ceiling(convert(float, @id) / @boardLength);
END
' 
END
GO
/****** Object:  UserDefinedFunction [_isDebugMode]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_isDebugMode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date,,>
-- Description:	stwierdza czy ostatnia gra jest w trybie debug
-- =============================================
CREATE function [_isDebugMode]
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
/****** Object:  Table [gameboard]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gameboard]') AND type in (N'U'))
BEGIN
CREATE TABLE [gameboard](
	[SlotId] [int] NOT NULL,
	[SlotX] [int] NULL,
	[SlotY] [int] NULL,
	[SurroundingBombs] [int] NULL,
	[Bomb] [bit] NULL,
	[Struck] [bit] NOT NULL,
	[Flag] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[SlotId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [_getSlotsInVicinity]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_getSlotsInVicinity]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Brat Wiekszy
-- Create date: <Create Date,,>
-- Description:	zwraca pola w danej odleglosci od podanych współrzędnych
-- =============================================
CREATE function [_getSlotsInVicinity]
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
/****** Object:  Table [gamemeta]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[gamemeta]') AND type in (N'U'))
BEGIN
CREATE TABLE [gamemeta](
	[GameId] [int] IDENTITY(1,1) NOT NULL,
	[BoardLength] [int] NOT NULL,
	[Initialized] [bit] NOT NULL,
	[Debug] [tinyint] NULL,
	[Difficulty] [float] NULL,
	[FlagChar] [char](3) NULL,
 CONSTRAINT [PK__gamemeta__2AB897FD1BB9BEB4] PRIMARY KEY CLUSTERED 
(
	[GameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF__gameboard__Struc__24927208]') AND type = 'D')
BEGIN
ALTER TABLE [gameboard] ADD  DEFAULT ((0)) FOR [Struck]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[DF__gamemeta__Inital__286302EC]') AND type = 'D')
BEGIN
ALTER TABLE [gamemeta] ADD  CONSTRAINT [DF__gamemeta__Inital__286302EC]  DEFAULT ((0)) FOR [Initialized]
END
GO
/****** Object:  StoredProcedure [_clearStructs]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_clearStructs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [_clearStructs] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	czyści struktury saperskie
-- =============================================
ALTER PROCEDURE [_clearStructs]
AS
BEGIN
	SET NOCOUNT ON;

	if OBJECT_ID(N'dbo.gamemeta', N'U') is not null
	begin
		if(dbo._isDebugMode() > 0)
			return;

		truncate table gamemeta;
	end;

    if OBJECT_ID(N'dbo.gameboard', N'U') is not null
	begin
		truncate table gameboard;
	end;
END
GO
/****** Object:  StoredProcedure [_flagSlot]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_flagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [_flagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje odkrycie pola o danych współrzędnych x, y (>= 1), inaczej ruch
-- =============================================
ALTER PROCEDURE [_flagSlot]
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
/****** Object:  StoredProcedure [_initBoard]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_initBoard]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [_initBoard] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	inicjuje wystapienie struktur saperskich, @saperBoardLength okresla dlugosc boku planszy, default = 10
-- =============================================
ALTER PROCEDURE [_initBoard]
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
/****** Object:  StoredProcedure [_printBoard]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_printBoard]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [_printBoard] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	wyswietla plansze
-- =============================================
ALTER procedure [_printBoard]
AS
BEGIN
	declare @boardLength int;
	declare @mineFlagChar char(3);

	select top (1) @boardLength = BoardLength, @mineFlagChar = FlagChar from gamemeta
	order by GameId desc;

	exec dbo._printBoardCustom @boardLength, @mineFlagChar;

	declare @struckCount int, @unminedCount int;
	
	select  @struckCount = sum(case Struck when 1 then 1 else 0 end), 
			@unminedCount = sum(case Bomb when 0 then 1 else 0 end) 
	from gameboard;

	print(N'odkryto '+ convert(char(3), @struckCount) +' na '+ convert(char(3), @unminedCount) +' pól');
END
GO
/****** Object:  StoredProcedure [_printBoardCustom]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[_printBoardCustom]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [_printBoardCustom] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	wyswietla plansze
-- =============================================
ALTER procedure [_printBoardCustom]
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
/****** Object:  StoredProcedure [flagSlot]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[flagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [flagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje oflagowanie danego pola miną. Można podać własny znak min
-- =============================================
ALTER PROCEDURE [flagSlot]
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
/****** Object:  StoredProcedure [help]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[help]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [help] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Description:	help 
-- =============================================
ALTER PROCEDURE [help] 
AS
BEGIN
	--SET NOCOUNT ON;

    print(N'To je poradnik do sapera. By grać, zacznik od: '+char(13)+
	'exec initGame @saperBoardLength = 10, @difficulty = 3; minimalna szerokość planszy to 5, maksymalna 99, diffuculty jest w przedzialne 1-5, potem:' +char(13)+
	'exec strikeSlot x, y; gdzie x i y są liczbami zczytanymi z planszy, funkcja odkrywa dane. pole. Dodatkowo:' +char(13)+
	'exec flagSlot x, y, @customMineChar = ''M''; oznacza pole jako minę, znak miny jest konfigurowalny. By odznaczyć pole:' +char(13)+
	'exec unflagSlot x, y; Powodzenia!');
END
GO
/****** Object:  StoredProcedure [initGame]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[initGame]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [initGame] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	inicjuje wystapienie struktur saperskich, @saperBoardLength okresla dlugosc boku planszy, default = 10, difficulty - stopnie 1-5
-- =============================================
ALTER PROCEDURE [initGame]
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
/****** Object:  StoredProcedure [strikeSlot]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[strikeSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [strikeSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 21.02
-- Description:	powoduje odkrycie pola o danych współrzędnych x, y (>= 1), inaczej ruch
-- =============================================
ALTER PROCEDURE [strikeSlot]
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
/****** Object:  StoredProcedure [unflagSlot]    Script Date: 01.03.2019 19:21:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[unflagSlot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [unflagSlot] AS' 
END
GO
-- =============================================
-- Author:		Brat Wiekszy
-- Create date: 26.02
-- Description:	powoduje reset oflagowania danego pola.
-- =============================================
ALTER PROCEDURE [unflagSlot]
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
USE [master]
GO
ALTER DATABASE [SaperBase] SET  READ_WRITE 
GO
