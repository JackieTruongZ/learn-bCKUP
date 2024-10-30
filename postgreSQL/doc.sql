

First to using postgresql  :

    - enter in postgresql by terminal : 

        >>> sudo -u postgres psql 

    - change password : 

        >>> \password

    - list database : 

        >>> \l 

    - create database :

        >>> CREATE DATABASE <database_name>

    - switch database :

        >>> \c database_name

    - delete database :

        >>> DROP DATABASE database_name;

        or if u want with out error when the database_name not exist 

        >>> DROP DATABASE IF EXIST database_name;
    - list all table :
        >>> \dt
    - describe table : 
        >> \d table_name
        or for more infor
        >> \dt+ table_name
    - rename a table :
        >> ALTER TABLE table_name RENAME TO new_table_name;
    - delete a table :
        >> DROP TABLE table_name;
        or if u want with out error when the table_name not exist
        >>> DROP TABLE If EXIST table_name;

alright after those steps we have a database and now we will handle crud for data on database

Create table : 

    Base create  :
    
        >>> CREATE TABLE table_name();

        example :

            CREATE TABLE author(
                author_id SERIAL PRIMARY KEY,
                first_name VARCHAR(100) NOT NULL,
                last_name VARCHAR(100) NOT NULL
            );

            CREATE TABLE books(
                book_id SERIAL PRIMARY KEY,
                title VARCHAR(100) NOT NULL,
                published_year INT
            );
        
    Add a Foreign Key to books :
        >>> ALTER TABLE books ADD COLUMN author_id INT REFERENCES authors(author_id);
    
    Base input data into the tables :
        insert data for authors table : 
            INSERT INTO authors(first_name, last_name)
            VALUES ('Nguyen','Dat'), ('Nguyen','Van A'), ('Nguyen','Van B');
        insert data for books table :
            INSERT INTO books(title, published_year, author_id) 
            VALUES ('Sach day lam giau', 2020,1), ('Sach day nau an', 2021,2), ('Sach day lam nguoi', 2024,3);

Section 1 : Querying Data 
Select : 

The SELECT statement has the following clauses:
    - Select distinct rows using DISTINCT operator.
    - Sort rows using ORDER BY clause.
    - Filter rows using WHERE clause. 
        some operator for WHERE : 
            + AND 
            + OR 
            + IN : return values in list : 
                >>> values IN (values1, values2,...);
                using IN with list date we using "cast operator" :
                    payment_date::date
                    >>> WHERE payment_date::date IN ('2024-09-07','2024-01-01');
            + BETWEEN : return values is between a range of values :
                >>> values BETWEEN low AND high;k
            + LIKE : return values matches a pattern :
                >>> values LIKE pattern 
                wildcards : "_" , "%"
            

    - Select a subset of rows from a table using LIMIT or FETCH clause.
    - Group rows into groups using GROUP BY clause.
    - Filter groups using HAVING clause.
    - Join with other tables using joins such as INNER JOIN, LEFT JOIN, FULL OUTER JOIN, CROSS JOIN clauses.
    - Perform set operations using UNION, INTERSECT, and EXCEPT.