# Lab | SQL Queries 8
### Instructions

	-- 1. Rank films by length.
select title, length, dense_rank() over (order by length desc) as 'Rank' from sakila.film;   

	-- 2. Rank films by length within the `rating` category.
select title, rating, length, dense_rank() over (partition by rating order by length desc) as 'Rank' from sakila.film;   

	-- 3. Rank languages by the number of films (as original language).
select*from sakila.film;
select*from sakila.language;

select tb.language_id, ta.name AS 'language', count(tb.film_id) AS 'number of films', rank() over (partition by name order by count(tb.film_id) DESC) as 'Rank' from sakila.language AS ta
join sakila.film AS tb
ON ta.language_id = tb.language_id
group by language_id; -- We only get one language because all films are in English. The other languages are counted as 0.

	-- 4. Rank categories by the number of films.
use sakila;
select title, count(film_id), dense_rank() over (partition by rating order by length desc) as 'Rank' from sakila.film;

select*from sakila.film_category;
select*from sakila.film;

SELECT ta.category_id, tb.name, count(ta.film_id) AS 'amount of films', rank() over (order by count(ta.film_id) DESC) as 'Rank' FROM sakila.film_category AS ta
JOIN sakila.category AS tb
ON ta.category_id = tb.category_id
group by category_id;

	-- 5. Which actor has appeared in the most films?
select*from sakila.actor;
select*from sakila.film_actor;

			#Group by actor and order by count(film_id)
SELECT tb.actor_id, tb.first_name, tb.last_name, count(ta.film_id) AS 'amount of films' FROM sakila.film_actor AS ta
LEFT JOIN sakila.actor AS tb
ON ta.actor_id = tb.actor_id 
group by actor_id
ORDER BY count(film_id) DESC;


	-- 6. Most active customer.
select*from customer;
select*from rental;
			# basically checking the count of rent_id from rental and joining customer on customer_id / having active=1 / and then group by and order by
            
SELECT b.active, a.customer_id, b.first_name, b.last_name, count(a.rental_id) AS 'amount of rentals' FROM sakila.rental AS a
LEFT JOIN sakila.customer AS b
ON a.customer_id = b.customer_id 
group by customer_id
having b.active = 1
ORDER BY count(rental_id) DESC;


	-- 7. Most rented film.
select*from film;
select*from rental;
select*from inventory;

use sakila;
SELECT a.title,a.film_id,COUNT(c.rental_date) as 'number_of_rented_films' from sakila.film AS a
LEFT JOIN sakila.inventory AS b 
ON a.film_id = b.film_id
LEFT JOIN sakila.rental AS c 
ON c.inventory_id = b.inventory_id
group by a.film_id
order by COUNT(c.rental_id) desc ; 