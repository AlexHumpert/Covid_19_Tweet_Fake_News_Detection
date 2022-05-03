DROP DATABASE IF EXISTS tweets;
CREATE DATABASE tweets;
USE tweets;
DROP TABLE IF EXISTS Covid;
CREATE TABLE Covid (
  event_time VARCHAR(50),
  screen_name VARCHAR(50),
  Text VARCHAR(300),
  tweet_id VARCHAR(50),
  verified BOOL, 
  followers_count BIGINT, 
  friends_count BIGINT,
  listed_count BIGINT,
  favourites_count BIGINT,
  statuses_count BIGINT,
  location VARCHAR(200),
  prediction BOOL,
  PRIMARY KEY(event_time, tweet_id)
);


                      