USE [master]
GO
/****** Object:  Database [School]    Script Date: 02/06/2020 20:39:18 ******/
CREATE DATABASE [School]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'School', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\School.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'School_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\School_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [School] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [School].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [School] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [School] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [School] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [School] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [School] SET ARITHABORT OFF 
GO
ALTER DATABASE [School] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [School] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [School] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [School] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [School] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [School] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [School] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [School] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [School] SET  ENABLE_BROKER 
GO
ALTER DATABASE [School] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [School] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [School] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [School] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [School] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [School] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [School] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [School] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [School] SET  MULTI_USER 
GO
ALTER DATABASE [School] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [School] SET DB_CHAINING OFF 
GO
ALTER DATABASE [School] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [School] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [School] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [School] SET QUERY_STORE = OFF
GO
USE [School]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseName] [nvarchar](20) NOT NULL,
	[City] [nvarchar](20) NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[EstablishedOn] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Models]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Models](
	[ModelID] [int] IDENTITY(101,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[ManufacturerID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mountains]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mountains](
	[MountainID] [int] NOT NULL,
	[MountainName] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MountainID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passports]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passports](
	[PassportID] [int] NOT NULL,
	[PassportNumber] [char](8) NOT NULL,
 CONSTRAINT [PK_PassportID] PRIMARY KEY CLUSTERED 
(
	[PassportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peaks]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peaks](
	[PeakId] [int] NOT NULL,
	[PeakName] [varchar](50) NOT NULL,
	[MountainID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PeakId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Persons]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persons](
	[PersonID] [int] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[Salary] [decimal](7, 2) NOT NULL,
	[PassportID] [int] NOT NULL,
 CONSTRAINT [PK_PersonID] PRIMARY KEY CLUSTERED 
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentCourses]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentCourses](
	[StudentId] [int] NOT NULL,
	[CourseId] [int] NOT NULL,
	[Grade] [decimal](3, 2) NULL,
 CONSTRAINT [PK_StudentCourses] PRIMARY KEY CLUSTERED 
(
	[StudentId] ASC,
	[CourseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 02/06/2020 20:39:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[FacultyNumber] [char](6) NOT NULL,
	[Photo] [varbinary](max) NULL,
	[DateOfEnlistment] [date] NOT NULL,
	[ListOfCourses] [nvarchar](1000) NULL,
	[YearOfGraduation] [date] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([Id], [CourseName], [City], [IsDeleted]) VALUES (1, N'C#', N'Sofia', 0)
INSERT [dbo].[Courses] ([Id], [CourseName], [City], [IsDeleted]) VALUES (2, N'JS', N'Varna', 1)
INSERT [dbo].[Courses] ([Id], [CourseName], [City], [IsDeleted]) VALUES (3, N'C#', N'Plovdiv', 1)
INSERT [dbo].[Courses] ([Id], [CourseName], [City], [IsDeleted]) VALUES (4, N'C# DB', N'Sofia', 1)
INSERT [dbo].[Courses] ([Id], [CourseName], [City], [IsDeleted]) VALUES (5, N'Java', N'Sofia', 0)
SET IDENTITY_INSERT [dbo].[Courses] OFF
GO
SET IDENTITY_INSERT [dbo].[Manufacturers] ON 

INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (1, N'BMW', CAST(N'1916-03-07' AS Date))
INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (2, N'Tesla', CAST(N'2003-01-01' AS Date))
INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [EstablishedOn]) VALUES (3, N'Lada', CAST(N'1966-05-01' AS Date))
SET IDENTITY_INSERT [dbo].[Manufacturers] OFF
GO
SET IDENTITY_INSERT [dbo].[Models] ON 

INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (101, N'X1', 1)
INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (102, N'i6', 1)
INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (103, N'Model S', 2)
INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (104, N'Model X', 2)
INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (105, N'Model 3', 2)
INSERT [dbo].[Models] ([ModelID], [Name], [ManufacturerID]) VALUES (106, N'Nova', 3)
SET IDENTITY_INSERT [dbo].[Models] OFF
GO
INSERT [dbo].[Mountains] ([MountainID], [MountainName]) VALUES (1, N'Rila')
INSERT [dbo].[Mountains] ([MountainID], [MountainName]) VALUES (2, N'Pirin')
INSERT [dbo].[Mountains] ([MountainID], [MountainName]) VALUES (3, N'Stara Planina')
GO
INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (101, N'N34FG21B')
INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (102, N'K65LO4R7')
INSERT [dbo].[Passports] ([PassportID], [PassportNumber]) VALUES (103, N'ZE657QP2')
GO
INSERT [dbo].[Peaks] ([PeakId], [PeakName], [MountainID]) VALUES (1, N'Musala', 1)
INSERT [dbo].[Peaks] ([PeakId], [PeakName], [MountainID]) VALUES (2, N'Botev', 3)
GO
INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (1, N'Roberto', CAST(43300.00 AS Decimal(7, 2)), 102)
INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (2, N'Tom', CAST(56100.00 AS Decimal(7, 2)), 103)
INSERT [dbo].[Persons] ([PersonID], [FirstName], [Salary], [PassportID]) VALUES (3, N'Yana', CAST(60200.00 AS Decimal(7, 2)), 101)
GO
INSERT [dbo].[StudentCourses] ([StudentId], [CourseId], [Grade]) VALUES (1, 2, NULL)
INSERT [dbo].[StudentCourses] ([StudentId], [CourseId], [Grade]) VALUES (1, 3, NULL)
INSERT [dbo].[StudentCourses] ([StudentId], [CourseId], [Grade]) VALUES (1, 4, NULL)
INSERT [dbo].[StudentCourses] ([StudentId], [CourseId], [Grade]) VALUES (2, 1, NULL)
INSERT [dbo].[StudentCourses] ([StudentId], [CourseId], [Grade]) VALUES (2, 3, NULL)
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([Id], [Name], [FacultyNumber], [Photo], [DateOfEnlistment], [ListOfCourses], [YearOfGraduation]) VALUES (1, N'Paulina', N'F123  ', NULL, CAST(N'2020-05-28' AS Date), N'C#', CAST(N'2021-05-29' AS Date))
INSERT [dbo].[Students] ([Id], [Name], [FacultyNumber], [Photo], [DateOfEnlistment], [ListOfCourses], [YearOfGraduation]) VALUES (2, N'Niki', N'R231  ', NULL, CAST(N'2020-06-01' AS Date), N'C# DB', CAST(N'2024-05-29' AS Date))
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Countrie__E056F201F9C2ED10]    Script Date: 02/06/2020 20:39:18 ******/
ALTER TABLE [dbo].[Countries] ADD UNIQUE NONCLUSTERED 
(
	[CountryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Persons__185653F13898D179]    Script Date: 02/06/2020 20:39:18 ******/
ALTER TABLE [dbo].[Persons] ADD UNIQUE NONCLUSTERED 
(
	[PassportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Models]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturers] ([ManufacturerID])
GO
ALTER TABLE [dbo].[Peaks]  WITH CHECK ADD  CONSTRAINT [FK_Peaks_Mountains] FOREIGN KEY([MountainID])
REFERENCES [dbo].[Mountains] ([MountainID])
GO
ALTER TABLE [dbo].[Peaks] CHECK CONSTRAINT [FK_Peaks_Mountains]
GO
ALTER TABLE [dbo].[Persons]  WITH CHECK ADD  CONSTRAINT [FK_PassportID] FOREIGN KEY([PassportID])
REFERENCES [dbo].[Passports] ([PassportID])
GO
ALTER TABLE [dbo].[Persons] CHECK CONSTRAINT [FK_PassportID]
GO
ALTER TABLE [dbo].[StudentCourses]  WITH CHECK ADD  CONSTRAINT [FK_StudentCourses_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[StudentCourses] CHECK CONSTRAINT [FK_StudentCourses_Students]
GO
USE [master]
GO
ALTER DATABASE [School] SET  READ_WRITE 
GO
