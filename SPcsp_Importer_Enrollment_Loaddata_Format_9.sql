USE [OPTUM_OTC_TransactionDB-Hotfix]
GO

/****** Object:  StoredProcedure [dbo].[csp_Importer_Enrollment_LoadData_Format_9]    Script Date: 6/5/2018 5:58:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[csp_Importer_Enrollment_LoadData_Format_9]        
 -- Add the parameters for the stored procedure here        
 @Batch_ID INT,        
 @FileName VARCHAR(100),        
 @process_id VARCHAR(10) = NULL,        
 @ContinueDownloadID int = NULL,        
 @FileID INT = NULL        
AS        
BEGIN        
        
 -- SET NOCOUNT ON added to prevent extra result sets FROM        
 -- interfering with SELECT statements.        
 SET NOCOUNT ON;        
        
 --BEGIN TRANSACTION        
         
    -- Insert statements for procedure here        
    DECLARE @Ret_Var INT , @Error_Code INT, @Tran_Count_In INT         
    DECLARE @Warning VARCHAR(8000)        
    SELECT @Ret_Var = 0, @Error_Code = 0, @Tran_Count_In = @@TranCount, @Warning = ''        
    DECLARE @Today datetime = GETDATE()        
    -----------------------------------        
    -- Import In Process        
    -----------------------------------        
    UPDATE        
    Import_Batches WITH (UPDLOCK)        
    SET        
    [Status] = 10        
    ,DT_Start = GETDATE()        
    WHERE        
    Batch_ID = @Batch_ID        
           
    -----------------------------------        
    -- DELETE work tables keeping identity        
    -----------------------------------        
    --DELETE FROM  Import_Enrollment_Header_Work        
    TRUNCATE TABLE Import_Enrollment_Detail_Work        
    TRUNCATE TABLE Download_Members_Temp        
    --DELETE FROM Import_Enrollment_Footer_Work        
        
    INSERT INTO [Import_Enrollment_Detail_Work]        
  (        
  [Batch_ID]        
  ,[Record_Type]        
  ,[Group_Number]        
  ,[Member_Number]        
  ,[First_Name]        
  ,[Middle_Initial]        
  ,[Last_Name]          
  ,[Date_of_Birth]        
  ,[Sex]        
  ,[Address1]        
  ,[Address2]        
  ,[City]        
  ,[State]        
  ,[Zip_Code]        
  ,[SSN]        
  ,[HIC_Number]        
  ,[HIC_Date]        
  ,[Primary_Phone_Number]        
  ,[Secondary_Phone_Number]        
  ,[Effective_Date]        
  ,[Term_Date]        
  ,[PCP_ID_Overflow]        
  ,[PCP_ID_Number]        
  ,[Foreign_Language_Preference]        
  ,[Miscellaneous_Code_1]        
  ,[Miscellaneous_Code_2]        
  ,[Miscellaneous_Code_3]        
  ,[Miscellaneous_Code_4]        
  ,[Miscellaneous_Code_5]          
  ,[Filler_01]        
  ,[Filler_02]        
  ,[Filler_03]        
    )        
    SELECT   @Batch_ID        
    ,SUBSTRING(LineData, 1,4) AS Record_Type        
    ,SUBSTRING(LineData, 5,5) AS Group_Number -- ?            
    ,SUBSTRING(LineData, 775,9) AS Member_Number -- ?        
    ,RTRIM(SUBSTRING(LineData, 21,12)) AS First_Name        
    ,RTRIM(SUBSTRING(LineData, 33,1)) AS Middle_Name        
    ,RTRIM(SUBSTRING(LineData, 34,18)) AS Last_Name        
    ,CASE WHEN ISDATE(SUBSTRING(LineData,163,8)) = 1 THEN CAST(SUBSTRING(LineData, 163,8) AS DATE)        
    ELSE NULL        
     END AS Date_Of_Birth        
    ,SUBSTRING(LineData, 171,1) AS Sex        
    ,SUBSTRING(LineData, 52,30) AS Address1        
    ,SUBSTRING(LineData, 82,30) AS Address2        
    ,SUBSTRING(LineData, 112,15) AS City        
    ,SUBSTRING(LineData, 127,2) AS [State]        
    ,SUBSTRING(LineData, 129,5) AS Zip_Code        
    ,SUBSTRING(LineData, 172,9) AS SSN        
    ,SUBSTRING(LineData, 189,10) AS HIC_Number        
    ,CASE WHEN ISDATE(SUBSTRING(LineData,181,8)) = 1 THEN CAST(SUBSTRING(LineData, 181,8) AS DATE)        
    ELSE NULL        
     END AS HIC_Date        
    ,SUBSTRING(LineData, 142,10) AS Primary_Phone_Number -- ?        
    ,NULL as Secondary_Phone_Number -- ?        
    ,CASE WHEN ISDATE(SUBSTRING(LineData, 218,8)) = 1 THEN CAST(SUBSTRING(LineData, 218,8) AS DATE)        
    ELSE NULL        
     END AS Effective_Date        
    ,CASE WHEN ISDATE(SUBSTRING(LineData,226,8)) = 1 THEN CAST(SUBSTRING(LineData, 226,8) AS DATE)        
    ELSE NULL        
     END AS Term_Date        
    ,SUBSTRING(LineData, 300,30) AS PCP_ID_Overflow -- ?        
    ,SUBSTRING(LineData, 330,9) AS PCP_ID_Number -- ?        
    ,SUBSTRING(LineData, 406,3) AS Foreign_Language_Preference --?        
    ,SUBSTRING(LineData, 579,30) AS Miscellaneous_Code_1  -- street address 1 secondary        
    ,SUBSTRING(LineData, 609,30) AS Miscellaneous_Code_2 -- street address 2 secondary        
    ,SUBSTRING(LineData, 639,10) AS Miscellanoeus_Code_3 -- city secondary        
    ,SUBSTRING(LineData, 654,2) AS Miscellaneous_Code_4 -- state secondary         
    ,SUBSTRING(LineData, 656,5) AS Miscellaneous_Code_5 -- zip secondary             
    ,SUBSTRING(LineData, 238,40) AS Filler_01        
    ,SUBSTRING(LineData, 398,06) AS Filler_02        
    ,SUBSTRING(LineData, 405,1) AS Filler_03        
    FROM Import_Enrollment_LineData (NOLOCK)        
    WHERE LineID <> 1 and LineID <> (SELECT MAX(LineID) from Import_Enrollment_LineData (nolock))        
    --AND SUBSTRING(LineData, 775,9) NOT IN (select [LEGACY SUBSCRIBER ID] from [dbo].[TempNM_DSNP])-- 12/5 AA NEW FILTER FOR PNX FILE Import Process (NM)      
    ORDER BY LineID        
            
    -- moved parsed data to the download_members_temp table for processing and calculating         
    -- benfits, adding/updating members and disenrolling members        
        
    INSERT INTO Download_Members_Temp        
    SELECT DISTINCT        
    @Batch_id        
    ,null as Result_ID        
    ,d.First_Name        
    ,d.Middle_Initial        
    ,d.Last_Name        
    ,d.Member_Number        
    ,m.Plan_Code        
    ,null as Next_Month_Benefit          
    ,d.Date_of_Birth        
    ,d.Primary_Phone_Number        
    ,d.HIC_Number        
    -- we want to do a check to see if there is a second address and use that if yes        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN UPPER(d.Miscellaneous_Code_1) ELSE UPPER(d.Address1)        
     END AS Mail_Address_1        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN UPPER(d.Miscellaneous_Code_2) ELSE UPPER(d.Address2)        
     END AS Mail_Address_2        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN UPPER(d.Miscellaneous_Code_3) ELSE UPPER(d.City)        
     END as Mail_City        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN UPPER(d.Miscellaneous_Code_4) ELSE UPPER(d.State)        
     END as Mail_State        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN LEFT(d.Miscellaneous_Code_5,5) ELSE UPPER(LEFT(d.Zip_Code, 5))        
     END AS Mail_Zip        
    ,d.Sex        
    ,GETDATE()        
    ,null as Import_Status        
    ,null as County        
    ,null as IgnoreRecord        
    ,null as Next_Month_Benefit2        
    ,null as Next_Month_Benefit3        
    ,2 as Company_ID        
    ,d.Foreign_Language_Preference        
    -- if we had a secondary address, we will want to save the original primary address to the         
    -- misc fields so it can be added as a secondary address        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN upper(d.Address1) ELSE NULL        
     END        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN upper(d.Address2) ELSE NULL        
     END        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN upper(d.City) ELSE NULL        
     END        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN upper(d.State) ELSE NULL        
     END        
    ,CASE when isnull(d.Miscellaneous_Code_1,'') <> '' and isnull(d.Miscellaneous_Code_3,'') <> ''         
   and isnull(d.Miscellaneous_Code_4,'') <> '' and isnull(d.Miscellaneous_Code_5,'') <> ''         
   THEN LEFT(d.Zip_Code,5) ELSE NULL        
     END        
    ,null         
    ,[Group_Number]         
    ,[PCP_ID_Number]   
 ,cast(d.Effective_Date as Datetime) dt_effective    
 ,cast(d.term_date as datetime)  dt_term               
    FROM        
    Import_Enrollment_Detail_Work d (NOLOCK)        
    outer apply (select top 1 plan_code from          
    Benefit_Plan_Mapping mp where d.Group_Number = mp.Eligibility_Benefit_Code        
 and mp.dt_end >= getdate()       
    order by 1 desc        
    ) m        
 WHERE         
    --d.Effective_Date = (SELECT MAX(t.Effective_Date) FROM Import_Enrollment_Detail_Work t (nolock) where t.Member_Number = d.Member_Number and t.Effective_Date >= Convert(varchar, getdate(), 101))        
    --AND         
 --   isNull(d.Term_Date, '01/02/2018') >= '01/02/2018'        
 --AND       
     getdate() between cast(d.Effective_Date as datetime) and   
cast( ISNULL( d.Term_Date,DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GETDATE())+1,0))) as datetime)       
 --and -- OMIT ANY MEMBER WHO HAD PREVIOUSLY BEEN IN A COSMOS FILE AS THEY ARE NOW IN THE CSP FILE      
 --d.Member_Number NOT IN       
 ---(select LegacySubscriberID from TEMP_CSP_2018CONVERSION)      
       
 --and d.Member_Number NOT IN ( select [LEGACY SUBSCRIBER ID] from TempNM_DSNP)      
 -- 12/5 AA NEW FILTER FOR PNX FILE Import Process (NM)      
 --AND       
 --d.Member_Number NOT IN       
 --(      
 --SELECT [External_Member_ID]      
 -- FROM [OPTUM_OTC_TransactionDB].[dbo].[TEMP_CSP_MAPPING]      
 -- WHERE External_Member_ID IS NOT NULL      
 -- union       
 -- select OldID from       
 -- TEMP_HI_MEMBERS       
 -- WHERE [NewID] IS NOT NULL      
 -- )           
    -- create a record in the download call center table         
    -- to record the file results after the process is completed.            
    INSERT INTO Download_CallCenter        
    SELECT        
     'OTC'        
    ,@FileName        
    ,GETDATE()        
    ,NULL        
    ,NULL        
    ,(SELECT COUNT(*) FROM Download_Members_Temp (NOLOCK))         
    ,NULL        
    ,NULL        
    ,NULL        
    ,NULL        
    ,NULL        
    ,NULL        
    ,@process_id        
    ,2        
            
    DECLARE @DownloadId int = SCOPE_IDENTITY()        
            
    UPDATE Download_Members_Temp SET Download_ID = @DownloadId        
            
 -------------------------------------------        
 --File validations        
 ------------------------------------------        
        
    -- Missing Detail record        
    IF (SELECT COUNT(*) FROM Import_Enrollment_Detail_Work) = 0         
    BEGIN        
    SET @Ret_Var = 107         
    SET @Warning = @Warning + '; Missing Detail record'        
    GOTO __SPReturn        
    END        
        
    IF @Ret_Var = 0         
    BEGIN        
            
    EXEC @Ret_Var = dbo.Download_Members @Batch_Id, @DownloadId         
            
    SET @Error_Code = @@ERROR        
    IF (@Error_Code <> 0 Or @Ret_Var <> 0) BEGIN        
    SET @Ret_Var = CASE @Ret_Var        
                WHEN 0 THEN @Error_Code        
                ELSE @Ret_Var        
                       END;        
    GOTO __SPReturn;        
    END;             
            
    SET @Ret_Var = 20        
            
    END        
        
    __SPReturn:        
     
    -- Update file status        
    UPDATE Import_Batches WITH (UpdLock)        
    SET [Status] = @Ret_Var        
    , Warning = @Warning        
    WHERE Batch_ID = @Batch_ID        
        
    RETURN @Ret_Var        
         
END        
        
        
        
        
        
        
        
        
      
      
      
      
      
GO


