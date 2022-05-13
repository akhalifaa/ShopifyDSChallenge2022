# ShopifyDSChallenge2022

## Question 1: Given some sample data, write a program to answer the following: click here to access the required data set

**On Shopify, we have exactly 100 sneaker shops, and each of these shops sells only one model of shoe. We want to do some analysis of the average order value (AOV). When we look at orders data over a 30 day window, we naively calculate an AOV of $3145.13. Given that we know these shops are selling sneakers, a relatively affordable item, something seems wrong with our analysis.** 

My assumptions: Given that the sneaker shops only sell one shoe model, and that all models are at an affordable price, I did my analysis of AOV based on the data of the collective stores. In practice, however, individual businesses analyze their own AOV's and other central tendency metrics to make business and marketing decisions

**a) Think about what could be going wrong with our calculation. Think about a better way to evaluate this data.**

It is not good practice to fixate on only one measure of central tendency when analyzing data. An AOV of 3145 dollars (total revenue/number of orders) is way to expensive to be the average price a customer pays on an order, specially if all items are assumed to be affordable. Additionally, a standard deviation of 41,282 dollars is HUGE, indicating a wide spread of order amounts. Furthermore, an average of around 8 items sold per order seems steep and unrealistic. When I took a quick look at the most expensive orders, I found red flags with the biggest one being the fact that user 607 ordered 704,000 worth of sneakers 17 times from shop 42 all in the same month of March of 2017, spending around 12 million on sneakers. Now, either this billionaire user's bank doesn't impose a credit limit on their card or its a major data error in the set...lets go with the latter option!

Having said all that, there is clear evidence that outlier data in this set are negatively skewing the distribution of order amount. That is why when we take the AOV, we arrive at a skewed expensive number that is a misrepresentation of customer behavior regarding these 100 sneaker shops. Therefore, no effective business or marketing decisions can be made off this number.

A better way to evaluate this data is to either look at all/other central tendency metrics as a starting point or clean up the data from outliers and report the new AOV. In terms of a starting point, we can evaluate the average order value based on the median or mode of the data. Another way to go about it is to remove outliers that are assumed to be errors and recalculate central tendency metrics. I did that by creating a new column in our data-frame of order_amount/total_items to obtain the price paid per item for every order. I then removed any outlier orders in this column via the IQR method assuming these odd outliers to be pure errors in the set and recalculated the central tendencies of the new set.

**b) What metric would you report for this dataset?**

The mode of the raw data set at the initial stage and/or further analysis and thorough outlier removal and then the recalculating mean. The mode is a great metric as it represents the most frequent price paid by customers (repeated 87 times out of 258 unique order amounts) and thus captures a confident idea of customer behavior towards the 100 stores. After outlier removal, the maximum per item price paid in any store was 201 dollars, which I would be confident in categorizing as an affordable sneaker on the higher end.

**c) What is its value?**

Mode of raw data set = 153 dollars. Mean of clean data set = 300.1 dollars. Although, I would definitely recommend observing all measures of central tendencies (median, mode, mean).


## Question 2: For this question you’ll need to use SQL. Follow this link to access the data set required for the challenge. Please use queries to answer the following questions. Paste your queries along with your final numerical answers below.

**a) How many orders were shipped by Speedy Express in total?**

```
SELECT COUNT(Orders.ShipperID)
FROM Orders
JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID
WHERE Shippers.ShipperName = "Speedy Express";
```
Answer: 54

**b) What is the last name of the employee with the most orders?**

```
SELECT LastName
FROM Employees
WHERE EmployeeID =
    (SELECT EmployeeID
    FROM Orders
    GROUP BY EmployeeID
    ORDER BY COUNT(EmployeeID) DESC
    LIMIT 1);
```
Answer: Peacock

**c) What product was ordered the most by customers in Germany?**

```
SELECT ProductName
FROM Products
WHERE ProductID =
    (SELECT ProductID
    FROM OrderDetails
    JOIN Orders
    ON OrderDetails.OrderID = Orders.OrderID
    JOIN Customers
    ON Orders.CustomerID = Customers.CustomerID
    WHERE Country = "Germany"
    GROUP BY ProductID
    ORDER BY COUNT(ProductID) DESC
    LIMIT 1);
```
Answer: Gorgonzola Telino

