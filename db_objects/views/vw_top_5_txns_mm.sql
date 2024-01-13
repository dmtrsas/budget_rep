IF OBJECT_ID('vw_top_5_txns_mm') IS NOT NULL
    DROP VIEW vw_top_5_txns_mm

GO

CREATE VIEW [dbo].[vw_top_5_txns_mm]
AS
WITH main 
	AS 
		(
		SELECT 
			user_id
		,	CASE 
				WHEN bill_currency = 'USD'
				THEN ABS(bill_amount)*3.2
				WHEN bill_currency = 'BYN'
				THEN ABS(bill_amount)
			END																						AS abs_bill_amt
		,	CONCAT(YEAR(TXN_DATE), FORMAT(TXN_DATE,'MM'))											AS calmonth
		,	TXN_DESCR																				AS txn_descr
		,	TXN_CATEGORY																			AS txn_category
		,	RANK() OVER (PARTITION BY CONCAT(DATEPART(mm,TXN_DATE),YEAR(TXN_DATE)), user_id 
						 ORDER BY CASE 
									WHEN bill_currency = 'USD'
									THEN ABS(bill_amount)*3.2
									WHEN bill_currency = 'BYN'
									THEN ABS(bill_amount)
								  END DESC)															AS txn_amt_rank
		FROM dm.fct_transactions
		WHERE 1=1
		and bill_amount < 0
		and lower(txn_category) not like (N'%переводы с карты на карту%')
		and lower(txn_category) not like (N'%денежные переводы%')
		and lower(txn_category) not like (N'%поставщик услуг%')
		and lower(txn_category) not like (N'%снятие наличных%')
		and lower(txn_category) not like (N'%операции с наличными%')
		)
SELECT *
FROM main
WHERE 1=1
and txn_amt_rank <=5
and calmonth >= '202201'
;
GO
