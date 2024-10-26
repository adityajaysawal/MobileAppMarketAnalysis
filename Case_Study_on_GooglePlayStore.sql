USE googleplaystore;
TRUNCATE TABLE playstore;

LOAD DATA INFILE "D:/SQL_QUERY/GooglePlayStore/playstore.csv"
INTO TABLE playstore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 rows ;

select * from playstore;

/* Q1. You're working as a market analyst for a mobile app development company. Your task is to identify the most promising categories (TOP 5)
 for launching new free apps based on their average ratings. */
 
SELECT category, round(avg(Rating),2) from playstore
WHERE Type='Free'
GROUP BY category
ORDER BY avg(Rating) DESC
LIMIT 5;

/* Q2. As a business strategist for a mobile app company, your objective is to pinpoint the three categories that generate the 
most revenue from paid apps. This calculation is based on the product of the app price and its number of installations. */

SELECT Category, ROUND(avg(revenue),2) as avg_rev FROM (SELECT *, (Installs*Price) as 'revenue' FROM playstore
where Type= 'Paid') t
GROUP BY Category
ORDER BY avg_rev
LIMIT 5;

/* Q3. As a data analyst for a gaming company, you're tasked with calculating the percentage of games within each category. 
This information will help the company understand the distribution of gaming apps across different categories. */

SELECT *, round((cnt/(SELECT count(*) FROM playstore))*100,2) as 'PCT' FROM
(SELECT category, count(app) as 'cnt' FROM playstore
GROUP BY category) t;

/* Q4.	As a data analyst at a mobile app-focused market research firm you’ll recommend whether the company should develop paid or 
free apps for each category based on the ratings of that category. */

WITH t1 as
(SELECT category,round(avg(Rating),2) as avg_paid FROM playstore
WHERE TYPE='Paid'
GROUP BY category),
t2 as (SELECT category,round(avg(Rating),2) as avg_free FROM playstore
WHERE TYPE='Free'
GROUP BY category) 
SELECT *, IF (avg_paid>avg_free, 'Develop paid apps','Develop free apps') as decision FROM
(SELECT a.category,avg_paid,avg_free FROM t1 as a JOIN t2 as b ON a.category=b.category) t
;
/* Q5. Suppose you're a database administrator your databases have been hacked and hackers are changing price of certain apps on the database,
 it is taking long for IT team to neutralize the hack, however you as a responsible manager don’t want your data to be changed, 
 do some measure where the changes in price can be recorded as you can’t stop hackers from making changes. */
 
CREATE TABLE pricechange( app VARCHAR(255),
old_price DECIMAL(10,2),
new_price DECIMAL(10,2),
operation_type VARCHAR(255),
operation_date TIMESTAMP
);
SELECT * FROM pricechange;

-- copy of table
CREATE TABLE play
as SELECT * FROM playstore;

DELIMITER //
CREATE TRIGGER price_change
AFTER UPDATE
ON play
FOR EACH ROW
BEGIN
	INSERT INTO pricechange(app,old_price, new_price,operation_type,operation_date)
    VALUES(new.app,old.price, new.price,'update', CURRENT_TIMESTAMP());
END ;
// DELIMITER ;

UPDATE play
SET price=8
WHERE app='Sketch - Draw & Paint';

/* Q6. Your IT team have neutralized the threat; however, hackers have made some changes in the prices, but because of your measure 
you have noted the changes, now you want correct data to be inserted into the database again. */

-- update + join
DROP TRIGGER price_change;
UPDATE play as a 
INNER JOIN pricechange as b
ON a.app=b.app
SET a.price= b.old_price;
SELECT * FROM play WHERE app='Sketch - Draw & Paint';

/* Q7. As a data person you are assigned the task of investigating the correlation between two numeric factors: app ratings and the quantity 
of reviews. */

SET @x = (SELECT round(avg(Rating),2) FROM playstore);
SET @y = (SELECT round(avg(reviews),2) FROM playstore);

WITH t as
(
SELECT *, (rat*rat) as 'sqr_x', (rev*rev) as 'sqr_y'
FROM
(
SELECT rating, @x, round((rating-@x),2) as 'rat', reviews, @y, round((reviews-@y),2) as 'rev' FROM playstore
)k
)
SELECT @numerator:=sum((rat*rev)),@deno1:=sum(sqr_x),@deno2:=sum(sqr_y) FROM t;
SELECT round(@numerator/(sqrt(@deno1*@deno2)),2) as corre_coeficient;

/* Q8. Your boss noticed  that some rows in genres columns have multiple genres in them, which was creating issue when developing the 
recommender system from the data he/she assigned you the task to clean the genres column and make two genres out of it, 
rows that have only one genre will have other column as blank.  */

SELECT * FROM playstore;

DELIMITER //
CREATE FUNCTION f_name(a varchar(255))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	SET @l =locate(';',a) ;
    SET @s = IF (@l>0,LEFT(a,@l-1),a) ;
    RETURN @s ;
END ;
// DELIMITER ;

SELECT f_name('Aditya;jais');
 
DELIMITER //
CREATE FUNCTION l_name(a VARCHAR(255))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
	SET @l =locate(';',a) ;
    SET @s = IF (@l=0,' ',substring(a,@l+1,length(a))) ;
    RETURN @s ;
END ;
// DELIMITER ;

SELECT l_name('Aditya;jais');

SELECT genres, f_name(genres) as first_name, l_name(genres) as last_name FROM play;

/* Q9. Your senior manager wants to know which apps are not performing as per in their particular category, however he is not interested in 
handling too many files or list for every  category and he/she assigned  you with a task of creating a dynamic tool where he/she  
can input a category of apps he/she  interested in  and your tool then provides real-time feedback by displaying apps within that 
category that have ratings lower than the average rating for that specific category. */

