/*Sales order analysis*/
/*which category is most popular */
SELECT p.Product_ID,
p.category,
 p.sub_category,
 round(sum(o.Sales),0) AS TopSelling
FROM globalsales.products AS P
JOIN globalsales.orders AS o
ON o.Product_ID = p.Product_ID
GROUP BY Category, Sub_Category
ORDER BY TopSelling DESC
limit 10;

/*total profit earned from product categories each year*/
SELECT p.Product_ID, 
p.Product_Name,
p.category,
round(sum(o.Profit),2) as total_profit,
YEAR(str_to_date(o.order_date, '%d/%m/%Y')) as YEAR
FROM globalsales.orders as o
JOIN globalsales.products as p
ON p.Product_ID = o.Product_ID
GROUP BY category, YEAR
ORDER BY total_profit DESC;

/*Country, city and state with the best sells each year*/
SELECT c.Country,
c.city,
c.state,
round(sum(o.Sales),0) AS best_selling,
YEAR(STR_TO_DATE(o.Order_Date, '%d/%m/%Y')) AS order_year
FROM globalsales.orders AS o
JOIN globalsales.customers AS c
ON o.Customer_ID =c.Customer_ID
GROUP BY order_year
ORDER BY order_year DESC;

/*identifying the performance of each city, state, and country*/
SELECT 
  ROUND(AVG(o.sales), 0) AS average_sales,
  c.city,
  c.state,
  c.country,
  CASE
    WHEN AVG(o.sales) >= 300 THEN 'High Performing'
    WHEN AVG(o.sales) >= 200 THEN 'Average'
    ELSE 'Under Performing'
  END AS performance
FROM 
  globalsales.customers AS c
  JOIN globalsales.orders AS o ON c.customer_id = o.customer_id
GROUP BY 
  c.city, c.state, c.country
HAVING 
  performance IS NOT NULL;
  
/*average order value BY cateorgy and sub-category*/
 SELECT p.category,
 count(O.order_id) AS order_count,
 round(sum(o.sales),0) AS total_sales,
 round(sum(o.sales)/ count(Order_ID),0) AS average_order_value
 FROM globalsales.orders AS o
 JOIN globalsales.products AS p
 ON p.product_id = o.Product_ID
 GROUP BY Category;
 
/*Customers analysis section*/
/*average order value by customer segment */
SELECT c.segment,
  COUNT(o.Order_ID) AS order_count,
  SUM(o.Sales) AS total_sales,
  SUM(o.Sales) / COUNT(o.Order_ID) AS avg_order_value
FROM globalsales.orders AS o
JOIN globalsales.customers AS c
  ON o.Customer_ID = c.Customer_ID
GROUP BY c.segment;

/*Identifying the distribution of customers by state, city and country */
SELECT count(customer_id) as customers,
city, 
state,
country 
 FROM globalsales.customers
 GROUP BY city, state, country
 ORDER BY customers DESC;

/*customer order pattern*/
SELECT c.customer_id,
c.customer_name,
count(o.order_id) AS order_pattern,
o.product_id
FROM globalsales.orders AS o
JOIN globalsales.customers AS c
ON o.customer_id = c.Customer_ID
GROUP BY customer_ID
ORDER BY order_pattern DESC;

/*average shipping cost per order*/
SELECT order_id,
Shipping_Cost,
count(Order_ID) AS order_count,
round(sum(Shipping_Cost),2) AS Shipping_expense,
round(count(order_id)/sum(Shipping_cost),2) AS average_shipping_cost
FROM globalsales.orders
GROUP BY Order_ID;

/*most common shipping method*/
SELECT p.Category, count(o.order_id) AS frequency, o.Ship_Mode
FROM globalsales.orders AS o
JOIN globalsales.products AS p ON p.Product_ID = o.Product_ID
GROUP BY Category, Ship_Mode
ORDER BY p.Category, frequency DESC


