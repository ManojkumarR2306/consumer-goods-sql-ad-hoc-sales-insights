# Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
# The final output contains these fields
		# division 
		# product_code 
        # product
		# total_sold_quantity
		# rank_order 
with product_sales as 
			( select 
					p.division,
					p.product_code,
					p.product,
					round(sum(s.sold_quantity),2) as total_sold_quantity,
                    dense_rank() over(partition by p.division order by sum(s.sold_quantity) DESC) as rank_order
				from dim_product p
                join fact_sales_monthly s
				using (product_code)
                where s.fiscal_year = 2021
                group by p.division,
						p.product_code,
						p.product
                 )
select 
		division,
		product_code, 
        product,
		total_sold_quantity,
		rank_order
from product_sales
where rank_order <=3
order by division, rank_order;