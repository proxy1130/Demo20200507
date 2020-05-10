USE [TargetDB]
GO

CREATE PROCEDURE [dbo].[uspQueryAllTradesInAllCountry]
AS
WITH ImportData AS ( SELECT b.country ,SUM(a.Value) AS Import from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name Group by (b.country)  
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name ))
,ExportData AS( SELECT  b.country ,SUM(a.Value) AS Export from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name Group by (b.country) 
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name ))
select C.Country,D.Export,C.Import from ImportData C ,ExportData D  where C.Country= D.Country 
Go
Return
Go

CREATE PROCEDURE [dbo].[uspQueryAllTradesInAllCountryEnhanceSummary]
AS
WITH ImportData AS ( SELECT case when b.country is null then 'Total' else b.country end Country ,SUM(a.Value) AS Import from [dbo].[companies] b, [dbo].[trades] 
a where a.buyer = b.name Group by Rollup(b.country)  
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name ))
,ExportData AS( SELECT  case when b.country is null then 'Total' else b.country end Country
,SUM(a.Value) AS Export from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name Group by Rollup(b.country) 
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name ))
select C.Country,D.Export,C.Import from ImportData C ,ExportData D  where C.Country= D.Country Order by Export
Return
Go

CREATE PROCEDURE [dbo].[uspQueryAllTradesInAllCountryCheck]
AS
WITH ImportData AS ( SELECT case when b.country is null then 'Total' else b.country end Country ,SUM(a.Value) AS Import from [dbo].[companies] b, [dbo].[trades] 
a where a.buyer = b.name Group by Rollup(b.country)  
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name ))
,ExportData AS( SELECT  case when b.country is null then 'Total' else b.country end Country
,SUM(a.Value) AS Export from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name Group by Rollup(b.country) 
union  select distinct country,'0' from companies a where a.country NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name ))
select case when D.Export= C.Import then 'AccountingCheckPass' else 'NoAccountingCheckPass' end As 'SystemFuncheck' 
from ImportData C ,ExportData D where C.Country= D.Country and C.Country='Total' and D.Country='Total' 
Return
Go

CREATE PROCEDURE [dbo].[uspProduceDetailExportData]
AS
SELECT b.country ,SUM(a.Value) AS Export,a.seller from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name 
Group by b.country,a.seller
union  select distinct country,'0' As Value ,'NULL' As Seller from companies a where a.country
 NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.seller = b.name)
Return
Go

CREATE PROCEDURE [dbo].[uspProduceDetailImportData]
AS
SELECT b.country ,SUM(a.Value) AS Export,a.buyer from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name 
Group by b.country,a.buyer
union  select distinct country,'0' As Value ,'NULL' As Buyer from companies a where a.country
 NOT IN (Select b.country  from [dbo].[companies] b, [dbo].[trades] a where a.buyer = b.name)
Return
Go