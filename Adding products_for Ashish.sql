
USE [RS_OPTUM_OTC_TransactionDB];


/* Changes to OPTUM

	List of changes received from Alison at 4.24 PM on 4-2-2018
*/

DECLARE @commit_transaction varchar(25) = 'false'; --this is for testing, set to 'true' to actually commit

DECLARE @created_on datetime2 = GETDATE();
DECLARE @created_by_id INT = 1;

DECLARE @product_filter varchar(25) = null;  --Set to null to update them all

BEGIN TRY

	IF (@commit_transaction = 'false')
		SET NOCOUNT OFF;
	ELSE
		SET NOCOUNT ON;

	-- Create table variable and fill it with the data provided
	RAISERROR ('filling up temp table with data to import', 0, 1);
	DECLARE @t TABLE
	(
		[ID] [int] NOT NULL IDENTITY (1,1),
		[action] varchar(2014) DEFAULT (''),
		[Product_Code] [varchar](50) NULL,

		[Image Update] [nvarchar](255) NULL,
		[Formulary] [nvarchar](255) NULL,
		[Category] [nvarchar](255) NULL,
		[Product Status] [nvarchar](255) NULL,
		[Product Code] [varchar](50) NULL,
		[Vendor] [nvarchar](255) NULL,
		[Product Name] [nvarchar](255) NULL,
		[Product Name Spanish] [nvarchar](255) NULL,
		[Packaging Size] [nvarchar](255) NULL,
		[Packaging Size Spanish] [nvarchar](255) NULL,
		[Packing Type] [nvarchar](255) NULL,
		[Total Member Cost] [money] NULL,
		[Unit Cost] [money] NULL,
		[Product Date Effective] [datetime] NULL,
		[Product Date End] [datetime] NULL,
		[Option Status] [nvarchar](255) NULL,
		[Size Description] [nvarchar](255) NULL,
		[Size Description Spanish] [nvarchar](255) NULL,
		[Flavor] [nvarchar](255) NULL,
		[Color Code] [nvarchar](255) NULL,
		[Color Code Spanish] [nvarchar](255) NULL,
		[Vendor Item Number] [nvarchar](255) NULL,
		[Vendor Account Number] [float] NULL,
		[HPCP Code] [nvarchar](255) NULL,
		[Product NDC Code] [nvarchar](255) NULL,
		[Shipping Conversion Item Number] [nvarchar](255) NULL,
		[Shipping Conversion UOM] [nvarchar](255) NULL,
		[Shipping Conversion Quantity] [nvarchar](255) NULL,
		[Product Help] [nvarchar](255) NULL,
		[Product Help Spanish] [nvarchar](255) NULL,
		[Web Help] [nvarchar](255) NULL,
		[Web Help Spanish] [nvarchar](255) NULL,
		[Auto Insert Product Code] [nvarchar](255) NULL,
		[Auto Insert Product Code Quantity] [nvarchar](255) NULL,
		[Alert Type] [nvarchar](255) NULL,
		[Alert Text] [nvarchar](255) NULL,
		[Restricted State] [nvarchar](255) NULL
	);

	DECLARE @recreateProducts TABLE (product_id int PRIMARY KEY);
	DECLARE @recreateDropShip TABLE (id int PRIMARY KEY);
	
	BEGIN --Insert data into temp table
		
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'Yes', N'CIP', N'First Aid ', N'NEW PRODUCT', '1038', N'Medline', N'Curad® Quick Stop Adhesive Bandage', NULL, N'30 ct.', N'30 unidades', N'BX', 6.0, 2.55, CAST(N'2018-05-14T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, N'CUR5243H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Standard size - 0.75" X 2.83"', NULL, N'Standard size - 0.75" X 2.83"', NULL, NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'Yes', N'DSNP', N'First Aid ', N'NEW PRODUCT', '1038', N'Medline', N'Curad® Quick Stop Adhesive Bandage', NULL, N'30 ct.', N'30 unidades', N'BX', 6.0, 2.55, CAST(N'2018-05-14T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, N'CUR5243H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Standard size - 0.75" X 2.83"', NULL, N'Standard size - 0.75" X 2.83"', NULL, NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'Yes', N'OTC Essentials', N'First Aid ', N'NEW PRODUCT', '1038E', N'Medline', N'Curad® Quick Stop Adhesive Bandage', NULL, N'30 ct.', N'30 unidades', N'BX', 6.0, 2.55, CAST(N'2018-05-14T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), NULL, NULL, NULL, NULL, NULL, NULL, N'CUR5243H', 1628449, NULL, NULL, NULL, NULL, NULL, N'Standard size - 0.75" X 2.83"', NULL, N'Standard size - 0.75" X 2.83"', NULL, NULL, NULL, N'N/A', NULL, NULL)
	/*	
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'LARGE 18"-20"', N'GRANDE 18" A 20"', NULL, NULL, NULL, N'ORT23100LDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'MEDIUM 16"-18"', N'MEDIANO 16" A 18"', NULL, NULL, NULL, N'ORT23100MDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'SMALL 14"-16"', N'PEQUEÃ‘O 14" A 16"', NULL, NULL, NULL, N'ORT23100SDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'X-LARGE 20"-22"', N'X-GRANDE 20" A 22"', NULL, NULL, NULL, N'ORT23100XLDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.4200, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'XX-LARGE 22"-24"', N'XX-GRANDE 22" A 24"', NULL, NULL, NULL, N'ORT231002XDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'LARGE 18"-20"', N'GRANDE 18" A 20"', NULL, NULL, NULL, N'ORT23100LDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'MEDIUM 16"-18"', N'MEDIANO 16" A 18"', NULL, NULL, NULL, N'ORT23100MDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'SMALL 14"-16"', N'PEQUEÃ‘O 14" A 16"', NULL, NULL, NULL, N'ORT23100SDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'X-LARGE 20"-22"', N'X-GRANDE 20" A 22"', NULL, NULL, NULL, N'ORT23100XLDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.4200, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'XX-LARGE 22"-24"', N'XX-GRANDE 22" A 24"', NULL, NULL, NULL, N'ORT231002XDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'ISNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'LARGE 18"-20"', N'GRANDE 18" A 20"', NULL, NULL, NULL, N'ORT23100LDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'ISNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'MEDIUM 16"-18"', N'MEDIANO 16" A 18"', NULL, NULL, NULL, N'ORT23100MDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'ISNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'SMALL 14"-16"', N'PEQUEÃ‘O 14" A 16"', NULL, NULL, NULL, N'ORT23100SDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'ISNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'X-LARGE 20"-22"', N'X-GRANDE 20" A 22"', NULL, NULL, NULL, N'ORT23100XLDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'ISNP', N'Suports', N'Active', 4602, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.4200, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'XX-LARGE 22"-24"', N'XX-GRANDE 22" A 24"', NULL, NULL, NULL, N'ORT231002XDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'SCO', N'Suports', N'Active', NULL, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'LARGE 18"-20"', N'GRANDE 18" A 20"', NULL, NULL, NULL, N'ORT23100LDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'SCO', N'Suports', N'Active', NULL, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'MEDIUM 16"-18"', N'MEDIANO 16" A 18"', NULL, NULL, NULL, N'ORT23100MDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'SCO', N'Suports', N'Active', NULL, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'SMALL 14"-16"', N'PEQUEÃ‘O 14" A 16"', NULL, NULL, NULL, N'ORT23100SDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'SCO', N'Suports', N'Active', NULL, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.1000, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'X-LARGE 20"-22"', N'X-GRANDE 20" A 22"', NULL, NULL, NULL, N'ORT23100XLDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'SCO', N'Suports', N'Active', NULL, N'MEDLINE', N'Curad® Pull-Over Knee Support', N'Soporte removible para rodilla Curad®', N'1 each', N'1 unidad', N'EA', 8.0000, 2.4200, CAST(N'2017-04-21T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', N'XX-LARGE 22"-24"', N'XX-GRANDE 22" A 24"', NULL, NULL, NULL, N'ORT231002XDHH', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.  Sizes: S; M; L; XL; XXL.  Mid-Thigh Measurement for S=14"-16"; M= 16"-18"; L=18"-20"; XL=20"-22"; XXL= 22"-24".', N'Proporciona compresión moderada.  Hecho con elástico sin latex.  Talles: P; M; G; XG; XXG.  Medida de mitad del muslo para P=14"-16"; M= 16"-18"; G=18"-20"; XG=20"-22"; XXG= 22"-24".', N'Provides moderate compression.  Made with latex-free elastic.  Measure knee circumference at knee cap with leg straight to size.', N'Proporciona compresión moderada.  Hecho con elástico sin látex.', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'First Aid', N'Put product out of stock', 4140, N'MEDLINE', N'Curad® Quick Stop Adhesive Bandage', N'Vendajes adhesivos que frenan rápido el sangrado Curad®', N'30 ct.', N'20 unidades', N'BX', 6.0000, 2.5500, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'CUR5245H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Assorted Size, Fabric', N'Diferentes tamaños, tela', N'Assorted Size, Fabric', N'Diferentes tamaños, tela', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'First Aid', N'Put product out of stock', 4140, N'MEDLINE', N'Curad® Quick Stop Adhesive Bandage', N'Vendajes adhesivos que frenan rápido el sangrado Curad®', N'30 ct.', N'20 unidades', N'BX', 6.0000, 2.5500, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'CUR5245H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Assorted Size, Fabric', N'Diferentes tamaños, tela', N'Assorted Size, Fabric', N'Diferentes tamaños, tela', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Stomach Remedies', N'Active', 1856, N'MEDLINE', N'Omeprazole Magnesium Acid Reducer', N'Reductor de ácido de magnesio de omeprazol', N'42 capsules', N'42 cápsulas', N'EA', 24.0000, 14.4000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC8646', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'****PLEASE NOTE:  Updated packaging size to Capsules****  Compares to Prilosec OTC®.  May help treat frequent heartburn. *** In certain circumstances this item may be covered by the plan or Original Medicare if you are not enrolled in the plan; and if ite', N'En comparación con Prilosec OTC®.  Puede ayudar a tratar la acidez frecuente. *** En determinadas circunstancias, este artículo puede estar cubierto por el plan o por Original Medicare si usted no está inscrito en el plan y si se determina que el artículo', N'Compares to Prilosec OTC®.  May help treat frequent heartburn. *** In certain circumstances this item may be covered by the plan or Original Medicare if you are not enrolled in the plan; and if item is determined to be medically necessary.  Please check w', N'En comparación con Prilosec OTC®.  Puede ayudar a tratar la acidez frecuente. *** En determinadas circunstancias, este artículo puede estar cubierto por el plan o por Original Medicare si usted no está inscrito en el plan y si se determina que el artículo', NULL, NULL, N'Disclaimer', N'****PLEASE NOTE:  Packaging size is Capsules not Caplets.****', NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Stomach Remedies', N'Active', 1856, N'MEDLINE', N'Omeprazole Magnesium Acid Reducer', N'Reductor de ácido de magnesio de omeprazol', N'42 capsules', N'42 cápsulas', N'EA', 24.0000, 14.4000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC8646', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'****PLEASE NOTE:  Updated packaging size to Capsules****  Compares to Prilosec OTC®.  May help treat frequent heartburn. *** In certain circumstances this item may be covered by the plan or Original Medicare if you are not enrolled in the plan; and if ite', N'En comparación con Prilosec OTC®.  Puede ayudar a tratar la acidez frecuente. *** En determinadas circunstancias, este artículo puede estar cubierto por el plan o por Original Medicare si usted no está inscrito en el plan y si se determina que el artículo', N'Compares to Prilosec OTC®.  May help treat frequent heartburn. *** In certain circumstances this item may be covered by the plan or Original Medicare if you are not enrolled in the plan; and if item is determined to be medically necessary.  Please check w', N'En comparación con Prilosec OTC®.  Puede ayudar a tratar la acidez frecuente. *** En determinadas circunstancias, este artículo puede estar cubierto por el plan o por Original Medicare si usted no está inscrito en el plan y si se determina que el artículo', NULL, NULL, N'Disclaimer', N'****PLEASE NOTE:  Packaging size is Capsules not Caplets.****', NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'Yes', N'CIP', N'First Aid', N'Active', 5012, N'MEDLINE', N'Curad® Wound Care Kit', N'Kit para cuidado de las heridas Curad®', N'25 ct.', N'20 unidades', N'BX', 10.0000, 4.4000, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'CUR1625V1H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Supplies to help clean (gauze pads), cover (non-stick pad or gauze roll) and secure (paper tape or gauze roll) wounds.', N'Ayuda a mantener heridas limpias (venda de gasa), cubiertas (protector antiadherente o rollo de gasa) y seguras (cinta de papel o rollo de gasa).', N'Supplies to help clean (gauze pads), cover (non-stick pad or gauze roll) and secure (paper tape or gauze roll) wounds.', N'Ayuda a mantener heridas limpias (venda de gasa), cubiertas (protector antiadherente o rollo de gasa) y seguras (cinta de papel o rollo de gasa).', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'Yes', N'DSNP', N'First Aid', N'Active', 5012, N'MEDLINE', N'Curad® Wound Care Kit', N'Kit para cuidado de las heridas Curad®', N'25 ct.', N'20 unidades', N'BX', 10.0000, 4.4000, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'CUR1625V1H', 1559412, NULL, NULL, NULL, NULL, NULL, N'Supplies to help clean (gauze pads), cover (non-stick pad or gauze roll) and secure (paper tape or gauze roll) wounds.', N'Ayuda a mantener heridas limpias (venda de gasa), cubiertas (protector antiadherente o rollo de gasa) y seguras (cinta de papel o rollo de gasa).', N'Supplies to help clean (gauze pads), cover (non-stick pad or gauze roll) and secure (paper tape or gauze roll) wounds.', N'Ayuda a mantener heridas limpias (venda de gasa), cubiertas (protector antiadherente o rollo de gasa) y seguras (cinta de papel o rollo de gasa).', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Vitamins & Supplements', N'Put back into inventory', 5902, N'MEDLINE', N'ImmuBlast Chewable Tablet ™', N'ImmuBlast Chewable Tablet ™', N'32 tablets', N'32 comprimidos', N'BT', 8.0000, 4.5000, CAST(N'2018-04-03T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC276969', 1559412, NULL, NULL, NULL, NULL, NULL, N'Compares to Airborne® Citrus Chewable tablets.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition. Debate exists on the merits of these supplements; so it is important that', N'En comparación con los comprimidos masticables sabor cítrico Airborne®.‡Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica. Existe controversia respecto de los méritos ', N'Compares to Airborne® Citrus Chewable tablets.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits of these supplements; so it is important tha', N'En comparación con los comprimidos masticables sabor cítrico Airborne®.‡Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica. Existe controversia respecto de los méritos ', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Vitamins & Supplements', N'Put back into inventory', 5902, N'MEDLINE', N'ImmuBlast Chewable Tablet ™', N'ImmuBlast Chewable Tablet ™', N'32 tablets', N'32 comprimidos', N'BT', 8.0000, 4.5000, CAST(N'2018-04-03T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC276969', 1559412, NULL, NULL, NULL, NULL, NULL, N'Compares to Airborne® Citrus Chewable tablets.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition. Debate exists on the merits of these supplements; so it is important that', N'En comparación con los comprimidos masticables sabor cítrico Airborne®.‡Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica. Existe controversia respecto de los méritos ', N'Compares to Airborne® Citrus Chewable tablets.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits of these supplements; so it is important tha', N'En comparación con los comprimidos masticables sabor cítrico Airborne®.‡Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica. Existe controversia respecto de los méritos ', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'CIP', N'Vitamins & Supplements', N'Put back into inventory', 1166, N'MEDLINE', N'Centravites 50 Plus Multivitamin', N'Multivitamínico Centravites 50 Plus', N'100 tablets', N'100 comprimidos', N'BT', 7.0000, 3.1000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC557494', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits o', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', N'Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits o', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'DSNP', N'Vitamins & Supplements', N'Put back into inventory', 1166, N'MEDLINE', N'Centravites 50 Plus Multivitamin', N'Multivitamínico Centravites 50 Plus', N'100 tablets', N'100 comprimidos', N'BT', 7.0000, 3.1000, CAST(N'2017-01-01T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC557494', 1559412, N'A9999', NULL, NULL, NULL, NULL, N'Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits o', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', N'Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits o', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', NULL, NULL, N'N/A', NULL, NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (N'No', N'OTC Essentials', N'Vitamins & Supplements', N'Active', NULL, N'MEDLINE', N'Centravites 50 Plus Multivitamin', N'Multivitamínico Centravites 50 Plus', N'100 tablets', N'100 comprimidos', N'BT', 7.0000, 3.7300, CAST(N'2018-04-02T00:00:00.000' AS DateTime), CAST(N'2018-12-31T00:00:00.000' AS DateTime), N'Active', NULL, NULL, NULL, NULL, NULL, N'OTC227688', 1628449, N'A9999', NULL, NULL, NULL, NULL, N'Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a specific condition.  Debate exists on the merits o', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', N'Brand Change to:  Sentry Senior 50+ Multivitamin.  Compares to Centrum® Silver®. Multivitamin and multimineral supplement for mature adults.‡Members may order these item(s) after discussing the item(s) with their physician who recommends the item(s) for a', N'En comparación con Centrum® Silver®. Suplemento multivitamínico y multimineral para adultos maduros. Los miembros pueden pedir estos artículos después de haber hablado con el médico que se los haya recomendado para una afección específica.  Existe controv', NULL, NULL, N'Disclaimer', N'Brand Change to:  Sentry Senior 50+ Multivitamin', NULL)
		INSERT @t ([Image Update], [Formulary], [Category], [Product Status], [Product Code], [Vendor], [Product Name], [Product Name Spanish], [Packaging Size], [Packaging Size Spanish], [Packing Type], [Total Member Cost], [Unit Cost], [Product Date Effective], [Product Date End], [Option Status], [Size Description], [Size Description Spanish], [Flavor], [Color Code], [Color Code Spanish], [Vendor Item Number], [Vendor Account Number], [HPCP Code], [Product NDC Code], [Shipping Conversion Item Number], [Shipping Conversion UOM], [Shipping Conversion Quantity], [Product Help], [Product Help Spanish], [Web Help], [Web Help Spanish], [Auto Insert Product Code], [Auto Insert Product Code Quantity], [Alert Type], [Alert Text], [Restricted State]) VALUES (NULL, N'**** Can you please check the Product Alerts for 1166E - there should only be one active, the other one should be expired but two printer on the configuration report', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
	*/
		UPDATE @t SET [action] = 'New' WHERE [Product Status] LIKE 'NEW PROD%';  --Covered
		UPDATE @t SET [Product_Code] = [Product Code]
		
		/*
		UPDATE @t SET [action] = 'RemoveFromFormulary' WHERE [Product Status] LIKE 'REMOVE%Formulary'; --Covered

		UPDATE @t SET [action] = 'ExpireAndRecreateDropShipItem' --Covered
		WHERE id IN 
		(		
			1	
			, 18
			, 19
		);
	
		UPDATE @t SET [action] += '_UpdateProductHelpEnglish' --Covered
		WHERE id IN 
		(
			1
		);
	
		UPDATE @t SET [action] += '_UpdateProductDateEffective' --Covered
		WHERE id IN 
		(
			20
			, 18
			, 19
		);

		UPDATE @t SET [action] += '_UpdateProductPackagingSizeEnglish' --Covered
		WHERE id IN 
		(
			18
			, 19
		);

		UPDATE @t SET [action] += '_UpdateProductPackagingSizeSpanish' --Covered
		WHERE id IN 
		(
			18
			, 19
		);

		UPDATE @t SET [action] += '_UpdateProductDateEnd' --Covered
		WHERE id IN 
		(
			16
			, 17
		);

		UPDATE @t SET [action] += '_UpdateProductWebHelpEnglish' --Covered
		WHERE id IN 
		(
			2
			, 3
			, 4
			, 5
		);

		UPDATE @t SET [action] += '_AddProductAlert' --Covered
		WHERE id IN 
		(
			20
		);

		UPDATE @t SET [action] += '_RemoveAlert' --Covered
		WHERE id IN 
		(
			6
			, 7
		);
		*/
	
		IF (@product_filter IS NOT NULL)
		BEGIN 
			DELETE FROM @t 
			WHERE [Product Code] <> @product_filter;
		END
	END -- insert data into temp table

	IF (@commit_transaction = 'false')
	BEGIN
		SELECT TOP 100 * FROM @t ORDER BY id;
	END

	BEGIN TRANSACTION;

	--Add alert
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Add alert', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%AddProductAlert%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		INSERT INTO dbo.Product_Alerts
		(
			Product_Code
			, Product_Alert_Type_ID
			, Custom_Alert_Text
			, Can_Override_Advocate
			, Can_Override_Supervisor
			, DT_Effective
			, DT_End
			, DT_Created
			, DT_Modified
			, Created_By_User_ID
		)
		SELECT
			Product_Code				= p.Product_Code
			, Product_Alert_Type_ID		= at.Product_Alert_Type_ID
			, Custom_Alert_Text			= t.[Alert Text]
			, Can_Override_Advocate		= 1
			, Can_Override_Supervisor	= 1
			, DT_Effective				= @created_on
			, DT_End					= p.DT_End
			, DT_Created				= @created_on
			, DT_Modified				= @created_on
			, Created_By_User_ID		= @created_by_id	
			
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
			INNER JOIN dbo.Product_Alert_Types AS at
				ON t.[Alert Type] = at.Alert_Type
		WHERE
			t.action LIKE '%AddProductAlert%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;

	--Update Product Packaging Size English
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Update Product Packaging English', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductPackagingSizeEnglish%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		UPDATE p
		SET Packaging_Size = t.[Packaging Size]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductPackagingSizeEnglish%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;


	--Update Product Packaging Size Spanish
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Update Product Packaging Spanish', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductPackagingSizeSpanish%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		UPDATE p
		SET Packaging_Size_Spa = t.[Packaging Size Spanish]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductPackagingSizeSpanish%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;

	--Update Product Help English
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Update Product Help English', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductHelpEnglish%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		UPDATE p
		SET Product_Help = t.[Product Help]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductHelpEnglish%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;
			
	--Update Product Web Help English
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Update Product Web Help English', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductWebHelpEnglish%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		UPDATE p
		SET Web_Help = t.[Web Help]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductWebHelpEnglish%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;
	
	--Update Product End Date
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Update Product End Date', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductDateEnd%'
				AND p.DT_Effective = t.[Product Date Effective]
			;
		END;	

		UPDATE p
		SET DT_End = t.[Product Date End]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductDateEnd%'
			AND p.DT_Effective = t.[Product Date Effective]

		UPDATE dr
		SET DT_End = t.[Product Date End]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.Product_Dropship_Item_Options AS dr
				ON t.Product_Code = dr.Product_Code
		WHERE
			t.action LIKE '%UpdateProductDateEnd%'
			AND dr.DT_Effective = t.[Product Date Effective]

	--Update Product Effective Date
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('-Update Product Effective Date', 0, 1);
			SELECT TOP 100 p.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action LIKE '%UpdateProductDateEffective%'
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;	

		UPDATE p
		SET DT_Effective = t.[Product Date Effective]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.products AS p
				ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%UpdateProductDateEffective%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end;

		UPDATE dr
		SET DT_Effective = t.[Product Date Effective]
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @t AS t
			INNER JOIN dbo.Product_Dropship_Item_Options AS dr
				ON t.Product_Code = dr.Product_Code
		WHERE
			t.action LIKE '%UpdateProductDateEffective%'
			AND GETDATE() BETWEEN dr.DT_Effective AND dr.dt_end;

	
	--REMOVE from Formulary or Inactivate from Formulary
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('REMOVE from Formulary or Inactivate from Formulary', 0, 1);
			SELECT TOP 100 bp.*
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
				INNER JOIN dbo.Benefit_Products AS bp
					ON p.Product_ID = bp.Product_ID
				INNER JOIN dbo.benefit_plans AS bpl
					ON bp.Benefit_Plan_ID = bpl.Benefit_Plan_ID
			WHERE
				t.action LIKE '%RemoveFromFormulary%'
				AND bpl.Formulary = t.Formulary
				AND GETDATE() BETWEEN bp.DT_Effective AND bp.dt_end
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
			;
		END;

		UPDATE dbo.Benefit_Products
		SET 
			DT_End = DATEADD(DAY, -1, @created_on)
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		WHERE Benefit_Product_ID IN
		(
			SELECT
				bp.Benefit_Product_ID
			FROM @t AS t
				INNER JOIN dbo.products AS p
					ON t.[Product_Code] = p.Product_Code
				INNER JOIN dbo.Benefit_Products AS bp
					ON p.Product_ID = bp.Product_ID
				INNER JOIN dbo.benefit_plans AS bpl
					ON bp.Benefit_Plan_ID = bpl.Benefit_Plan_ID
			WHERE			
				t.action LIKE '%RemoveFromFormulary%'
				AND bpl.Formulary = t.Formulary
				AND GETDATE() BETWEEN bp.DT_Effective AND bp.dt_end
				AND GETDATE() BETWEEN p.DT_Effective AND p.dt_end
		);

	--Process Remove Alerts
		IF (@commit_transaction = 'false')
		BEGIN
			RAISERROR ('Process Remove Alerts', 0, 1);
			SELECT TOP 100 *
			FROM @t AS t
				INNER JOIN dbo.Product_Alerts AS pa 
				ON t.[Product_Code] = pa.Product_Code
			WHERE
				t.action LIKE '%RemoveAlert%'
			;
		END;

		DELETE pa
		FROM @t AS t
			INNER JOIN dbo.Product_Alerts AS pa 
				ON t.[Product_Code] = pa.Product_Code
		WHERE
			t.action LIKE '%RemoveAlert%'
		;

	--Expire products that need to be recreated because of a new Packing type, vendor Number or Shipping Conversion UOM

		IF (@commit_transaction = 'false')  
		BEGIN
			RAISERROR ('Expiring Products that need to be recreated', 0, 1);
			SELECT 
				p.*
			FROM @t AS t
				INNER JOIN dbo.Products AS p ON t.[Product_Code] = p.Product_Code
			WHERE
				t.action = 'ExpireAndRecreate'
				AND GETDATE() BETWEEN p.DT_Effective AND p.DT_End
			;
		END;

		RAISERROR ('Insert into @recreateProducts', 0, 1);

		INSERT INTO @recreateProducts (product_id)
		SELECT DISTINCT p.product_id
		FROM @t AS t
			INNER JOIN dbo.Products AS p ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action = 'ExpireAndRecreate'
			AND GETDATE() BETWEEN p.DT_Effective AND p.DT_End
		;

		RAISERROR ('Insert into @recreateDropShip', 0, 1);

		INSERT INTO @recreateDropShip (id)
		SELECT DISTINCT p.Product_Dropship_Item_Option_ID
		FROM @t AS t
			INNER JOIN dbo.Product_Dropship_Item_Options AS p ON t.[Product_Code] = p.Product_Code
		WHERE
			t.action LIKE '%ExpireAndRecreateDropShipItem%'
			AND GETDATE() BETWEEN p.DT_Effective AND p.DT_End
		;

	--Expire the Benefit_Products
		UPDATE bp
		SET 
			DT_End = DATEADD(DAY, -1, @created_on)
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @recreateProducts AS r
			INNER JOIN dbo.Products AS p ON r.product_id = p.Product_ID
			INNER JOIN dbo.Benefit_Products AS bp ON p.Product_ID = bp.Product_ID
		WHERE
			GETDATE() BETWEEN bp.DT_Effective AND bp.DT_End
		;

	--Expire the Product_Dropship_Item_Options
		RAISERROR ('expire dropship from @recreateProducts', 0, 1);

		UPDATE dr
		SET 
			DT_End = DATEADD(DAY, -1, @created_on)
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @recreateProducts AS r
			INNER JOIN dbo.Products AS p ON r.product_id = p.Product_ID
			INNER JOIN dbo.Product_Dropship_Item_Options AS dr ON p.Product_Code = dr.Product_Code
		WHERE
			GETDATE() BETWEEN dr.DT_Effective AND dr.DT_End
		;

		RAISERROR ('expire dropship from @recreateDropShip', 0, 1);

		UPDATE dr
		SET 
			DT_End = DATEADD(DAY, -1, @created_on)
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @recreateDropShip AS r
			INNER JOIN dbo.Product_Dropship_Item_Options AS dr ON r.id = dr.Product_Dropship_Item_Option_ID
		;

	--Expire the product
		UPDATE p
		SET 
			DT_End = DATEADD(DAY, -1, @created_on)
			, DT_Updated = @created_on
			, Updated_By_ID = @created_by_id
		FROM @recreateProducts AS r
			INNER JOIN dbo.Products AS p ON r.product_id = p.Product_ID
		;

	--Insert the new products
		RAISERROR ('inserting the new products', 0, 1);
		INSERT INTO dbo.Products
		(
			  Product_Name
			, Product_Name_Spa
			, Product_Code
			, Catalog_Number
			, Product_NDC_Code
			, Category_ID
			, Product_Description
			, Product_Description_Spa
			, Manufacturer
			, DT_Effective
			, DT_End
			, Packing_Type
			, Packaging_Size
			, Packaging_Size_Spa
			, Total_Member_Cost
			, Unit_Cost
			, Product_Help
			, Product_Help_Spa
			, DT_Created
			, DT_Updated
			, Created_By_ID
			, Updated_By_ID
			, Web_Help
			, Web_Help_Spa
			, Include_Overrides
		)
		SELECT DISTINCT
			  Product_Name				= t.[Product Name]
			, Product_Name_Spa			= t.[Product Name Spanish]
			, Product_Code				= t.[Product_Code]
			, Catalog_Number			= t.[Product_Code]	
			, Product_NDC_Code			= NULL 
			, Category_ID				= pc.Category_ID
			, Product_Description		= t.[Product Name]
			, Product_Description_Spa	= t.[Product Name Spanish]
			, Manufacturer				= NULL 
			, DT_Effective				= @created_on
			, DT_End					= CAST(t.[Product Date End] AS date)
			, Packing_Type				= t.[Packing Type]
			, Packaging_Size			= t.[Packaging Size]
			, Packaging_Size_Spa		= t.[Packaging Size Spanish]
			, Total_Member_Cost			= t.[Total Member Cost]
			, Unit_Cost					= t.[Unit Cost]
			, Product_Help				= t.[Product Help]
			, Product_Help_Spa			= t.[Product Help Spanish]
			, DT_Created				= @created_on
			, DT_Updated				= @created_on
			, Created_By_ID				= @created_by_id
			, Updated_By_ID				= @created_by_id
			, Web_Help					= t.[Web Help]
			, Web_Help_Spa				= t.[Web Help Spanish]
			, Include_Overrides			= NULL

		FROM @t AS t
			LEFT OUTER JOIN dbo.Product_Category AS pc
				ON t.Category = pc.Description
		WHERE 
			t.action = 'New'
		;

	--Insert the new products that are going to be recreated
		RAISERROR ('inserting the products that need to be recreated', 0, 1);
		INSERT INTO dbo.Products
		(
			  Product_Name
			, Product_Name_Spa
			, Product_Code
			, Catalog_Number
			, Product_NDC_Code
			, Category_ID
			, Product_Description
			, Product_Description_Spa
			, Manufacturer
			, DT_Effective
			, DT_End
			, Packing_Type
			, Packaging_Size
			, Packaging_Size_Spa
			, Total_Member_Cost
			, Unit_Cost
			, Product_Help
			, Product_Help_Spa
			, DT_Created
			, DT_Updated
			, Created_By_ID
			, Updated_By_ID
			, Web_Help
			, Web_Help_Spa
			, Include_Overrides
		)
		SELECT DISTINCT
			  Product_Name				= t.[Product Name]
			, Product_Name_Spa			= t.[Product Name Spanish]
			, Product_Code				= t.[Product_Code]
			, Catalog_Number			= t.[Product_Code]	
			, Product_NDC_Code			= NULL 
			, Category_ID				= p.Category_ID
			, Product_Description		= t.[Product Name]
			, Product_Description_Spa	= t.[Product Name Spanish]
			, Manufacturer				= NULL 
			, DT_Effective				= @created_on
			, DT_End					= t.[Product Date End]
			, Packing_Type				= t.[Packing Type]
			, Packaging_Size			= t.[Packaging Size]
			, Packaging_Size_Spa		= t.[Packaging Size Spanish]
			, Total_Member_Cost			= t.[Total Member Cost]
			, Unit_Cost					= 0 --t.[Unit Cost]
			, Product_Help				= t.[Product Help]
			, Product_Help_Spa			= t.[Product Help Spanish]
			, DT_Created				= @created_on
			, DT_Updated				= @created_on
			, Created_By_ID				= @created_by_id
			, Updated_By_ID				= @created_by_id
			, Web_Help					= t.[Web Help]
			, Web_Help_Spa				= t.[Web Help Spanish]
			, Include_Overrides			= NULL

		FROM @t AS t
			INNER JOIN dbo.products AS p 
				ON t.[Product_Code] = p.Product_Code
			INNER JOIN @recreateProducts AS r
				ON p.Product_ID = r.product_id
		WHERE 
			[action] = 'ExpireAndRecreate'
		;
	
	--display some of the products inserte
		IF (@commit_transaction = 'false')  
		BEGIN 
			RAISERROR ('displaying some of the products added', 0, 1);

			SELECT TOP 100 p.*
			FROM dbo.products AS p
			WHERE p.DT_Created = @created_on
			ORDER BY p.Product_ID DESC;
		END

	--insert the product dropship items	
	RAISERROR ('inserting into Product_Dropship_Item_Options', 0, 1);

		INSERT INTO dbo.Product_Dropship_Item_Options
		(
			Product_Code
			, Size_Code
			, Size_Description
			, Size_Description_Spa
			, Dropship_Account_No
			, Drop_Ship_Item_Code
			, DT_Effective
			, DT_End
			, DT_Created
			, DT_Updated
			, Created_By_ID
			, Updated_By_ID
			, Hcpc_Code
			, Unit_Cost
			, [Shipping_Conversion_UOM]
			, [Shipping_Conversion_Item_No]
			, [Quantity]
		)
		SELECT DISTINCT
			Product_Code					= p.Product_Code
			, Size_Code						= t.[Size Description]
			, Size_Description				= t.[Size Description]
			, Size_Description_Spa			= t.[Size Description Spanish]
			, Dropship_Account_No			= t.[Vendor Account Number]
			, Drop_Ship_Item_Code			= t.[Vendor Item Number]
			, DT_Effective					= p.DT_Effective
			, DT_End						= p.DT_End
			, DT_Created					= p.DT_Created
			, DT_Updated					= p.DT_Updated
			, Created_By_ID					= p.Created_By_ID
			, Updated_By_ID					= p.Updated_By_ID
			, Hcpc_Code						= t.[HPCP Code]
			, Unit_Cost						= t.[Unit Cost]
			, [Shipping_Conversion_UOM]		= t.[Shipping Conversion UOM]
			, [Shipping_Conversion_Item_No] = t.[Shipping Conversion Item Number]
			, [Quantity]					= t.[Shipping Conversion Quantity]
		FROM dbo.products AS p
			INNER JOIN @t AS t 
				ON p.Product_Code = t.[Product_Code] 
		WHERE
			p.DT_Created = @created_on
		;

	--recreating product dropship items	
	RAISERROR ('recreating Product_Dropship_Item_Options', 0, 1);

		INSERT INTO dbo.Product_Dropship_Item_Options
		(
			Product_Code
			, Size_Code
			, Size_Description
			, Size_Description_Spa
			, Dropship_Account_No
			, Drop_Ship_Item_Code
			, DT_Effective
			, DT_End
			, DT_Created
			, DT_Updated
			, Created_By_ID
			, Updated_By_ID
			, Hcpc_Code
			, Unit_Cost
			, [Shipping_Conversion_UOM]
			, [Shipping_Conversion_Item_No]
			, [Quantity]
		)
		SELECT DISTINCT
			Product_Code					= dr.Product_Code
			, Size_Code						= t.[Size Description]
			, Size_Description				= t.[Size Description]
			, Size_Description_Spa			= t.[Size Description Spanish]
			, Dropship_Account_No			= t.[Vendor Account Number]
			, Drop_Ship_Item_Code			= t.[Vendor Item Number]
			, DT_Effective					= @created_on
			, DT_End						= t.[Product Date End]
			, DT_Created					= @created_on
			, DT_Updated					= @created_on
			, Created_By_ID					= @created_by_id
			, Updated_By_ID					= @created_by_id
			, Hcpc_Code						= t.[HPCP Code]
			, Unit_Cost						= t.[Unit Cost]
			, [Shipping_Conversion_UOM]		= t.[Shipping Conversion UOM]
			, [Shipping_Conversion_Item_No] = t.[Shipping Conversion Item Number]
			, [Quantity]					= t.[Shipping Conversion Quantity]
		FROM dbo.Product_Dropship_Item_Options AS dr
			INNER JOIN @recreateDropShip AS r ON dr.Product_Dropship_Item_Option_ID = r.id
			INNER JOIN @t AS t 
				ON dr.Product_Code = t.[Product_Code]
		;

	--display some of the Product_Dropship_Item_Options added
		IF (@commit_transaction = 'false')  
		BEGIN 
			RAISERROR ('displaying some of the products dropships', 0, 1);
			SELECT TOP 100 dr.*
			FROM dbo.Product_Dropship_Item_Options AS dr	
			WHERE dr.DT_Created = @created_on
			ORDER BY dr.Product_Dropship_Item_Option_ID DESC;
		END

	--Insert the benefit Products
	RAISERROR ('inserting into Benefit_Products', 0, 1);
	
		WITH products_added_cte AS
		(
			SELECT DISTINCT
				p.product_id
				, t.Formulary
			FROM dbo.products AS p
					INNER JOIN @t AS t 
						ON p.Product_Code = t.[Product_Code] 
			WHERE
				p.DT_Created = @created_on
		)
		INSERT INTO dbo.Benefit_Products
		(
			Benefit_Plan_ID
			, Product_ID
			, DT_Effective
			, DT_End
			, Catalog_Code
			, DT_Created
			, DT_Updated
			, Created_By_ID
			, Updated_By_ID
		)
		SELECT DISTINCT
			Benefit_Plan_ID			= bp.Benefit_Plan_ID
			, Product_ID			= p.Product_ID
			, DT_Effective			= p.DT_Effective
			, DT_End				= p.DT_End
			, Catalog_Code			= p.Product_Code
			, DT_Created			= p.DT_Created
			, DT_Updated			= p.DT_Updated
			, Created_By_ID			= p.Created_By_ID
			, Updated_By_ID			= p.Updated_By_ID
		FROM products_added_cte AS pa
			INNER JOIN dbo.Products AS p
				ON pa.Product_ID = p.product_id
			INNER JOIN dbo.Benefit_Plans AS bp
				ON pa.Formulary = bp.Formulary
				AND p.DT_Effective BETWEEN bp.DT_Effective AND bp.DT_End
		;

	--display some of the benefit_products added
		IF (@commit_transaction = 'false')  
		BEGIN
			RAISERROR ('display some of the Benefit_Products added', 0, 1);
				
			SELECT TOP 300 bp.*
			FROM dbo.Benefit_Products AS bp
			WHERE bp.DT_Created = @created_on
			ORDER BY bp.Benefit_Product_ID DESC;
		END;
	
	IF (@commit_transaction = 'true') BEGIN 
		PRINT 'committing the transaction';
		COMMIT TRANSACTION;
	END ELSE BEGIN 
		PRINT 'just testing, rolling back the transaction';
		ROLLBACK TRANSACTION;
	END

END TRY
BEGIN CATCH
	IF (@@TRANCOUNT > 0 )
		ROLLBACK TRANSACTION;
	THROW;
END CATCH

