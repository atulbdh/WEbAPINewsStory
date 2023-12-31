USE [NewsDB]
GO
/****** Object:  Table [dbo].[NewsMaster]    Script Date: 10-12-2023 15:15:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsMaster](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[NewsTitle] [nvarchar](250) NULL,
	[NewsDescription] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
	[Deleted] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[NewsMaster] ON 

INSERT [dbo].[NewsMaster] ([NewsId], [NewsTitle], [NewsDescription], [IsActive], [Deleted]) VALUES (1, N'Animal: Ranbir Kapoor And Rashmika Mandanna', N'Animal: Ranbir Kapoor And Rashmika Mandanna''s Intimate Scene Creates Stir, Photos Go Viral', 1, 0)
INSERT [dbo].[NewsMaster] ([NewsId], [NewsTitle], [NewsDescription], [IsActive], [Deleted]) VALUES (2, N'Cremated U''khand Man Comes to Life in Another Town', N'Luck Tales: khand Man Comes to Life in Another Town Rechristened, Remarried', 1, 0)
INSERT [dbo].[NewsMaster] ([NewsId], [NewsTitle], [NewsDescription], [IsActive], [Deleted]) VALUES (3, N'PCB Appoints Salman Butt, Kamran Akmal and Iftikhar Anjum', N'PCB Appoints Salman Butt, Kamran Akmal and Iftikhar Anjum as Consultant Members to Chief Selector Wahab Riaz', 1, 0)
INSERT [dbo].[NewsMaster] ([NewsId], [NewsTitle], [NewsDescription], [IsActive], [Deleted]) VALUES (4, N'Ranbir Kapoor Goes Completely NUDE', N'Animal: Ranbir Kapoor Goes Completely NUDE In The Most Controversial Scene; Video Goes Viral', 1, 0)
INSERT [dbo].[NewsMaster] ([NewsId], [NewsTitle], [NewsDescription], [IsActive], [Deleted]) VALUES (5, N'Squid Game Fame Lee Jung-jae Donates Entire Award Prize Money To Support Veteran Filmmakers', N'Lee Jung-jae, better known for his performance in the much-acclaimed Netflix web series Squid Game has wrapped up 2023 on a noble note. The actor has displayed his acting mettle in the survival-thriller series', 1, 0)
SET IDENTITY_INSERT [dbo].[NewsMaster] OFF
GO
/****** Object:  StoredProcedure [dbo].[GetNewsList]    Script Date: 10-12-2023 15:15:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[dbo].[GetNewsList] 1,10,'animal'
CREATE Proc [dbo].[GetNewsList]
(
@PageNumber INT=1,
@PageSize INT=10,
@WhereCrieteria  VARCHAR(MAX)='' 
)AS
BEGIN
SET NOCOUNT ON;
	DECLARE @offsetcount AS INT
	SET @offsetcount=(@PageNumber-1)* @PageSize

	Select NewsId,NewsTitle,NewsDescription FROM NewsMaster(nolock) Where 
	NewsDescription like '%'+@WhereCrieteria+'%'	AND IsActive=1 AND Deleted=0
	order by NewsId desc
	OFFSET  @offsetcount  ROWS FETCH NEXT   @PageSize  ROWS ONLY

	Select  COUNT(NewsId) AS TotalRecord  FROM NewsMaster(nolock) Where 
	NewsDescription like '%'+@WhereCrieteria+'%'	AND IsActive=1 AND Deleted=0


END
GO
/****** Object:  StoredProcedure [dbo].[USP_GetNewsList]    Script Date: 10-12-2023 15:15:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--[dbo].[GetNewsList] null,null,''
CREATE Proc [dbo].[USP_GetNewsList]
(
@PageNumber INT=null,
@PageSize INT=null,
@WhereCrieteria  VARCHAR(MAX)=null
)AS
BEGIN
SET NOCOUNT ON;
	SET @PageNumber=ISNULL(@PageNumber,1)
	SET @PageSize=ISNULL(@PageSize,10)
	SET @WhereCrieteria=ISNULL(@WhereCrieteria,'')

	DECLARE @offsetcount AS INT
	SET @offsetcount=(@PageNumber-1)* @PageSize

	Select ROW_NUMBER() OVER (ORDER BY NewsId DESC ) AS RowNumber,NewsId,NewsTitle,NewsDescription FROM NewsMaster(nolock) Where 
	NewsDescription like '%'+@WhereCrieteria+'%'	AND IsActive=1 AND Deleted=0
	order by NewsId desc
	OFFSET  @offsetcount  ROWS FETCH NEXT   @PageSize  ROWS ONLY

	Select  COUNT(NewsId) AS TotalRecord  FROM NewsMaster(nolock) Where 
	NewsDescription like '%'+@WhereCrieteria+'%'	AND IsActive=1 AND Deleted=0


END





GO
