# Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields, 
		# product_code 
		# product 
		# manufacturing_cost (max = '240.5364', min = 0.8920)
select 
		mc.product_code,
		p.product,
        mc.manufacturing_cost
from fact_manufacturing_cost mc
join dim_product p using (product_code)
having 
	mc.manufacturing_cost 
    in (
		(select min(manufacturing_cost) from fact_manufacturing_cost),
		(select max(manufacturing_cost) from fact_manufacturing_cost)
        );
        
        
        