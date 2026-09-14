CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @total_start_time DATETIME;
    SET @total_start_time = GETDATE();
    BEGIN TRY
        PRINT '=====================================';
        PRINT 'Loading bronze layer';
        PRINT '=====================================';

        PRINT '-------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '-------------------------------------';

        -- ===== crm_cust_info =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_cust_info<<'
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>>Inserting data Into: bronze.crm_cust_info<<'
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------';

        -- ===== crm_prd_info =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_prd_info<<'
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>>Inserting data Into: bronze.crm_prd_info<<'
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- ===== crm_sales_details =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.crm_sales_details<<'
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>>Inserting data Into: bronze.crm_sales_details<<'
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '-------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '-------------------------------------';

        -- ===== erp_CUST_AZ12 =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_CUST_AZ12<<'
        TRUNCATE TABLE bronze.erp_CUST_AZ12;
        PRINT '>>Inserting data Into: bronze.erp_CUST_AZ12<<'
        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- ===== erp_LOC_A101 =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_LOC_A101<<'
        TRUNCATE TABLE bronze.erp_LOC_A101;
        PRINT '>>Inserting data Into: bronze.erp_LOC_A101<<'
        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- ===== erp_PX_CAT_G1V2 =====
        SET @start_time = GETDATE();
        PRINT '>>Truncating Table: bronze.erp_PX_CAT_G1V2<<'
        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
        PRINT '>>Inserting data Into: bronze.erp_PX_CAT_G1V2<<'
        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\Users\Pro\Desktop\Dataware house project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', TABLOCK);
        SET @end_time = GETDATE();
        PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        -- ===== TOTAL =====
        PRINT '=====================================';
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(second, @total_start_time, GETDATE()) AS NVARCHAR) + ' seconds';
        PRINT '=====================================';

    END TRY
    BEGIN CATCH
        PRINT '==================================';
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: '  + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: '   + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================';
        -- Optional: also print elapsed time up to failure
        PRINT 'Elapsed before error: ' + CAST(DATEDIFF(second, @total_start_time, GETDATE()) AS NVARCHAR) + ' seconds';
    END CATCH
END;
GO

EXEC bronze.load_bronze;



DECLARE @t1 DATETIME = GETDATE();
EXEC bronze.load_bronze;
DECLARE @t2 DATETIME = GETDATE();
PRINT 'Total bronze load: ' + CAST(DATEDIFF(second, @t1, @t2) AS NVARCHAR) + ' seconds';
