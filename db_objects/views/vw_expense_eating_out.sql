IF OBJECT_ID('vw_expense_eating_out') IS NOT NULL
    DROP VIEW vw_expense_eating_out

GO

CREATE VIEW [dbo].[vw_expense_eating_out]
AS
	WITH main
	AS (
		SELECT
		  t.user_id
		, YEAR(t.TXN_DATE) AS calyear
		, CONCAT(YEAR(t.TXN_DATE), FORMAT(t.TXN_DATE,'MM')) AS calmonth
		, c.CARD_NAME AS card_name
		, sum(t.BILL_AMOUNT) AS amount
		, t.BILL_CURRENCY AS account_currency
		, CASE 
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%burger king%') OR lower(t.TXN_DESCR) LIKE (N'%kfc%') OR lower(t.TXN_DESCR) LIKE (N'%ksb vi%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'Fast food'
		
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%pizz%') OR lower(t.TXN_DESCR) LIKE (N'%pitstsa%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812')
			THEN 'Pizza'
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%sushi%') OR lower(t.TXN_DESCR) LIKE (N'%godzilla%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812')
			THEN 'Sushi'
			
			WHEN	lower(t.TXN_DESCR) LIKE (N'%cofix%') OR lower(t.TXN_DESCR) LIKE (N'%hotfix%') OR lower(t.TXN_DESCR) LIKE (N'%paragra%') OR lower(t.TXN_DESCR) LIKE (N'%coffee%')
			THEN 'Coffee'
		
			ELSE 'Other'
		  END																																	AS category
		, CASE
			WHEN lower(t.TXN_DESCR) LIKE (N'%cofix%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'COFIX' 
			
			WHEN lower(t.TXN_DESCR) LIKE (N'%hotfix%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'HOTFIX'
			WHEN lower(t.TXN_DESCR) LIKE (N'%paragra%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'PARAGRAPH'
			WHEN lower(t.TXN_DESCR) LIKE (N'%burger king%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'BURGER KING' 
			WHEN lower(t.TXN_DESCR) LIKE (N'%kfc%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'KFC'
			WHEN lower(t.TXN_DESCR) LIKE (N'%ksb vi%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'MAK'
		
			WHEN (lower(t.TXN_DESCR) LIKE (N'%lisits%') OR lower(t.TXN_DESCR) LIKE (N'%lisizza%')) 
			 AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'PIZZA LISIZZA'
		
			WHEN lower(t.TXN_DESCR) LIKE (N'%godzilla%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'GODZILLA'
		
			WHEN (lower(t.TXN_DESCR) LIKE (N'%dikiy kot%') OR lower(t.TXN_DESCR) LIKE (N'%hancharyk%')) 
			 AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812' OR lower(t.TXN_CATEGORY) LIKE (N'развлечен%')) 
			THEN 'SHAKER QUIZ'
		
			WHEN lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR MCC = '5812' THEN 'OTHER'
		  END																																   AS merchant
		FROM dm.fct_transactions t
		JOIN dm.dim_cards c on c.ID = t.CARD_ID
		WHERE 1=1
		AND 
		(
			lower(t.TXN_DESCR) LIKE (N'%cofix%') OR
			lower(t.TXN_DESCR) LIKE (N'%hotfix%') OR
			lower(t.TXN_DESCR) LIKE (N'%paragra%') OR
			lower(t.TXN_DESCR) LIKE (N'%burger king%') OR
			lower(t.TXN_DESCR) LIKE (N'%kfc%') OR
			lower(t.TXN_DESCR) LIKE (N'%ksb vi%') OR 
			lower(t.TXN_DESCR) LIKE (N'%lisits%') OR
			lower(t.TXN_DESCR) LIKE (N'%godzilla%') OR
			lower(t.TXN_DESCR) LIKE (N'%dikiy kot%') OR
			lower(t.TXN_DESCR) LIKE (N'%hancharyk%') OR
			lower(t.TXN_CATEGORY) LIKE (N'%кафе%')
			
		
		)
		GROUP BY t.user_id
		, YEAR(t.TXN_DATE)
		, CONCAT(YEAR(t.TXN_DATE), FORMAT(t.TXN_DATE,'MM'))
		, c.CARD_NAME
		, t.BILL_CURRENCY
		, CASE 
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%burger king%') OR lower(t.TXN_DESCR) LIKE (N'%kfc%') OR lower(t.TXN_DESCR) LIKE (N'%ksb vi%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'Fast food'
		
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%pizz%') OR lower(t.TXN_DESCR) LIKE (N'%pitstsa%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812')
			THEN 'Pizza'
			WHEN	 lower(t.TXN_DESCR) LIKE (N'%sushi%') OR lower(t.TXN_DESCR) LIKE (N'%godzilla%') 
				AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812')
			THEN 'Sushi'
			
			WHEN	lower(t.TXN_DESCR) LIKE (N'%cofix%') OR lower(t.TXN_DESCR) LIKE (N'%hotfix%') OR lower(t.TXN_DESCR) LIKE (N'%paragra%') OR lower(t.TXN_DESCR) LIKE (N'%coffee%')
			THEN 'Coffee'
		
			ELSE 'Other'
		  END																																	
		, CASE
			WHEN lower(t.TXN_DESCR) LIKE (N'%cofix%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'COFIX' 
			
			WHEN lower(t.TXN_DESCR) LIKE (N'%hotfix%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'HOTFIX'
			WHEN lower(t.TXN_DESCR) LIKE (N'%paragra%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'PARAGRAPH'
			WHEN lower(t.TXN_DESCR) LIKE (N'%burger king%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'BURGER KING' 
			WHEN lower(t.TXN_DESCR) LIKE (N'%kfc%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'KFC'
			WHEN lower(t.TXN_DESCR) LIKE (N'%ksb vi%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'MAK'
		
			WHEN (lower(t.TXN_DESCR) LIKE (N'%lisits%') OR lower(t.TXN_DESCR) LIKE (N'%lisizza%')) 
			 AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'PIZZA LISIZZA'
		
			WHEN lower(t.TXN_DESCR) LIKE (N'%godzilla%') 
			AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812') 
			THEN 'GODZILLA'
		
			WHEN (lower(t.TXN_DESCR) LIKE (N'%dikiy kot%') OR lower(t.TXN_DESCR) LIKE (N'%hancharyk%')) 
			 AND (lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR t.MCC = '5812' OR lower(t.TXN_CATEGORY) LIKE (N'развлечен%')) 
			THEN 'SHAKER QUIZ'
		
			WHEN lower(t.TXN_CATEGORY) LIKE (N'%кафе%') OR MCC = '5812' THEN 'OTHER'
		  END	
	)
SELECT *
, CASE
	WHEN m.category = 'Coffee' THEN 1
	WHEN m.category = 'Fast food' THEN 2
	WHEN m.category = 'Other' THEN 3
	WHEN m.category = 'Pizza' THEN 4
	WHEN m.category = 'Sushi' THEN 5
  END	AS row_order
FROM main m
;
GO
