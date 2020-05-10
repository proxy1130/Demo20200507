Use TargetDB
Go
/****** Create Basic Table 'companies'  ******/ 
Create table companies (
   name varchar(30) not null,
   country varchar(30) not null,
   unique(name)
);


/****** Create Basic Table 'trades'  ******/ 
Create table trades (
   id integer not null,
   seller varchar(30) not null,
   buyer varchar(30) not null,
   value integer not null,
   unique(id)
);


USE [TargetDB]
GO

INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('Alice s.p.','Wonderland')
INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('Y-zap','Wonderland')
INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('Absolute','Mathlands')
INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('Arcus t.g.','Mathlands')
INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('Lil Mermaid','Underwater Kingdom')
INSERT INTO [dbo].[companies]([name],[country])  VALUES  ('None at all','Nothingland')
GO

select * from [dbo].[companies]
Go

USE [TargetDB]
GO

INSERT INTO [dbo].[trades]([id],[seller],[buyer],[value]) VALUES (20121107,'Lil Mermaid','Alice s.p.',10)
INSERT INTO [dbo].[trades]([id],[seller],[buyer],[value]) VALUES (20123012,'Arcus t.g.','Y-zap',30)
INSERT INTO [dbo].[trades]([id],[seller],[buyer],[value]) VALUES (20120125,'Alice s.p.','Arcus t.g.',100)
INSERT INTO [dbo].[trades]([id],[seller],[buyer],[value]) VALUES (20120216,'Lil Mermaid','Absolute',30)
INSERT INTO [dbo].[trades]([id],[seller],[buyer],[value]) VALUES (20120217,'Lil Mermaid','Absolute',50)
GO
