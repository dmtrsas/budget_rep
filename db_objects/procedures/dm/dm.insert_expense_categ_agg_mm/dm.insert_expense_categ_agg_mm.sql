USE Budget
GO

IF OBJECT_ID('dm.insert_expense_categ_agg_mm') IS NOT NULL
	DROP PROCEDURE dm.insert_expense_categ_agg_mm;
GO

CREATE PROCEDURE dm.insert_expense_categ_agg_mm
AS
	BEGIN

	SET NOCOUNT ON;

	TRUNCATE TABLE dm_agg.expense_categ_agg_mm;

	WITH 
		agg
			AS
				(
					SELECT 
					  a.BANK
					, c.CARD_NAME
					, YEAR(t.TXN_DATE) AS CALYEAR
					, CONCAT(YEAR(t.TXN_DATE), FORMAT(t.TXN_DATE,'MM')) AS CALMONTH
					, SUM(t.BILL_AMOUNT) AS BILL_AMOUNT
					, CASE 
						WHEN t.BILL_CURRENCY = 'USD' THEN SUM(t.BILL_AMOUNT)*3.2
						WHEN t.BILL_CURRENCY = 'BYN' THEN SUM(t.BILL_AMOUNT)
					  END												AS BILL_AMOUNT_BYN
					, t.BILL_CURRENCY
					, CASE 
						WHEN t.TXN_CATEGORY LIKE (N'%Операции с наличными%') OR t.TXN_CATEGORY LIKE(N'%Снятие наличных%')
						THEN (N'Наличные')
						ELSE t.TXN_CATEGORY
						END												AS TXN_CATEGORY
					, t.MCC
					, t.user_id
					FROM dm.fct_transactions t
					JOIN dm.dim_cards c on c.ID = t.CARD_ID
					JOIN dm.dim_accounts a on a.ACCOUNT_NUMBER = t.ACCOUNT_NO
					WHERE 1=1
					AND t.BILL_AMOUNT < 0
					AND lower(t.TXN_CATEGORY) NOT LIKE (N'%переводы с карты на карту%')
					AND lower(t.TXN_CATEGORY) NOT LIKE (N'%денежные переводы%')
					AND lower(t.TXN_CATEGORY) NOT LIKE (N'%поставщик услуг%')
					GROUP BY 
					  c.CARD_NAME
					, a.BANK
					, YEAR(t.TXN_DATE)
					, CONCAT(YEAR(t.TXN_DATE), FORMAT(t.TXN_DATE,'MM'))
					, t.BILL_CURRENCY
					, t.TXN_CATEGORY
					, t.MCC
					, t.user_id
				)

	INSERT INTO dm_agg.expense_categ_agg_mm
	SELECT 
	  a.bank
	, a.card_name
	, a.calyear
	, a.calmonth
	, a.bill_amount
	, a.bill_amount_byn
	, a.bill_currency
	, a.txn_category
	, a.mcc
	, AVG(a.BILL_AMOUNT_BYN) OVER (PARTITION BY a.BANK, a.TXN_CATEGORY, a.MCC, a.user_id
								   ORDER BY a.calmonth ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) AS AMOUNT_THRESHOLD
	, a.user_id
	FROM agg a
	ORDER BY TXN_CATEGORY
	;
	END;
