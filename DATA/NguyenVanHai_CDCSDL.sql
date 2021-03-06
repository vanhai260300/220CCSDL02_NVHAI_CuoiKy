USE [master]
GO
/****** Object:  Database [CDCSDL]    Script Date: 7/5/2021 2:28:37 PM ******/
CREATE DATABASE [CDCSDL_CuoiKy]
/****** Object:  Table [dbo].[Category]    Script Date: 7/5/2021 2:28:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[idCategory] [int] NOT NULL,
	[nameCategory] [nvarchar](100) NOT NULL,
	[linkCategory] [nvarchar](100) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[idCategory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 7/5/2021 2:28:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[idProduct] [int] NOT NULL,
	[nameProduct] [nvarchar](200) NOT NULL,
	[idCategory] [int] NOT NULL,
	[image] [nvarchar](200) NULL,
	[price] [nvarchar](50) NULL,
	[rate] [nvarchar](100) NULL,
	[QuanRate] [nvarchar](100) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productDetail]    Script Date: 7/5/2021 2:28:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetail](
	[idProduct] [int] NOT NULL,
	[screen] [nvarchar](200) NULL,
	[opratingSystem] [nvarchar](200) NULL,
	[rearCamera] [nvarchar](200) NULL,
	[frontCamera] [nvarchar](200) NULL,
	[CPU] [nvarchar](200) NULL,
	[RAM] [nvarchar](200) NULL,
	[internalmemory] [nvarchar](200) NULL,
	[SIM] [nvarchar](200) NULL,
	[Battery] [nvarchar](200) NULL,
	[design] [nvarchar](200) NULL,
 CONSTRAINT [PK_ProductDetail] PRIMARY KEY CLUSTERED 
(
	[idProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([idCategory])
REFERENCES [dbo].[Category] ([idCategory])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
ALTER TABLE [dbo].[Product]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_productDetail] FOREIGN KEY([idProduct])
REFERENCES [dbo].[productDetail] ([idProduct])
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[Product] NOCHECK CONSTRAINT [FK_Product_productDetail]


