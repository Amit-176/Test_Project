USE [master]
GO
/****** Object:  Database [db_Test_App]    Script Date: 10/24/2024 9:48:42 PM ******/
CREATE DATABASE [db_Test_App]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_Test_App', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_Test_App.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'db_Test_App_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\db_Test_App_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [db_Test_App] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_Test_App].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_Test_App] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_Test_App] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_Test_App] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_Test_App] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_Test_App] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_Test_App] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [db_Test_App] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [db_Test_App] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_Test_App] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_Test_App] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_Test_App] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_Test_App] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_Test_App] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_Test_App] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_Test_App] SET  ENABLE_BROKER 
GO
ALTER DATABASE [db_Test_App] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_Test_App] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_Test_App] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_Test_App] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_Test_App] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_Test_App] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [db_Test_App] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_Test_App] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_Test_App] SET  MULTI_USER 
GO
ALTER DATABASE [db_Test_App] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [db_Test_App] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_Test_App] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_Test_App] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [db_Test_App]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 10/24/2024 9:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeProjects]    Script Date: 10/24/2024 9:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeProjects](
	[EmployeeId] [int] NOT NULL,
	[ProjectId] [int] NOT NULL,
 CONSTRAINT [PK_EmployeeProjects] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC,
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 10/24/2024 9:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[DOB] [datetime2](7) NOT NULL,
	[Gender] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Projects]    Script Date: 10/24/2024 9:48:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Projects](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[EndDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241021094715_initLoad', N'8.0.10')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20241021102917_UpdateModel', N'8.0.10')
GO
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (4, 1)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (5, 1)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (6, 1)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (7, 1)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (4, 2)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (7, 2)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (9, 2)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (4, 3)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (7, 3)
INSERT [dbo].[EmployeeProjects] ([EmployeeId], [ProjectId]) VALUES (9, 3)
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [DOB], [Gender]) VALUES (4, N'satyam', N'kuarm', CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Male')
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [DOB], [Gender]) VALUES (5, N'satyam', N'Kumar', CAST(N'2002-12-12T00:00:00.0000000' AS DateTime2), N'Male')
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [DOB], [Gender]) VALUES (6, N'sumit kumar', N'maurya', CAST(N'2024-10-24T00:00:00.0000000' AS DateTime2), N'Male')
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [DOB], [Gender]) VALUES (7, N'Rohan', N'kumar', CAST(N'2003-11-05T00:00:00.0000000' AS DateTime2), N'Male')
INSERT [dbo].[Employees] ([Id], [FirstName], [LastName], [DOB], [Gender]) VALUES (9, N'amit', N'kumar', CAST(N'2024-10-22T00:00:00.0000000' AS DateTime2), N'Male')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Projects] ON 

INSERT [dbo].[Projects] ([Id], [Name], [Description], [StartDate], [EndDate]) VALUES (1, N'first project', N'first project description', CAST(N'2024-10-23T00:00:00.0000000' AS DateTime2), CAST(N'2024-10-23T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Projects] ([Id], [Name], [Description], [StartDate], [EndDate]) VALUES (2, N'se project', N'se project description', CAST(N'2024-10-01T00:00:00.0000000' AS DateTime2), CAST(N'2024-10-22T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[Projects] ([Id], [Name], [Description], [StartDate], [EndDate]) VALUES (3, N'new project', N'new project description', CAST(N'2024-10-22T00:00:00.0000000' AS DateTime2), CAST(N'2024-10-22T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Projects] OFF
GO
/****** Object:  Index [IX_EmployeeProjects_ProjectId]    Script Date: 10/24/2024 9:48:42 PM ******/
CREATE NONCLUSTERED INDEX [IX_EmployeeProjects_ProjectId] ON [dbo].[EmployeeProjects]
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Projects] ADD  DEFAULT (N'') FOR [Description]
GO
ALTER TABLE [dbo].[EmployeeProjects]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProjects_Employees_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployeeProjects] CHECK CONSTRAINT [FK_EmployeeProjects_Employees_EmployeeId]
GO
ALTER TABLE [dbo].[EmployeeProjects]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProjects_Projects_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Projects] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmployeeProjects] CHECK CONSTRAINT [FK_EmployeeProjects_Projects_ProjectId]
GO
USE [master]
GO
ALTER DATABASE [db_Test_App] SET  READ_WRITE 
GO
