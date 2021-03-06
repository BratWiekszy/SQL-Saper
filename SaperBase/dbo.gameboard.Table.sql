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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gameboard]') AND type in (N'U'))
ALTER TABLE [dbo].[gameboard] DROP CONSTRAINT IF EXISTS [DF__gameboard__Struc__24927208]
GO
/****** Object:  Table [dbo].[gameboard]    Script Date: 01.03.2019 19:16:24 ******/
DROP TABLE IF EXISTS [dbo].[gameboard]
GO
/****** Object:  Table [dbo].[gameboard]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gameboard]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[gameboard](
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__gameboard__Struc__24927208]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[gameboard] ADD  DEFAULT ((0)) FOR [Struck]
END
GO
