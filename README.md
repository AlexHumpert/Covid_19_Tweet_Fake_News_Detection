# Covid_19_Tweets_Fake_News_Detection

## Code and Resources Used
**Python Version:** 3.7

**Packages:** pyspark (MLlib, Spark SQL), pandas, numpy, seaborn, wordcloud

## Executive Summary 

Term 2 group project for Modern Data Architectures for Big Data 2 class at IE university - part of the Masters in Business Analytics and Big Data program.

We live in a world where information is constantly consumed digitally. Taking the US as an example, based on a report by [Pew Research Center conducted in 2021](https://www.pewresearch.org/internet/2021/04/07/social-media-use-in-2021/), about half the US adult population gets news on social media. Regarding Twitter specifically, 55% of Twitter users regularly get news from the platform. 

The propagation of fake news across social media platforms has become a major concern to governments and health organizations across the world. This has become obviously problematic since the very start of the Covid-19 pandemic, with misinformation being spreading about the seriousness of the disease, the efficacy of mask wearing and innacurate information ranging from treatments to cures to vaccinations. This is a reason why the World Health Organization (WHO) has termed this the "Infodemic". 

Being able to identify accurate vs inaccurate information is particularly critical for this subject. For this project, we trained a Random Forest classifier to classify tweets streamed in real-time by a Kafka Producer as being true or false. We then served these classified tweets, along with other relevant features, such as verified, followers_count, friends_count, etc. to a MariaDB database.  We then read tweets from MariaDB back into our Spark Session to conduct some exploratory data anlytics.

The following are some of the insights we found after streaming tweets containing "covid-19" (case-insensitive) for tweets in the English language for 8 minutes: 
* 4519 tweets ingested in real time - 99.5% (4499) classified as fake and 0.5% (17) classified as true.
* Average follower count for fae

<img width="621" alt="Screen Shot 2022-05-03 at 11 27 55 AM" src="https://user-images.githubusercontent.com/64847974/166431385-21ef4d87-5d5c-4a11-9fe9-a338fc8fa75d.png">




## Data Source

## Data Set Features

## NLP Pipeline

## Model 
