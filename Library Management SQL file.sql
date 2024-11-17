CREATE DATABASE library;
USE library;
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(200),
    Contact_no VARCHAR(15)
);
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3),
    Author VARCHAR(100),
    Publisher VARCHAR(100));
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE);
CREATE TABLE IssueStatus (Issue_Id INT PRIMARY KEY,Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));
    
    CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 101, '123 Main St, City Center', '9876543210'),
(2, 102, '456 Elm St, Downtown', '8765432109'),
(3, 103, '789 Pine St, Uptown', '7654321098');
select * from branch;
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(101, 'Alice Johnson', 'Manager', 75000, 1),
(102, 'Bob Smith', 'Manager', 72000, 2),
(103, 'Charlie Brown', 'Manager', 71000, 3),
(104, 'David Wilson', 'Librarian', 50000, 1),
(105, 'Emma Davis', 'Librarian', 48000, 2),
(106, 'Fiona Clark', 'Assistant', 30000, 3);
select * from employee;
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
(1001, 'The Great Gatsby', 'Fiction', 20, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
(1002, 'A Brief History of Time', 'Science', 25, 'yes', 'Stephen Hawking', 'Bantam Books'),
(1003, 'To Kill a Mockingbird', 'Fiction', 15, 'no', 'Harper Lee', 'J.B. Lippincott & Co.'),
(1004, 'Sapiens: A Brief History of Humankind', 'History', 30, 'yes', 'Yuval Noah Harari', 'Harper'),
(1005, '1984', 'Fiction', 18, 'no', 'George Orwell', 'Secker & Warburg'),
(1006, 'The Selfish Gene', 'Science', 28, 'yes', 'Richard Dawkins', 'Oxford University Press');
select * from books;
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(201, 'Grace Lee', '12 Maple St', '2020-12-15'),
(202, 'Henry Adams', '34 Oak St', '2022-02-20'),
(203, 'Isla Martinez', '56 Birch St', '2021-06-10'),
(204, 'Jack Brown', '78 Cedar St', '2023-03-25'),
(205, 'Katie Johnson', '90 Aspen St', '2020-11-30');
select * from customer;
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(301, 201, 'The Great Gatsby', '2023-06-10', 1001),
(302, 203, '1984', '2023-06-12', 1005),
(303, 204, 'Sapiens: A Brief History of Humankind', '2023-06-20', 1004);
select * from issuestatus;
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(401, 201, 'The Great Gatsby', '2023-06-15', 1001),
(402, 203, '1984', '2023-06-25', 1005);
select * from returnstatus;
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;
SELECT Books.Book_title, Customer.Customer_name 
FROM Books
JOIN IssueStatus ON Books.ISBN = IssueStatus.Isbn_book
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no;

SELECT Customer.Customer_name 
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';

SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(*) > 5;

SELECT Employee.Emp_name, Branch.Branch_address 
FROM Employee
JOIN Branch ON Employee.Emp_Id = Branch.Manager_Id;

SELECT Customer.Customer_name 
FROM Customer
JOIN IssueStatus ON Customer.Customer_Id = IssueStatus.Issued_cust
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
WHERE Books.Rental_Price > 25;














