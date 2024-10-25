# MobileAppMarketAnalysis
# **Mobile App Market Analysis Using SQL**

## **Project Overview**

This project focuses on analyzing a dataset of mobile apps from the Google Play Store using SQL. The analysis helps in providing insights that can guide business decisions such as launching new apps, identifying high-revenue categories, understanding the distribution of gaming apps, and recommending app types based on user ratings. Additionally, measures are taken to secure app data from hacking and resolve issues related to multiple genres in the dataset.

### **Dataset:**
The dataset contains the following columns:
- **App**: Name of the app
- **Category**: Category of the app (e.g., Entertainment, Tools, etc.)
- **Rating**: Average user rating of the app
- **Reviews**: Number of user reviews
- **Installs**: Number of times the app was installed
- **Type**: Whether the app is free or paid
- **Price**: Price of the app (if paid)
- **Content Rating**: Target audience of the app (e.g., Everyone, Teen)
- **Genres**: App genres (could be multiple for a single app)
- **Last Updated**: Date when the app was last updated
- **Current Ver**: Current version of the app
- **Android Ver**: Minimum Android version required to run the app

**Data Cleaning Using Python**
- Before performing SQL analysis, the dataset was cleaned using Python to handle missing values, outliers, and inconsistencies.

## **Key Tasks and SQL Queries**

Here are 20 additional SQL-based questions that could impress recruiters, highlighting various skills related to database management, optimization, and analysis:

1. **Identify the fastest-growing app category**: Write a query to find the top 3 app categories with the highest growth rate in the number of installs over time.

2. **Monthly revenue trends**: Analyze and return the total revenue per month for paid apps, segmented by app category.

3. **Identify top apps by region**: Assuming you have a `location` column, create a query that identifies the top-rated app in each country/region.

4. **App performance over time**: Write a query to calculate the average rating of apps in each category for every quarter of the year.

5. You're working as a market analyst for a mobile app development company. Your task is to identify the most promising categories (TOP 5)
 for launching new free apps based on their average ratings.

6. **App popularity ranking**: Create a query that ranks apps within each category based on the combination of ratings and number of reviews.

7. As a business strategist for a mobile app company, your objective is to pinpoint the three categories that generate the 
most revenue from paid apps. This calculation is based on the product of the app price and its number of installations.
8. **Free to paid conversion rate**: Calculate the conversion rate of free apps to paid apps over time, considering only apps that moved from the free model to a paid model.

9. **Identify user engagement patterns**: Find the apps with the highest review-to-install ratio, which might indicate strong user engagement.

10. **Detect potential fraud**: Identify apps with a disproportionately high number of installs compared to their average rating.

11. **Genre trend over time**: Track the number of new apps added to each genre over the past year to identify emerging trends.

12. **Identify apps with extreme price variations**: Write a query that highlights the top 10 apps with the largest price swings within a year.

13. **Monitor review spikes**: Identify apps with sudden surges in the number of reviews within a short time frame to detect potential marketing efforts or review manipulation.

14. **Segment apps by audience type**: Write a query that groups apps by their content rating (e.g., Everyone, Teen, Mature) and calculates the average revenue per app in each group.

15. As a data analyst for a gaming company, you're tasked with calculating the percentage of games within each category. 
This information will help the company understand the distribution of gaming apps across different categories.

16. **Analyze app success post-update**: Compare the average rating before and after the last update for all apps to assess if updates improve user satisfaction.

17. **Identify seasonal trends**: Find out if any app categories have significant fluctuations in ratings, installs, or reviews during certain months of the year.

18. As a data analyst at a mobile app-focused market research firm you’ll recommend whether the company should develop paid or 
free apps for each category based on the ratings of that category.

19. Your IT team have neutralized the threat; however, hackers have made some changes in the prices, but because of your measure 
you have noted the changes, now you want correct data to be inserted into the database again.
20. **Optimize app recommendation system**: Use SQL to identify which apps should be featured in a recommendation system by calculating a weighted score that considers both ratings and installs across similar genres.

These questions showcase a broad range of SQL skills that demonstrate not just technical ability, but also insights into business operations and app performance analysis.

## **Advanced Questions and Queries**
The project also includes advanced queries, such as identifying the fastest-growing categories, revenue trends, engagement patterns, and potential app fraud. These queries help in understanding app market dynamics and guiding future business strategies.

## **Project Screenshots**
#### Here are some visuals of the queries and results displayed in SQL:
![Q1](https://github.com/user-attachments/assets/ecf718fb-1a4d-4e0f-bb41-04db990c28da)


*Example: Dynamic tool to identify underperforming apps based on real-time category analysis
![Q2](https://github.com/user-attachments/assets/a71926ee-1e99-4a2b-bb54-713dc965487c)


*Example: Correlation analysis between app ratings and reviews.*
![Q3](https://github.com/user-attachments/assets/37489c4f-f438-4554-a8a3-f2e5bf3e8848)


## **Technologies Used**
- **SQL**: The core technology for running queries and performing analysis.
- **MySQL**: The database management system used for this analysis.
- **Power BI**: For additional visualization and reporting.

## **Conclusion**
This project demonstrates the integration of Python for data cleaning and SQL for performing advanced analysis on mobile app data. By leveraging SQL's capabilities, we can not only gain insights into app performance but also ensure data integrity during unforeseen circumstances like hacking. Additionally, the advanced queries provide a competitive edge in understanding user behavior and making data-driven business decisions.
