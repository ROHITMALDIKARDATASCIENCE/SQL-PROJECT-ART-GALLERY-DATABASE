-- step 1 . create the databse
CREATE DATABASE Art;

-- step 2 . switch to databse
use Art;

-- step 3 . create tables 
CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY,
    Name VARCHAR(100),
    BirthYear INT,
    Nationality VARCHAR(50)
);

CREATE TABLE Artworks (
    ArtworkID INT PRIMARY KEY,
    Title VARCHAR(100),
    ArtistID INT,
    Year INT,
    Medium VARCHAR(50),
    Price DECIMAL(10, 2),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Exhibitions (
    ExhibitionID INT PRIMARY KEY,
    Title VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ArtworkID INT,
    CustomerID INT,
    SaleDate DATE,
    SalePrice DECIMAL(10, 2),
    FOREIGN KEY (ArtworkID) REFERENCES Artworks(ArtworkID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20)
);

-- Step 4: Insert sample data into the categories table

INSERT INTO Artists (ArtistID, Name, BirthYear, Nationality) VALUES
(1, 'Pablo Picasso', 1881, 'Spanish'),
(2, 'Vincent van Gogh', 1853, 'Dutch'),
(3, 'Claude Monet', 1840, 'French'),
(4, 'Leonardo da Vinci', 1452, 'Italian'),
(5, 'Frida Kahlo', 1907, 'Mexican');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, Year, Medium, Price) VALUES
(1, 'Guernica', 1, 1937, 'Oil on canvas', 200000000.00),
(2, 'Starry Night', 2, 1889, 'Oil on canvas', 100000000.00),
(3, 'Water Lilies', 3, 1919, 'Oil on canvas', 50000000.00),
(4, 'Mona Lisa', 4, 1503, 'Oil on poplar', 850000000.00),
(5, 'The Two Fridas', 5, 1939, 'Oil on canvas', 30000000.00);

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate) VALUES
(1, 'Modern Art Masters', '2024-01-01', '2024-03-01'),
(2, 'Impressionist Art', '2024-03-15', '2024-06-15');

INSERT INTO Customers (CustomerID, Name, Email, Phone) VALUES
(1, 'John Doe', 'john@example.com', '123-456-7890'),
(2, 'Jane Smith', 'jane@example.com', '987-654-3210');

INSERT INTO Sales (SaleID, ArtworkID, CustomerID, SaleDate, SalePrice) VALUES
(1, 1, 1, '2024-01-15', 200000000.00),
(2, 3, 2, '2024-02-20', 50000000.00);

#SUBQUERIES
#1. Find the name of the artist who sold the most expensive artwork.
SELECT Name
FROM Artists
WHERE ArtistID = (SELECT ArtistID
                  FROM Artworks
                  WHERE Price = (SELECT max(Price) FROM Artworks));

#2.List the artworks that have not been sold.
SELECT Title
FROM Artworks
WHERE ArtworkID NOT IN (SELECT ArtworkID FROM Sales);

#3.Find the total sales made in each exhibition.
SELECT e.Title, SUM(s.SalePrice) AS TotalSales
FROM Sales s
JOIN Artworks a ON s.ArtworkID = a.ArtworkID
JOIN Exhibitions e ON a.ArtworkID IN (SELECT ArtworkID FROM Exhibitions WHERE ExhibitionID = e.ExhibitionID)
GROUP BY e.Title;

#4.Get the customers who have bought artworks worth more than $100,000.
SELECT Name
FROM Customers
WHERE CustomerID IN (SELECT CustomerID
                     FROM Sales
                     WHERE SalePrice > 100000);
                     
#5.Find the total number of artworks created by each artist.
SELECT Name, (SELECT COUNT(*)
              FROM Artworks
              WHERE ArtistID = a.ArtistID) AS ArtworkCount
FROM Artists a;

#LIKE Pattern Matching
#1.Find all artists whose name starts with 'P'.
SELECT * FROM Artists
WHERE Name LIKE 'P%';

#2.List all artworks that have the word 'The' in the title.
SELECT * FROM Artworks
WHERE Title LIKE '%The%';

#3.Find all customers with email addresses from the domain 'example.com'.
SELECT * FROM Customers
WHERE Email LIKE '%@example.com';

#4.Find all artworks created in the 1900s.
SELECT * FROM Artworks
WHERE Year LIKE '19__';

#5.List all exhibitions that end in the month of June.
SELECT * FROM Exhibitions
WHERE EndDate LIKE '%-06-%';

Conclusion
The Art Gallery Database project successfully demonstrated the creation and management of a relational database using SQL.
By following best practices in database design and SQL query writing, we have built a solid foundation for managing the data needs of an art gallery.
This project highlights the importance of structured data management and the power of SQL in achieving it.

Key Components
Database Design:

1.Tables: We designed and created several tables to capture the essential entities involved in an art gallery.
These include Artists, Artworks, Customers, and Sales.
Relationships: We defined relationships between these tables using foreign key constraints to ensure data integrity.
For example, the Sales table references both Artworks and Customers.

2.Data Types and Constraints:
We carefully chose appropriate data types for each column, such as VARCHAR for text fields, 
INT for numeric identifiers, and DECIMAL for monetary values.
We implemented primary key constraints to uniquely identify records and foreign key constraints to maintain referential integrity.

3.SQL Queries:
Basic Operations: We demonstrated basic SQL operations, including creating tables, inserting data,
and retrieving data using the SELECT statement.
Advanced Operations: We explored more advanced SQL operations, such as joins, subqueries, and aggregate functions. 
For example, calculating the total sales using a combination of JOIN and SUM functions.
Pattern Matching: We utilized the LIKE operator for pattern matching to filter results based on specific criteria.