SELECT Category, Rating, round(avg_rating,2) FROM (SELECT Category, Rating, 
AVG(rating) OVER(PARTITION BY Category) as avg_rating
FROM playstore) t
WHERE Rating<avg_rating;
SELECT * FROM playstore;

/* 10. Identify the fastest-growing app category: Write a query to find the top 3 app categories with the highest growth rate in the 
number of installs over time. */
SELECT * FROM playstore;
SELECT Category, 
       (MAX(Installs) - MIN(Installs)) / (DATEDIFF(MAX(Last_Updated), MIN(Last_Updated))) AS GrowthRate
FROM playstore
GROUP BY Category
ORDER BY GrowthRate DESC
LIMIT 3;

/* 11. Monthly revenue trends: Analyze and return the total revenue per month for paid apps, segmented by app category. */

SELECT EXTRACT(MONTH FROM Last_Updated) AS Month, 
       Category, 
       SUM(Price * Installs) AS TotalRevenue
FROM playstore
WHERE Type = 'Paid'
GROUP BY Month, Category
ORDER BY Month, TotalRevenue DESC;


/* 12. Identify top apps by region: create a query that identifies the top-rated app in 
each category. */

SELECT category, App, MAX(Rating) AS HighestRating
FROM playstore
GROUP BY category, App
ORDER BY category, HighestRating DESC;


/* 13. App performance over time: Write a query to calculate the average rating of apps in each category for every quarter of the year. */

SELECT category, EXTRACT(YEAR FROM Last_updated) as year ,
EXTRACT(QUARTER FROM Last_updated) as QT, 
round(AVG(rating),2) as avg_rating
from playstore
GROUP BY category, year, QT
ORDER BY year, QT;

/* 14. App popularity ranking: Create a query that ranks apps within each category based on the combination of ratings and number of 
reviews. */

SELECT Category, App, 
       RANK() OVER (PARTITION BY Category ORDER BY (Rating * Reviews) DESC) AS PopularityRank
FROM playstore;

/* 15. Free to paid conversion rate: Calculate the conversion rate of free apps to paid apps over time, considering only apps that moved 
from the free model to a paid model. */

SELECT Category, 
       COUNT(CASE WHEN Type = 'Paid' THEN 1 END) / COUNT(CASE WHEN Type = 'Free' THEN 1 END) AS ConversionRate
FROM playstore
GROUP BY Category
ORDER BY ConversionRate DESC;


/* 16. Identify user engagement patterns: Find the apps with the highest review-to-install ratio, which might indicate strong 
user engagement. */

SELECT App, (Reviews / Installs) AS EngagementRatio
FROM playstore
ORDER BY EngagementRatio DESC;

/* 17. Detect potential fraud: Identify apps with a disproportionately high number of installs compared to their average rating. */
SELECT App, Installs, Rating
FROM playstore
WHERE Installs > 100000 AND Rating < 2.0;


/* 18. Genre trend over time: Track the number of new apps added to each genre over the past year to identify emerging trends. */

SELECT EXTRACT(YEAR FROM Last_Updated) AS Year, Genres, COUNT(App) AS NewApps
FROM playstore
GROUP BY Year, Genres
ORDER BY Year DESC, NewApps DESC;

/* 19. Identify apps with extreme price variations: Write a query that highlights the top 10 apps with the largest price swings 
within a year. */

SELECT App, MAX(Price) - MIN(Price) AS PriceVariation
FROM playstore
GROUP BY App
ORDER BY PriceVariation DESC
LIMIT 10;

/* 20. Monitor review spikes: Identify apps with sudden surges in the number of reviews within a short time frame to detect potential 
marketing efforts or review manipulation. */
select * from playstore;
SELECT App, 
       (MAX(Reviews) - MIN(Reviews)) / DATEDIFF(MAX(Last_Updated), MIN(Last_Updated)) AS ReviewGrowthRate
FROM playstore
GROUP BY App
HAVING ReviewGrowthRate > 1000
ORDER BY ReviewGrowthRate DESC;


/* 21. Segment apps by audience type: Write a query that groups apps by their content rating (e.g., Everyone, Teen, Mature) and 
calculates the average revenue per app in each group. */

SELECT Content_Rating, AVG(Price * Installs) AS AvgRevenue
FROM playstore
WHERE Type = 'Paid'
GROUP BY Content_Rating
ORDER BY AvgRevenue DESC;

/* 22. Analyze app success post-update: Compare the average rating before and after the last update for all apps to assess if updates 
improve user satisfaction. */

SELECT App, 
       AVG(CASE WHEN Last_Updated < CURDATE() - INTERVAL 7 YEAR THEN Rating END) AS AvgRatingBefore,
       AVG(CASE WHEN Last_Updated >= CURDATE() - INTERVAL 7 YEAR THEN Rating END) AS AvgRatingAfter
FROM playstore
GROUP BY App
HAVING AvgRatingBefore IS NOT NULL AND AvgRatingAfter IS NOT NULL;



/* 23. Identify seasonal trends: Find out if any app categories have significant fluctuations in ratings, installs, or reviews during 
certain months of the year. */

SELECT EXTRACT(MONTH FROM Last_Updated) AS Month, Category, AVG(Installs) AS AvgInstalls
FROM playstore
GROUP BY Month, Category
ORDER BY Month, AvgInstalls DESC;

/* 24. Optimize app recommendation system: Use SQL to identify which apps should be featured in a recommendation system by 
calculating a weighted score that considers both ratings and installs across similar genres. */

SELECT App, 
       (Rating * 0.7 + Installs * 0.3) AS RecommendationScore
FROM playstore
ORDER BY RecommendationScore DESC;
