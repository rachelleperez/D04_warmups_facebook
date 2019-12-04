
/* 

TABLE #1

'users' table

columns | type

id | int
name | varchar
joined_at | datetime
city_id | int
device_int

TABLE #2 

'user_comments' table

columns | type

user_id | int
body | text
created_at | datetime


ASSUMPTION:
*  "YYYY-MM-DD"
* 'users' table based on unique user ids (1 user per row) - despite 'device' column 


*/

-- PART 1

SELECT c.user_id, COUNT(c.user_id) as comment_count
FROM users u LEFT JOIN user_comments c ON u.id = c.user_id
WHERE c.create_at >= '2019-01-01' AND c.create_at <= '2019-01-31' -- assumption: date format is "YYYY-MM_DD"
GROUP BY c.user_id
ORDER BY c.user_id

--  Reference

SELECT oi.order_id, COUNT(oi.order_id) as count_1 
FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id 
WHERE o.order_purchase_timestamp >= '2016-01-01' AND o.order_purchase_timestamp < '2017-01-01' 
GROUP BY oi. order_id ORDER BY count_1 DESC;

-- PART 2 

WITH comment_count_by_user AS (
    SELECT c.user_id, COUNT(c.user_id) as comment_count
    FROM users u LEFT JOIN user_comments c ON u.id = c.user_id
    WHERE c.create_at >= '2019-01-01' AND c.create_at <= '2019-01-31' 
    GROUP BY c.user_id
    ORDER BY c.user_id)

SELECT generate_series(0,
            MAX(comment_count)) AS ts
FROM comment_count_by_user;


-- Reference

SELECT generate_series(min(start_timestamp)
                     , max(start_timestamp)
                     , interval '1 hour') AS ts
FROM   header_table;

-- Reference

CREATE TEMPORARY TABLE bins_test AS
    SELECT * FROM GENERATE_SERIES(0,10) AS bins_0_10;

-- Reference


  SELECT (to_char(serie,'yyyy-mm')) AS year, sum(amount)::int AS eintraege FROM (
    SELECT  
       COUNT(mytable.id) as amount,   
       generate_series::date as serie   
       FROM mytable  

    RIGHT JOIN generate_series(  

       (SELECT min(date_from) FROM mytable)::date,   
       (SELECT max(date_from) FROM mytable)::date,  
       interval '1 day') ON generate_series = date(date_from)  
       WHERE version = 1   
       GROUP BY generate_series       
       ) AS foo  
  GROUP BY Year   
  ORDER BY Year ASC; 

-- Reference
WITH order_count_by_order_2016 AS (
    SELECT oi.order_id, COUNT(oi.order_id) as count_1 
    FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id 
    WHERE o.order_purchase_timestamp >= '2016-01-01' AND o.order_purchase_timestamp < '2017-01-01' 
    GROUP BY oi. order_id ORDER BY count_1 DESC)

SELECT generate_series(0
                     , max(count_1)) AS cs
FROM   order_count_by_order_2016;  

-- Reference

WITH order_count_by_order_2016 AS (
    SELECT oi.order_id, COUNT(oi.order_id) as count_1 
    FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id 
    WHERE o.order_purchase_timestamp >= '2016-01-01' AND o.order_purchase_timestamp < '2017-01-01' 
    GROUP BY oi. order_id ORDER BY count_1 DESC)

SELECT g.cs, COUNT(count_1)
FROM generate_series(0, max(oc.count_1)) AS cs FROM order_count_by_order_2016 AS g
        INNER JOIN order_count_by_order oc ON g.cs = oc.count_t
GROUP BY COUNT(count_1);

--------------------------

-- ANSWER FORMAT, WITH OLIST KAGGLE DATASET

WITH order_count_by_order_2016 AS (
    SELECT oi.order_id, COUNT(oi.order_id) as count_1 
    FROM order_items oi LEFT JOIN orders o ON oi.order_id = o.order_id 
    WHERE o.order_purchase_timestamp >= '2016-01-01' AND o.order_purchase_timestamp < '2017-01-01' 
    GROUP BY oi. order_id ORDER BY count_1 DESC)

SELECT count_1 AS order_count, COUNT(order_id)
FROM order_count_by_order_2016
GROUP BY count_1
ORDER BY count_1;

 order_count | count
-------------+-------
           1 |   276
           2 |    25
           3 |     5
           4 |     3
           5 |     1
           6 |     2

---------------------------------------------  

-- FINAL ANSWER 

WITH comment_count_by_user AS (
    SELECT c.user_id, COUNT(c.user_id) as comment_count
    FROM users u LEFT JOIN user_comments c ON u.id = c.user_id
    WHERE c.create_at >= '2019-01-01' AND c.create_at <= '2019-01-31'
    GROUP BY c.user_id
    ORDER BY c.user_id)

SELECT comment_count, COUNT(user_id)
FROM comment_count_by_user
GROUP BY comment_count
ORDER BY comment_count;