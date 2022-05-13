/*For this question you’ll need to use SQL. Follow this link to access the data set required for the challenge. Please use queries to answer the following questions. Paste your queries along with your final numerical answers below */

/* a) How many orders were shipped by Speedy Express in total?*/

SELECT COUNT(Orders.ShipperID)
FROM Orders
JOIN Shippers
ON Orders.ShipperID = Shippers.ShipperID
WHERE Shippers.ShipperName = "Speedy Express";

-- Answer: 54

/* b) What is the last name of the employee with the most orders?*/

SELECT LastName
FROM Employees
WHERE EmployeeID =
    (SELECT EmployeeID
    FROM Orders
    GROUP BY EmployeeID
    ORDER BY COUNT(EmployeeID) DESC
    LIMIT 1);

-- Answer: Peacock

/* c) What product was ordered the most by customers in Germany?*/

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

-- Answer: Gorgonzola Telino



