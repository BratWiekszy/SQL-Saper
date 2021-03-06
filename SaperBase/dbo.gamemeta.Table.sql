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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gamemeta]') AND type in (N'U'))
ALTER TABLE [dbo].[gamemeta] DROP CONSTRAINT IF EXISTS [DF__gamemeta__Inital__286302EC]
GO
/****** Object:  Table [dbo].[gamemeta]    Script Date: 01.03.2019 19:16:24 ******/
DROP TABLE IF EXISTS [dbo].[gamemeta]
GO
/****** Object:  Table [dbo].[gamemeta]    Script Date: 01.03.2019 19:16:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gamemeta]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[gamemeta](
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
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__gamemeta__Inital__286302EC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[gamemeta] ADD  CONSTRAINT [DF__gamemeta__Inital__286302EC]  DEFAULT ((0)) FOR [Initialized]
END
GO
