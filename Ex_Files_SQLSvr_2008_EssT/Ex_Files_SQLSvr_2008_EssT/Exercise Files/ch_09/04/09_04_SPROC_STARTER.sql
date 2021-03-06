----------------------------------------
-- *************************************
-- * 
-- * RUN THIS IF YOU DON'T HAVE AN 
-- * EXISTING STORED PROCEDURE TO 
-- * ADD A TRANSACTION TO.
-- * 
-- *************************************
---------------------------------------
USE [AdventureWorksLT]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[uspCreateModelAndDescription]
	-- Add the parameters for the stored procedure here
	@productname NVarChar(50),
	@productdescription NVarChar(400),
	@culture nchar(6) = 'en'
AS
BEGIN
	SET NOCOUNT ON;

-- create two variables to hold the keys of the two inserted rows
	DECLARE @productmodelid INT, 
	@productdescriptionid INT

-- step 1: insert the customer row
	INSERT INTO SalesLT.ProductModel
	(Name)
	VALUES 
	(@productname)
	
	-- get inserted customer id
	SELECT @productmodelid = @@IDENTITY
	
	-- step 2 - insert new address	
	INSERT INTO SalesLT.ProductDescription
	(Description)
	VALUES
	(@productdescription)
	
	-- get inserted address id
	SELECT @productdescriptionid = @@IDENTITY
	
	-- step 3, create join row
	INSERT INTO SalesLT.ProductModelProductDescription
	(ProductModelID, ProductDescriptionID, Culture)
	VALUES 
	(@productmodelid, @productdescriptionid, @culture)
	
	
END
