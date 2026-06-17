drop table if exists zepto;
create table zepto( sku_id serial primary key,
category varchar(120),
name varchar(150) not null ,
mrp numeric(8,2),
discountpercent numeric(5,2),
availablequantity int ,
discountedsellingprice numeric(8,2),
weightingms integer ,
outofstocks bool,
quantity int
);

--counting the no of rows 
select count(*) from zepto ;

--sample 
select * from zepto
limit 10 ;

--- NULL VALUES 
select * from zepto 
where sku_id is null 
or 
category is null 
or 
name IS NULL
or 
mrp is null 
or 
discountpercent is null 
or 
availablequantity is null 
or 
discountedsellingprice is null 
or 
weightingms is null
or outofstocks is null;

--DIFFERENT PRODUCT CATEGORY
SELECT distinct category from zepto
order by category ;

--product in stock vs product in outofstocks
SELECT outofstocks , COUNT(outofstocks) from zepto
group by outofstocks

--product which are present multiple times 
SELECT name, COUNT(name) FROM zepto
GROUP BY name
having count(name)>1
order by count(name)desc;

--data cleaning
--products with price=0

select * from zepto
where mrp ='0' or discountedsellingprice='0'

delete from zepto
where  mrp ='0' or discountedsellingprice='0'

--convert paise to rupees
update zepto
set mrp=mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0

--Q1 top 10 best value products based on the discount percentage 

select distinct * from zepto
order by discountpercent desc
limit 10;

--Q2 what are the products with high MRP but out of stock

select distinct name , mrp,outofstocks from zepto 
where outofstocks=TRUE and mrp>300
order by mrp desc;

---Q3 calculate estimated revenue for each category

select category, sum(discountedsellingprice*availablequantity) AS total_revenue from zepto
group by category  
order by total_revenue 

--Q4. Find all products where Mrp is greater than 500₹ and discount is less than 10%.
select distinct name,mrp, discountpercent from zepto
where mrp>500 and discountpercent<10
order by mrp desc, discountpercent desc;

--Q5. identify the top 5 categories offering the highest AVERAGE DISCOUNT PERCentage
select Distinct category,round(avg(discountpercent),2) as average  from zepto
group by category
order by average desc
limit 5;

--Q6 find the price per gram for products above 100g and sort by best value
select distinct name, weightingms, discountedsellingprice, round((discountedsellingprice/weightingms),2) as price_per_gram from zepto
where weightingms >=100 
order by price_per_gram asc;

--Q7 group the products into categories like low , medium , bulk
select distinct name,
case
      when(weightingms<=1000)then 'low'
	  when(weightingms between 1000 and 5000)then'medium'
	  else 'bulk'  
end as weight_category
from zepto 

--Q8  what is the total invenotry weight per category
select category,
sum(weightingms * availablequantity) as total_weight
from zepto 
group by category
order by total_weight;
 


 



 


