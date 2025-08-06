# Generate a report which contains the top 5 customers who received an  average high  pre_invoice_discount_pct  for the  fiscal  year 2021  
# and in the  Indian  market. The final output contains these fields, 
		# customer_code 
		# customer 
		# average_discount_percentage
select 
		ps.customer_code,
		c.customer ,
		round(avg(pre_invoice_discount_pct)*100,2) as average_discount_percentage
from fact_pre_invoice_deductions ps 
join dim_customer c using (customer_code)
where c.market = "India" and
	ps.fiscal_year = 2021
group by 
		ps.customer_code,
		c.customer
order by average_discount_percentage DESC
limit 5 ;