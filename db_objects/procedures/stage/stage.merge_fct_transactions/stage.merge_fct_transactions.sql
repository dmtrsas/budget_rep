USE Budget
GO

IF OBJECT_ID('stage.merge_fct_transactions') IS NOT NULL
	DROP PROCEDURE stage.merge_fct_transactions;
GO

CREATE PROCEDURE stage.merge_fct_transactions
AS
	BEGIN

	SET NOCOUNT ON;

	WITH 
		txn_stage
			AS
				(
					SELECT 
						TXN_DATE
					  , TXN_TIME
					  , TXN_DESCR
					  , TXN_AMOUNT
					  , TXN_CURRENCY
					  , BILL_DATE
					  , ACCOUNT_NO
					  , BILL_AMOUNT
					  , BILL_CURRENCY
					  , PAN
					  , TXN_CATEGORY
					  , ROW_HASH
					  , MCC
						FROM stage.statements
				)

	MERGE INTO dm.fct_transactions old
		USING (
				SELECT 
					  t.txn_date						as txn_date
					, t.txn_time						as txn_time
					, t.txn_descr						as txn_descr
					, t.txn_amount						as txn_amount
					, t.txn_currency					as txn_currency
					, t.bill_date						as bill_date
					, a.account_number					as account_no
					, t.bill_amount						as bill_amount
					, t.bill_currency					as bill_currency
					, c.card_number						as pan
					, t.txn_category					as txn_category
					, NULL								as txn_type
					, NULL								as transfer_from
					, NULL								as transfer_to
					, a.id								as account_id
					, c.id								as card_id
					, CASE 
						WHEN a.bank = 'Priorbank'
						THEN '9999'
						ELSE t.mcc
					  END								as mcc
					, getdate()							as insert_dt
					, NULL								as update_dt
					, t.row_hash						as row_hash
					, c.user_id							as user_id
				FROM txn_stage t
				JOIN dm.dim_cards c on c.card_number = t.pan OR c.accno = t.account_no
				JOIN dm.dim_accounts a on c.accno = a.account_number
				) new
			ON old.row_hash = new.row_hash
		WHEN NOT MATCHED THEN
			INSERT
			(
				  txn_date						 
				, txn_time						 
				, txn_descr						 
				, txn_amount					 
				, txn_currency					 
				, bill_date						 	
				, account_no					 
				, bill_amount					 
				, bill_currency					 	
				, pan							 
				, txn_category												 
				, txn_type						 
				, transfer_from					 
				, transfer_to					 
				, account_id					 
				, card_id						 
				, mcc
				, insert_dt
				, update_dt
				, row_hash
				, user_id
			)
			VALUES
			(
				  new.txn_date	
				, new.txn_time		
				, new.txn_descr
				, new.txn_amount	
				, new.txn_currency	
				, new.bill_date	
				, new.account_no	
				, new.bill_amount	
				, new.bill_currency
				, new.pan			
				, new.txn_category
				, new.txn_type
				, new.transfer_from
				, new.transfer_to
				, new.account_id	
				, new.card_id		
				, new.mcc
				, new.insert_dt
				, new.update_dt
				, new.row_hash
				, new.user_id
				);

	TRUNCATE TABLE stage.statements;

END;