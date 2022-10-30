/* Joining Data in SQL
Course Description
Joining data is an essential skill which enables us to draw information from separate tables together into 
a single, meaningful set of results. Learn to supercharge your queries using table joins and 
relational set theory in this course on joining data.

In this course, you’ll learn how to:
- Work with more than one table in SQL
- Use inner joins, outer joins and cross joins
- Leverage set theory, including unions, intersect, and except clauses
- Create nested queries

Every step is accompanied by exercises and opportunities to apply the theory and 
grow your confidence in SQL. */

/*1 Introducing Inner Joins

In this chapter, you’ll be introduced to the concept of joining tables and will explore all the ways you can enrich your queries
using joins—beginning with inner joins.
*/

/* 1-1: Your first join
Throughout this course, you'll be working with the countries database, which contains information 
about the most populous world cities and countries, and provides country-level economic data, population data, 
and geographic data. 
The database also contains information on languages spoken in each country.

You can see the different tables in this database to get a sense of what they contain by clicking on the corresponding tabs. 
Click through them and familiarize yourself with the fields that seem to be shared across tables before 
you continue with the course.

In this exercise, you'll use the cities and countries tables to build your first inner join. 
You'll start off by selecting all columns in step 1, performing your join in step 2, 
and then refining your join to choose specific columns in step 3.

Instructions
-Complete the SELECT statement to keep only the name of the city, the name of the country, 
and the region the country is located in (in the order specified).
-Alias the name of the city AS city and the name of the country AS country.
*/

-- Select name fields (with alias) and region 
SELECT cities.["name"] AS city, countries.["country_name"] as country, countries.["region"]
FROM cities
INNER JOIN [dbo].countries
ON [dbo].cities.["country_code"] = countries.["code"];

/* 1-2: Joining with aliased tables
Recall that instead of writing full table names in queries, you can use table aliasing as a shortcut. 
The alias can be used in other parts of your query, such as the SELECT statement!

You also learned that when you SELECT fields, a field can be ambiguous. For example, imagine two tables, 
apples and oranges, both containing a column called color. 
You need to use the syntax apples.color or oranges.color in your SELECT statement to point SQL to the correct table. 
Without this, you would get the following error:

column reference "color" is ambiguous

In this exercise, you'll practice joining with aliased tables. You'll use data from both the countries 
and economies tables to examine the inflation rate in 2010 and 2015.

When writing joins, many SQL users prefer to write the SELECT statement after writing the join code, 
in case the SELECT statement requires using table aliases.

Instructions
- Start with your inner join; join the tables countries AS c (left) with economies (right), aliasing economies AS e.
- Next, use code as your joining field. 
- Lastly, select the following columns in order: code from the countries table (aliased as country_code), 
  name, year, and inflation_rate.
*/
-- Select fields with aliases
SELECT c.["code"] AS country_code, ["country_name"], ["year"], ["inflation_rate"]
FROM countries AS c
-- Join to economies (alias e)
INNER JOIN economies AS e
-- Match on code field using table aliases
ON c.["code"] = e.["code"];

/* 1-3: Joining multiple tables
You've seen that the ability to combine multiple joins using a single query is a powerful feature of SQL.

Suppose you are interested in the relationship between fertility and unemployment rates. 
Your task in this exercise is to join tables to return the country name, year, fertility rate, 
and unemployment rate in a single result from the countries, populations and economies tables.
*/

-- Select fields
SELECT c.["country_name"], e.["year"], p.["fertility_rate"], e.["unemployment_rate"]
FROM countries AS c
INNER JOIN populations AS p
ON c.["code"] = p.["country_code"]
-- Join to economies (as e)
inner join economies as e
-- Match on country code
ON p.["country_code"] = e.["code"];

/* 1-3 bis: Checking multi-table joins

Have a look at the results for Albania from the previous query below. 
You can see that the 2015 fertility_rate has been paired with 2010 unemployment_rate, and vice versa:

name	year	fertility_rate	unemployment_rate
Albania	2015	1.663				17.1
Albania	2010	1.663				14
Albania	2015	1.793				17.1
Albania	2010	1.793				14

Instead of four records, the query should return two: one for each year. 
The last join was performed on c.code = e.code, without also joining on year. 
Your task in this exercise is to fix your query by explicitly stating that both 
the country code and year should match!

Instructions
- Modify your query so that you are joining to economies on year as well as code. */

-- Select fields
SELECT c.["country_name"], e.["year"], p.["fertility_rate"], e.["unemployment_rate"]
FROM countries AS c
INNER JOIN populations AS p
ON c.["code"] = p.["country_code"]
-- Join to economies (as e)
inner join economies as e
-- Match on country code
ON p.["country_code"] = e.["code"]
-- Add an additional joining condition such that you are also joining on year
and p.["year"] = e.["year"];

