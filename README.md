# Covid_19_Tweets_Fake_News_Detection

## Code and Resources Used
**Python Version:** 3.7

**Packages:** pyspark (MLlib, Spark SQL), pandas, numpy, seaborn, wordcloud

## Executive Summary 

Term 2 group project for Modern Data Architectures for Big Data 2 class at IE university - part of the Masters in Business Analytics and Big Data program.

We live in a world where information is constantly consumed digitally. Taking the US as an example, based on a report by [Pew Research Center conducted in 2021](https://www.pewresearch.org/internet/2021/04/07/social-media-use-in-2021/), about half the US adult population gets news on social media. Regarding Twitter specifically, 55% of Twitter users regularly get news from the platform. 

The propagation of fake news across social media platforms has become a major concern to governments and health organizations across the world. This has become obviously problematic since the very start of the Covid-19 pandemic, with misinformation being spreading about the seriousness of the disease, the efficacy of mask wearing and innacurate information ranging from treatments to cures to vaccinations. This is a reason why the World Health Organization (WHO) has termed this the "Infodemic". Being able to identify accurate vs inaccurate information is particularly critical for this subject. 

## Data Architecture

For this project, a Lambda Architecture suited our needs best, containing a batch layer where we stored our pre-labled Covid-19 training set and a speed (real-time) processing layer to classify tweets on covid-19 in real time. A Spark session was used as the processing engine to build our classifier and classify Covid-19 tweets read from Kafka producer. We then served these classified tweets, along with other relevant features, such as verified, followers_count, friends_count, etc. to a MariaDB database.  We then read the stored tweets from MariaDB back into our Spark Session to conduct exploratory data anlytics.

<p align="center">
  <img 
     width="622" 
     alt="Screen Shot 2022-05-03 at 11 29 59 AM" 
     src="https://user-images.githubusercontent.com/64847974/166431649-86409eb1-4c68-4e7d-87a1-803c20a874e6.png"
   >
</p>

## Data Source 

#### Training set
The pre-labeled covid-19 training set had already been curated and posted for public use by Github User [Songli Wang](https://github.com/MickeysClubhouse) as separate csv files. After combining each csv file we had 8682 records. Each record was a tweet or a news article classified as True (T) or False (F). The predictor was a single column containing the entire text of the tweet or news article. The csv file was stored in HDFS and read into a SparkSession to train the machine learning model.

(The combined csv files are available in this repository - see "combined_csv.csv").

#### Real-time Tweet Streaming

To ingest twitter data we first create a Kafka producer in Python. This uses a library that queries Twitter's API to create very specialized queries, such as reading only tweets in the English language that contain the word "covid-19" case-insesitive. The API will direcly call twitter and stream data into our kafka model. 

From Spark Session we listen to part of the network that is receiving these tweets and save them into a dataframe one batch at a time. Our pre-trained classifier then classifies each batch of tweets as they are read into the Spark Session.

(The twitter producer configured to read only tweets in English containing "covid_19" case-insneitive is in the "twitter-producer.py" file).

## Data Processing - NLP pipeline and Random Forest Classifier



## Insights 


The following are some of the insights we found after streaming tweets containing "covid-19" (case-insensitive) for tweets in the English language for 8 minutes: 
* 4519 tweets ingested in real time - 99.5% (4499) classified as fake and 0.5% (17) classified as true.
* On average accounts linked to fake-news tweets had vastly more followers and friends. This suggests 

<p align="center">
  <img 
     width="621" 
     alt="Screen Shot 2022-05-03 at 11 27 55 AM" 
     src="https://user-images.githubusercontent.com/64847974/166431385-21ef4d87-5d5c-4a11-9fe9-a338fc8fa75d.png"
  >
</p>


