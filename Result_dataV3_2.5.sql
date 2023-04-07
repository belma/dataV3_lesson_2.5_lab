USE sakila;

/* 1. Select all the actors with the first name ‘Scarlett’.
*/

SELECT * FROM actor 
WHERE first_name = 'Scarlett';

/* 2. How many physical copies of movies are available for rent in the store's inventory? 
How many unique movie titles are available?
*/

-- THIS IS NOT CLEAR TO ME. 
-- THERE ARE MORE COPIES THAN INVENTORY, LOGICALLY,  SO I LOOK UP COPIES IN RENTAL TABLE: 

SELECT COUNT(inventory_id) FROM rental; -- physical copies = 16044 available copies
SELECT COUNT(film_id) FROM Inventory; -- films  available  iN inventory = 4581 but this is not NECCESSARILY  the same als Unique film titles. 
SELECT COUNT(DISTINCT title) FROM film; -- unique film titles checked in table film are 1000; 


/* 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
*/
-- SELECT * from film;
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

/* 4. What's the average movie duration expressed in format (hours, minutes)?
*/
-- SELECT AVG(length) AS 'Average movie duration' FROM film;

SELECT TIME_FORMAT(SEC_TO_TIME(AVG(length * 60)),'%H:%i') 
AS 'Average movie duration' 
FROM film;

/* 5. How many distinct (different) actors' last names are there?
*/

SELECT DISTINCT last_name FROM actor; -- 121 different names 

/* 6. How many days was the company operating? Assume the last rental date was their closing date. (check DATEDIFF() function)
*/

-- Select min(rental_date) from rental; 
SELECT DATEDIFF(day,
    (SELECT MIN(rental_date) FROM rental),  
    (SELECT MAX(rental_date) FROM rental));  

/* 7. Show rental info with additional columns month and weekday. Get 20 results.
*/
SELECT * , MONTH(rental_date) AS MONTH, WEEKDAY(rental_date) AS WEEKDAY FROM rental;  -- Number for weekday starts with 0, why? 

/* 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
*/
SELECT * ,
MONTH(rental_date) AS MONTH, 
WEEKDAY(rental_date) AS WEEKDAY, 
CASE WHEN WEEKDAY(rental_date) IN (5,6) 
THEN 'Weekend' 
ELSE 'Workday' 
END AS day_type
FROM rental;


/* 9. Get release years.
*/
SELECT film_id, title, release_year FROM film;

-- or the distinct of available release years?? 
SELECT DISTINCT release_year FROM film; -- all fims were released in year 2006. 


/* 10. Get all films with ARMAGEDDON in the title.
*/
SELECT * 
FROM film
WHERE title LIKE '%ARMAGEDDON%'; -- 6 films have this in title

/* 11. Get all films which title ends with APOLLO.
*/
SELECT * FROM film
WHERE title like '%APOLLO'; -- 5 films end with thisin their title

/* 12. Get 10 the longest films.
*/
SELECT * FROM film 
ORDER BY length DESC
LIMIT 10; -- see output

/* 13. How many films include Behind the Scenes content?
*/
SELECT count(film_id) FROM film
WHERE special_features 
LIKE '%behind the scenes%'; -- 538 films
