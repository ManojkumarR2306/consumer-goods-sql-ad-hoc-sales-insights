# Which channel helped to bring more gross sales in the fiscal year 2021 and 
 # the percentage of contribution?  The final output  contains these fields, 
			# channel 
			# gross_sales_mln 
			# percentage 
WITH CTE1 AS 
(SELECT
        c.channel,
        ROUND(SUM(g.gross_price * s.sold_quantity) / 1000000, 2) AS gross_sales_mln
    FROM fact_sales_monthly s 
    JOIN fact_gross_price g ON s.product_code = g.product_code 
    JOIN dim_customer c ON c.customer_code = s.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY c.channel
)
SELECT
    channel,
    gross_sales_mln,
    ROUND((gross_sales_mln / sum(gross_sales_mln) over()) *100,  2) AS Percentage
FROM CTE1 
ORDER BY Percentage DESC;