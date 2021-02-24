/*      
=================================================================      
������Ʈ��	: usp_account_import
������ƮŸ��	: PROCEDURE      
�����ۼ���	: 2021-02-08      
�����ۼ���	: ������     
��ɼ���		: ������ �������� Import   
���࿹��		:	declare @In_filename varchar(100)
				declare @date varchar(10)

				set		@date =convert(varchar(10),getdate(),112)
				set		@In_filename = 'ro1_kr_db_baphomet_'+@date+'.csv'

				exec    usp_account_import 'kr_ro1_baphomet_account','D:\TEMP', @filename=@In_filename
���༭��		: metabase      
-----------------------------------------------------------------      
�߰��۾����� :        
=================================================================      
*/
alter procedure [dbo].[usp_account_import] 
		@tb varchar(100),
		@path varchar(60),			-- db path
		@filename varchar(40)		-- filename
AS	
SET NOCOUNT ON
SET XACT_ABORT ON

declare @Del_date	varchar(10)
declare @fullname	varchar(100)	-- fullname
 

set		@Del_date =convert(varchar(10),getdate()-1,121)
set		@path = @path + '\'
set		@fullname = @path + @filename 

 
-- data delete 
exec('
IF EXISTS (select * from '+@tb+' where reg_date = '''+@Del_date+''' )
BEGIN
			delete from '+@tb+' where reg_date = '''+@Del_date+'''
END
')

-- data bulk insert
exec ( 'bulk insert '+@tb+' from '+''''+@fullname+''''+' with (FIELDTERMINATOR ='''+','+''''+')' )

 