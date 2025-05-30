USE [master]
GO
/****** Object:  Database [Library]    Script Date: 22.04.2025 19:26:49 ******/
CREATE DATABASE [Library]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library', FILENAME = N'C:\Users\User\Desktop\вижуал\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_log', FILENAME = N'C:\Users\User\Desktop\вижуал\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Library] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Library] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library] SET RECOVERY FULL 
GO
ALTER DATABASE [Library] SET  MULTI_USER 
GO
ALTER DATABASE [Library] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Library', N'ON'
GO
ALTER DATABASE [Library] SET QUERY_STORE = ON
GO
ALTER DATABASE [Library] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Library]
GO
/****** Object:  Table [dbo].[Abonement]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abonement](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ReaderID] [int] NULL,
	[OpeningDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Books]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Author] [nvarchar](255) NULL,
	[PublicationYear] [int] NULL,
	[DepartmentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookVidacha]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookVidacha](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SubscriptionID] [int] NULL,
	[BookID] [int] NULL,
	[LoanDate] [date] NULL,
	[ReturnDate] [date] NULL,
	[EmployeeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Position] [nvarchar](255) NULL,
	[PasswordHash] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Readers]    Script Date: 22.04.2025 19:26:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Readers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](255) NOT NULL,
	[Phone] [nvarchar](20) NULL,
	[Address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Abonement] ON 

INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (1, 1, CAST(N'2024-01-01' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (2, 2, CAST(N'2024-02-01' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (3, 3, CAST(N'2024-02-02' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (4, 4, CAST(N'2024-02-03' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (5, 5, CAST(N'2024-03-03' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (6, 6, CAST(N'2024-01-09' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (7, 7, CAST(N'2024-01-03' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (8, 8, CAST(N'2024-02-06' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (9, 9, CAST(N'2024-09-09' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (10, 10, CAST(N'2024-01-04' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (11, 11, CAST(N'2024-04-04' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (12, 12, CAST(N'2024-08-08' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (13, 13, CAST(N'2024-07-04' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (14, 14, CAST(N'2024-01-30' AS Date))
INSERT [dbo].[Abonement] ([ID], [ReaderID], [OpeningDate]) VALUES (15, 15, CAST(N'2024-06-24' AS Date))
SET IDENTITY_INSERT [dbo].[Abonement] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (1, N'История Древнего Рима', N'А.Викторов', 1995, 4)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (2, N'Основы физики', N'Б.Смирнов', 2010, 2)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (3, N'Приключение Тома Сойера', N'М.Твен', 1876, 3)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (4, N'Большие надежды', N'Ч.Диккенс', 1861, 4)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (5, N'Война и мир', N'Л.Толстой', 1869, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (6, N'Преступление и наказание', N'Ф.Достоевский', 1866, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (7, N'Мастер и Маргарита', N'М.Булгаков', 1966, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (8, N'1984', N'Дж.Оруэлл', 1949, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (9, N'Гарри Поттер', N'Дж.Роулинг', 1997, 3)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (10, N'Краткая история времени', N'С.Хокинг', 1988, 10)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (11, N'История человечества', N'Ю.Харри', 2011, 2)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (12, N'Властелин колец', N'Д.Толкинг', 1954, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (13, N'Идиот', N'Достоевский', 1868, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (14, N'Алхимик', N'П.Коэльо', 1988, 1)
INSERT [dbo].[Books] ([ID], [Title], [Author], [PublicationYear], [DepartmentID]) VALUES (15, N'Колобок', N'Русская народная', 1873, 14)
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
SET IDENTITY_INSERT [dbo].[BookVidacha] ON 

INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (1, 1, 1, CAST(N'2024-03-01' AS Date), CAST(N'2024-03-15' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (2, 2, 2, CAST(N'2024-02-03' AS Date), CAST(N'2024-02-17' AS Date), 2)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (3, 3, 3, CAST(N'2024-02-15' AS Date), CAST(N'2024-03-01' AS Date), 3)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (5, 4, 4, CAST(N'2024-02-05' AS Date), CAST(N'2024-02-20' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (6, 5, 5, CAST(N'2024-03-07' AS Date), CAST(N'2024-03-19' AS Date), 2)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (7, 6, 6, CAST(N'2024-01-09' AS Date), CAST(N'2024-01-27' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (8, 7, 7, CAST(N'2024-01-04' AS Date), CAST(N'2024-01-29' AS Date), 2)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (9, 8, 8, CAST(N'2024-02-06' AS Date), CAST(N'2024-03-02' AS Date), 3)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (10, 9, 9, CAST(N'2024-09-09' AS Date), CAST(N'2024-09-30' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (11, 10, 10, CAST(N'2024-01-05' AS Date), CAST(N'2024-01-23' AS Date), 2)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (12, 11, 11, CAST(N'2024-04-04' AS Date), CAST(N'2024-04-29' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (13, 12, 12, CAST(N'2024-08-09' AS Date), CAST(N'2024-08-17' AS Date), 2)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (14, 13, 13, CAST(N'2024-07-07' AS Date), CAST(N'2024-07-30' AS Date), 1)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (15, 14, 14, CAST(N'2024-01-30' AS Date), CAST(N'2024-02-15' AS Date), 3)
INSERT [dbo].[BookVidacha] ([ID], [SubscriptionID], [BookID], [LoanDate], [ReturnDate], [EmployeeID]) VALUES (16, 15, 15, CAST(N'2024-06-24' AS Date), CAST(N'2024-07-18' AS Date), 1)
SET IDENTITY_INSERT [dbo].[BookVidacha] OFF
GO
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (1, N'Художественная литература')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (2, N'Научная литература')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (3, N'Детская литература')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (4, N'История')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (5, N'Философия')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (6, N'Психология')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (7, N'Искусство')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (8, N'Техника')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (9, N'Медицина')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (10, N'Экономика')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (11, N'Юриспруденция')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (12, N'Компьютерная литература')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (13, N'Романтика')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (14, N'Сказки')
INSERT [dbo].[Departments] ([ID], [DepartmentName]) VALUES (15, N'Фантастика')
SET IDENTITY_INSERT [dbo].[Departments] OFF
GO
SET IDENTITY_INSERT [dbo].[Employees] ON 

INSERT [dbo].[Employees] ([ID], [FullName], [Position], [PasswordHash]) VALUES (1, N'Иванова А.А', N'Библиотекарь', N'123')
INSERT [dbo].[Employees] ([ID], [FullName], [Position], [PasswordHash]) VALUES (2, N'Васильев Е.Е', N'Зав.отделом', N'111')
INSERT [dbo].[Employees] ([ID], [FullName], [Position], [PasswordHash]) VALUES (3, N'Новикова К.К', N'Кассир', N'222')
SET IDENTITY_INSERT [dbo].[Employees] OFF
GO
SET IDENTITY_INSERT [dbo].[Readers] ON 

INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (1, N'Козлова М.М', N'8905735475', N'Московская 1')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (2, N'Федорова П.П', N'8905735365', N'Казанская 2')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (3, N'Волкова О.О', N'8957335335', N'Ленинградская 3')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (4, N'Борисова М.М', N'8960606000', N'Омская 4')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (5, N'Лебедева И.И', N'8900000000', N'Воронежская 5')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (6, N'Смирнова С.С', N'8911111111', N'Ижевская 6')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (7, N'Попов Ж.Ж', N'8975645454', N'Арская 7')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (8, N'Кузнецова В.В', N'8956677889', N'Гагарина 8')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (9, N'Смирнов П.П', N'8976656565', N'Мирная 9')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (10, N'Иванов И.И', N'8966060606', N'Пушкина 10')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (11, N'Петров П.П', N'8968685747', N'Толстого 11')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (12, N'Ильин Р.Р', N'8967546436', N'Ленина 12')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (13, N'Ганиева А.А', N'8967554535', N'Полковая 13')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (14, N'Никитина Н.Н', N'8967566633', N'Омская 14')
INSERT [dbo].[Readers] ([ID], [FullName], [Phone], [Address]) VALUES (15, N'Попопва Р.Р', N'8999999999', N'Гагарина 15')
SET IDENTITY_INSERT [dbo].[Readers] OFF
GO
ALTER TABLE [dbo].[Abonement]  WITH CHECK ADD FOREIGN KEY([ReaderID])
REFERENCES [dbo].[Readers] ([ID])
GO
ALTER TABLE [dbo].[Books]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([ID])
GO
ALTER TABLE [dbo].[BookVidacha]  WITH CHECK ADD FOREIGN KEY([BookID])
REFERENCES [dbo].[Books] ([ID])
GO
ALTER TABLE [dbo].[BookVidacha]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([ID])
GO
ALTER TABLE [dbo].[BookVidacha]  WITH CHECK ADD FOREIGN KEY([SubscriptionID])
REFERENCES [dbo].[Abonement] ([ID])
GO
USE [master]
GO
ALTER DATABASE [Library] SET  READ_WRITE 
GO
