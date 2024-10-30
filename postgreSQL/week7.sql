1. In ra thông tin của một nhân viên theo quy cách sau đây:
TITLE. FIRST_NAME LAST_NAME (START_DATE – END_DATE)


in ra thông tin của tất cả nhân viên  :

    SELECT 
        CONCAT(TITLE, '. ', FIRST_NAME, ' ', LAST_NAME, ' (', START_DATE, ' – ', END_DATE, ')') AS employee_info
    FROM 
        employee

in ra thông tin của một nhân viên cụ thể theo id : 

    SELECT 
        CONCAT(TITLE, '. ', FIRST_NAME, ' ', LAST_NAME, ' (', START_DATE, ' – ', END_DATE, ')') AS employee_info
    FROM 
        employee
    WHERE 
        EMP_ID = <id nhân viên>;

2. Thực hiện lần lượt hai thay đổi sau đối với toàn bộ mã khách hàng trong cơ sở
dữ liệu:
    - Bổ sung thêm ‘100’ trước mã khách hàng.
    - Loại bỏ số ‘100’ ở đầu mã khách hàng bạn vừa thêm vào.

    Do  cust_id đang là khóa ngoại ở một số bảng khác cho nên ban đầu chúng ta sẽ xóa liên kết khóa ngoại 

        ALTER TABLE account DROP CONSTRAINT account_cust_id_fkey;
        ALTER TABLE business DROP CONSTRAINT business_cust_id_fkey;
        ALTER TABLE individual DROP CONSTRAINT individual_cust_id_fkey;
        ALTER TABLE officer DROP CONSTRAINT officer_cust_id_fkey;

    tiếp theo cập nhật lại cust id cho tất cả các bảng :
    đổi custid thành text và dùng cộng text để gán 100 vào trước sau đó ép kiểu thành int

        UPDATE customer
        SET CUST_ID = ('100' || CUST_ID::TEXT)::INT;

        UPDATE account
        SET CUST_ID = ('100' || CUST_ID::TEXT)::INT;

        UPDATE business
        SET CUST_ID = ('100' || CUST_ID::TEXT)::INT;

        UPDATE individual
        SET CUST_ID = ('100' || CUST_ID::TEXT)::INT;

        UPDATE officer
        SET CUST_ID = ('100' || CUST_ID::TEXT)::INT;

    sau khi cập nhật xong thì chúng ta thêm liên kết khóa ngoại vào : 

        ALTER TABLE account ADD CONSTRAINT account_cust_id_fkey FOREIGN KEY (CUST_ID) REFERENCES customer(CUST_ID);
        ALTER TABLE business ADD CONSTRAINT business_cust_id_fkey FOREIGN KEY (CUST_ID) REFERENCES customer(CUST_ID);
        ALTER TABLE individual ADD CONSTRAINT individual_cust_id_fkey FOREIGN KEY (CUST_ID) REFERENCES customer(CUST_ID);
        ALTER TABLE officer ADD CONSTRAINT officer_cust_id_fkey FOREIGN KEY (CUST_ID) REFERENCES customer(CUST_ID);

    để  loại bỏ '100' ra khỏi cust id thì chúng ta làm tương tự khác mỗi phần thay đổi cust id :
    sử dụng SUBTR để cắt 3 kí tự đầu ra khỏi custid

        UPDATE customer
        SET CUST_ID = SUBSTR(CUST_ID::TEXT,4)::INT;

        UPDATE account
        SET CUST_ID = SUBSTR(CUST_ID::TEXT,4)::INT;

        UPDATE business
        SET CUST_ID = SUBSTR(CUST_ID::TEXT,4)::INT;

        UPDATE individual
        SET CUST_ID = SUBSTR(CUST_ID::TEXT,4)::INT;

        UPDATE officer
        SET CUST_ID = SUBSTR(CUST_ID::TEXT,4)::INT;

3. Thêm 03 bản ghi vào bảng quản lý khách hàng với POSTAL_CODE là NULL.
In ra toàn bộ các POSTAL_CODE khác NULL và đếm số khách hàng theo từng
nhóm POSTAL_CODE.

    INSERT INTO customer (CUST_ID, ADDRESS, CITY, CUST_TYPE_CD, FEED_ID, POSTAL_CODE, STATE) VALUES
    (1000, '123 Main St', 'New York', 'I', '123456', null, 'NY'),
    (2000, '456 Elm St', 'Los Angeles', 'B', '789012', null, 'CA');
    (3000, '589 Cool St', 'Hoston', 'H', '348912', null, 'HO');

    SELECT POSTAL_CODE, COUNT(*) AS total_cus
    FROM customer 
    WHERE POSTAL_CODE IS NOT NULL
    GROUP BY POSTAL_CODE;

4. In ra các thông tin sau của những giao dịch được thực hiện vào tháng 1/2000 hoặc
tháng 12/2004.
- Mã giao dịch
- Số tiền
- Ngày giao dịch, trong đó loại bỏ tất cả các thông tin cụ thể về giờ, phút, giây.

    SELECT
        TXN_ID,
        AMOUNT,
        DATE(TXN_DATE) AS TRANSACTION_DATE
    FROM
        acc_transaction
    WHERE
        (EXTRACT(YEAR FROM TXN_DATE) = 2000 AND EXTRACT(MONTH FROM TXN_DATE) = 1)
        OR (EXTRACT(YEAR FROM TXN_DATE) = 2004 AND EXTRACT(MONTH FROM TXN_DATE) = 12);

5. In ra thông tin của các khách hàng trên 50 tuổi, sắp xếp tăng dần theo tuổi của họ.

    Chúng ta sẽ sử dụng phép nối 2 bảng customer và individual :

        SELECT
            c.CUST_ID,
            i.FIRST_NAME,
            i.LAST_NAME,
            c.ADDRESS,
            c.CITY,
            c.STATE,
            c.POSTAL_CODE,
            EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM i.BIRTH_DATE) AS AGE
        FROM
            customer c
        JOIN
            individual i ON c.CUST_ID = i.CUST_ID
        WHERE
            EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM i.BIRTH_DATE) > 50
        ORDER BY
            EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM i.BIRTH_DATE);

6. In ra tên và chức danh của tất cả các giao dịch viên. Trong đó, in tên của họ theo
quy cách sau đây:
[Ký tự đầu tiên và cuối cùng của FIRST_NAME]. [LAST_NAME]
Ví dụ, John Blake sẽ được hiển thị là Jn. Blake.

SELECT 
    CONCAT(SUBSTRING(FIRST_NAME, 1, 1), SUBSTRING(FIRST_NAME, LENGTH(FIRST_NAME), 1), '. ', LAST_NAME) AS FULL_NAME,
    TITLE
FROM 
    employee
WHERE
    TITLE LIKE '%Giao dich vien%';