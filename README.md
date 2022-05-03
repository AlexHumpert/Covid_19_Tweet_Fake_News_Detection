# Covid_19_Tweets_Fake_News_Detection

## Code and Resources Used
**Python Version:** 3.7

**Packages:** pyspark (MLlib, Spark SQL), pandas, numpy, seaborn, wordcloud

## Executive Summary 

Term 2 group project for Modern Data Architectures for Big Data 2 class at IE university - part of the Masters in Business Analytics and Big Data program.

We live in a world where information is constantly consumed digitally. Taking the US as an example, based on a report by [Pew Research Center conducted in 2021](https://www.pewresearch.org/internet/2021/04/07/social-media-use-in-2021/), about half the US adult population gets news on social media. Regarding Twitter specifically, 55% of Twitter users regularly get news from the platform. 

The propagation of fake news across social media platforms has become a major concern to governments and health organizations across the world. This has become obviously problematic since the very start of the Covid-19 pandemic, with misinformation being spread about the seriousness of the disease, the efficacy of mask wearing and innacurate information ranging from treatments to cures to vaccinations. This is a reason why the World Health Organization (WHO) has termed this the "Infodemic". Being able to identify accurate and inaccurate information is particularly critical for this subject - identifying whether or not a tweet on covid-19 is true or fake news.

## Data Architecture

For this project, a Lambda Architecture suited our needs best. Lambda architectures contain a batch and speed layer. For the batch layer we used HDFS to store our Covid-19 training set, from which we trained our classifier. The (real-time) processing layer was used to classify tweets on covid-19 in real time. A Spark session was used as the processing engine to build our classifier and classify Covid-19 tweets read from a Kafka producer. We then served these classified tweets, along with other relevant features, such as verified, followers_count, friends_count, etc. to a MariaDB database.  We then read the stored tweets from MariaDB back into our Spark Session to conduct exploratory data anlytics.



<p align="center">
  <img 
     width="500" 
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

The predictor feature was text data. Consequently, the text had to be passed through a NLP pipeline in order to transform it to be suitable for ingestion by a Random Forest classifier. The pipeline stages were a (1) Tokenizer, (2) Count Vectorizer and (3) Term Frequency-Inverse Document Frequency (TF-IDF). TF-IDF is a statistical measure that evaluates how relevant a word is to a document in a collection of documents - each word is given a numerical score. 

Following the text transformation, the baseline accuracy for the Random Forest Classifer on the test set was 68%. Hyperparameter tuning was applied to maxDepth and numTrees using a grid search with 3 cross-validation folds. This resulted in an improved accuracy of 70%.

## Data Serving - Creating database in MongoDB and writing data to database table from Spark Session

To read the classified tweets from the SparkSession into a MariaDB database, we first had to create the database and define the table schema within the database. The database creation and table schema were defined in the tweets-db.sql file. Once defined, we then had to start the MariaDB server and initialize the table schema. Now that the table exists (with zero records), we could officially write data to the database as tweets came into the Spark Session batch by batch.

(The database and table schema are in the file "tweets-db.sql")

## Insights 

Although we could write sql queries directly in the MariaDB, we instead read the stored tweets from MariaDB back into the Spark Session as a dataframe and used seaborn to make vizualizations of the data. The following are some of the insights we found after streaming english language tweets containing "covid-19" (case-insensitive) for a window of 8 minutes: 
* 4519 tweets ingested in real time - 99.5% (4499) classified as fake and 0.5% (17) classified as true.
* On average accounts linked to fake-news tweets had vastly more followers and friends. This suggests 

<p align="center">
  <img 
     width="400" 
     alt="Screen Shot 2022-05-03 at 11 27 55 AM" 
     src="https://user-images.githubusercontent.com/64847974/166431385-21ef4d87-5d5c-4a11-9fe9-a338fc8fa75d.png"
  >
</p>

* On average words used in tweets classified as Fake News were more "informal" and "less official" sounding than those used in tweets classified as True.

<p align="center">
  <img 
       width="400" 
       alt="Screen Shot 2022-05-03 at 5 37 44 PM" 
       src="https://user-images.githubusercontent.com/64847974/166486339-181c142f-d3ff-4b26-a41c-e31effddd047.png"
   >
</p>

<p align="center">
  <img 
       width="400" 
       alt="Screen Shot 2022-05-03 at 5 38 28 PM" 
       src="https://user-images.githubusercontent.com/64847974/166486467-7b9d9614-db98-4d4a-ae65-ba30fac7b90d.png"
  >
</p>

