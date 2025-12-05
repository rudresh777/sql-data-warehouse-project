/*
==================================================================================
Stored Procedure: Load Bronze Layer (Source »> Bronze)
==================================================================================
Script Purpose:
This stored procedure loads data into the 'bronze" schema from external (SV flles.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the "BULK INSERT" comand to load data from esv Files to bronze tables.
onze sql
abase sal

Parameters:
None.
This stored procedure does not accept any paraseters or return any values.

Usage Example:
EXEC bronze.load_bronze;
=====================================================================================
  */
create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime , @end_time datetime ,@batch_start_time datetime,@batch_end_time datetime;
	begin try
		set @batch_start_time = GETDATE();
		print '=================================================' ;
		print 'Loading Bronze Layer' ;
		print '=================================================';

		print '-------------------------------------------------';
		print ' Loading CRM Tables';
		print '-------------------------------------------------';
		set @start_time = getdate();
		print '>> truncating table : bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		print '>> incerting data into : bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);

			set @end_time = getdate();

		print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
		print '>>---------------------------------';
			set @start_time = getdate();
		print '>> truncating table : bronze.crm_prd_info';
		truncate table bronze.crm_prd_info;
		print '>> incerting data into : bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			set @end_time = getdate();
			print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
			print '>>---------------------------------';
		set @start_time = getdate();
		print '>> truncating table : bronze.crm_sales_details';

		truncate table bronze.crm_sales_details;
		print '>> incerting data into : bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);

			set @end_time = getdate();
			print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
			print '>>---------------------------------';
		print '-------------------------------------------------';
		print ' Loading CRM Tables';
		print '-------------------------------------------------';
			set @start_time = getdate();
		print '>> truncating table : bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;
		print '>> incerting data into : bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			set @end_time = getdate();
			print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
			print '>>---------------------------------';
				set @start_time = getdate();
		print '>> truncating table : bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print '>> incerting data into : bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			set @end_time = getdate();
			print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
			print '>>---------------------------------';
				set @start_time = getdate();
		print '>> truncating table : bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print '>> incerting data into : bronze.erp_cust_az12';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\rudre\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			set @end_time = getdate();
			print '>> load duration:' +cast(datediff(second,@start_time , @end_time) as varchar)+'second'; 
			print '>>---------------------------------';
			set @batch_end_time = GETDATE();
			print '====================================';
			print 'loading bronze layer is completed';
			print 'total load duration:' +cast(datediff(second , @batch_start_time , @batch_end_time) as varchar)+'second';
			print '====================================';
		end try
		begin catch 
			print '====================================';
			print 'error occured during loading bronze layer'
			print 'error message'+ error_message();
			print 'error message'+ cast(error_number() as nvarchar);
			print 'error message' + cast(error_state() as nvarchar);
		end catch
	end

	
