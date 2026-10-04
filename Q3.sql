--  A Summary Report with Conditional Flags
select CASE WHEN 
DATEDIFF( STR_TO_DATE (Dispatch_Date, "%d-%m-%Y"), STR_TO_DATE(PO_Date,"%d-%m-%Y" )  )>=3  
THEN 'Late' 
WHEN DATEDIFF( STR_TO_DATE (Dispatch_Date, "%d-%m-%Y"), STR_TO_DATE(PO_Date,"%d-%m-%Y" )  ) = 0
Then 'Early' else 'Quick' END as Flag,
PO_Number, PetrolPump_Name,
Quantity from jbp_Data ; 

-- For each pump, calculate the percentage change in quantity ordered month-over-month.
SELECT 
  PetrolPump_Name,
  DATE_FORMAT(STR_TO_DATE(PO_Date, '%d-%m-%Y'), '%Y-%m') AS Order_Month,
  SUM(Quantity) AS Total_Quantity,
  LAG(SUM(Quantity)) OVER (PARTITION BY PetrolPump_Name ORDER BY DATE_FORMAT(STR_TO_DATE(PO_Date, '%d-%m-%Y'), '%Y-%m')) AS Previous_Quantity,
  ROUND(
    ((SUM(Quantity) - LAG(SUM(Quantity)) OVER (PARTITION BY PetrolPump_Name ORDER BY DATE_FORMAT(STR_TO_DATE(PO_Date, '%d-%m-%Y'), '%Y-%m'))) 
     / LAG(SUM(Quantity)) OVER (PARTITION BY PetrolPump_Name ORDER BY DATE_FORMAT(STR_TO_DATE(PO_Date, '%d-%m-%Y'), '%Y-%m'))
    ) * 100, 2
  ) AS Percentage_Change
FROM jbp_data
GROUP BY PetrolPump_Name, Order_Month;

-- Each pump’s name, owner, opening time, total fuel ordered, and number of fuel types ordered."
SELECT distinct min(p.Operating_hrs) as time_opened ,
j.PetrolPump_Name,
p.Owner_name, SUM(j.Quantity) AS total_quantity , count(distinct j.Product_Type) as Fuel_count 
 from pumpdata as p
join jbp_data as j
on j.PetrolPump_Name= p.PetrolPump_Name
GROUP BY p.Owner_name, j.PetrolPump_Name; 
