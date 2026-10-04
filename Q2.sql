-- Total quantity ordered (in KL) for each product type.
Select distinct Product_Type, 
 SUM(Quantity) as quantity_per_product 
 From jbp_data 
 group by Product_Type; 

-- Amount of each product ordered 
SELECT Product_Type, COUNT(*) AS type_count
FROM jbp_data
GROUP BY Product_Type;
 
 --  Total quantity and total revenue group by location and product type .
SELECT distinct Product_Type,
Location , SUM(Quantity) as Total_quantity ,
SUM( Quantity * Rate_per_KL) as Total_revenue 
from jbp_data
group by Product_Type , Location ; 

-- Rank petrol pumps based on total amount spent in descending order.
Select SUM(Total_amount) as Total_sales ,
PetrolPump_Name,
Rank() over (order by SUM(Total_amount) desc) as pump_rank 
from jbp_data
group by PetrolPump_Name ; 

-- Find the moving average of daily quantity ordered for XP95 fuel whose payment is done.

Select Location, PetrolPump_Name , 
avg(Quantity) as Average_quantity
from jbp_data
Where  Product_Type = 'XP95' and Payment_Status= 'Paid' 
group by Location, PetrolPump_Name  ; 

-- The first order (by date) of each petrol pump .
    
    Select distinct PetrolPump_Name, 
    min(Date) as First_orderday , Location, 
    SUM(Quantity*Rate_per_KL) as Total_revenue 
    from jbp_data 
    group by  PetrolPump_Name, Location ; 
