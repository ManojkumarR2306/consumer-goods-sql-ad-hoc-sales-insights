# Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, 
# segment 
		# product_count_2020 
		# product_count_2021 
		# difference 
with CTE1 AS (SELECT 
		P.segment AS A,
		count(Distinct(fs.product_code)) as B
		from dim_product p, fact_sales_monthly fs
		where p.product_code = fs.product_code
		group by fs.fiscal_year , p.segment
        having fiscal_year = "2020"), 
CTE2 AS (SELECT 
		P.segment as C,
		count(Distinct(fs.product_code)) as D
		from dim_product p, fact_sales_monthly fs
		where p.product_code = fs.product_code
		group by fs.fiscal_year , p.segment
        having fiscal_year = "2021")
SELECT 
		CTE1.A as segment,
		CTE1.B AS Product_count_2020,
        CTE2.D AS Product_count_2021,
        (CTE2.D - CTE1.B) as Difference
FROM CTE1,CTE2
WHERE CTE1.A = CTE2.C
order by Difference DESC ;