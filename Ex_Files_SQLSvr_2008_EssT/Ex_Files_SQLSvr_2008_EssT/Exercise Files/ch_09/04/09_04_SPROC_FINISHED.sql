USE [AdventureWorksLT]
GO
/****** Object:  StoredProcedure [dbo].[uspCreateModelAndDescription]    Script Date: 11/14/2010 20:34:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Simon Allardice
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[uspCreateModelAndDescription]
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
BEGIN TRY
	BEGIN TRAN
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
	COMMIT TRAN
END TRY

BEGIN CATCH
	ROLLBACK TRAN
	PRINT 'There was an error'
	PRINT ERROR_MESSAGE()
END CATCH
	
END
