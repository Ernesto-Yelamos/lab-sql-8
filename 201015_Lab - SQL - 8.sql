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
/*
select*from sakila.film_actor;

SELECT ta.actor_id, tb.first_name, tb.last_name, count(ta.film_id) AS 'amount of films', rank() over (order by ta.actor_id) as 'Rank' FROM sakila.film_actor AS ta
JOIN sakila.actor AS tb
ON ta.actor_id = tb.actor_id;
group by actor_id;

select count(film_id) from sakila.film_actor;

SELECT ta.actor_id, tb.first_name, tb.last_name FROM sakila.film_actor AS ta
JOIN sakila.actor AS tb
ON ta.actor_id = tb.actor_id;
*/


	-- 6. Most active customer.
    select*from customer;
select first_name, last_name, active, dense_rank() over (partition by active) as 'Rank' from sakila.customer
order by active DESC;   


	-- 7. Most rented film.
/*
select*from film;
select*from rental;

select inventory_id, count(rental_date) from sakila.rental
group by inventory_id; -- basic operation to clear my thoughts

select inventory_id, count(rental_date) from sakila.rental
group by inventory_id;

SELECT ta.film_id, ta.title, tb.inventory_id FROM sakila.film AS ta
JOIN sakila.inventory AS tb
ON ta.film_id = tb.film_id
JOIN sakila.rental AS tc
ON tb.inventory_id = tc.inventory_id; -- checking joined tables

SELECT ta.film_id, ta.title, count(ta.title) AS 'amount films', count(tc.rental_date) AS 'amount rentals', tb.inventory_id, dense_rank() over (partition by ta.title order by ta.film_id) AS 'rank' FROM sakila.film AS ta
JOIN sakila.inventory AS tb
ON ta.film_id = tb.film_id
JOIN sakila.rental AS tc
ON tb.inventory_id = tc.inventory_id
group by title;
*/