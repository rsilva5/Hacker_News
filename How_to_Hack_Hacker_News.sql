 -- Start by getting a feel for the hacker_news table
 SELECT title, score
 FROM hacker_news
 ORDER BY score DESC
 LIMIT 5;
 -- Top 5 stories with the highest scores are Penny Arcade – Surface Pro 3 update, Hacking The Status Game, Postgres CLI with autocompletion and syntax highlighting, Stephen Fry hits out at ‘infantile’ culture of trigger words and safe spaces, Reversal: Australian Govt picks ODF doc standard over Microsoft 

 SELECT * 
 FROM hacker_news
 ORDER BY score;

-- First, find the total score of all the stories.
 SELECT SUM(score)
 FROM hacker_news;
-- The total score of all the stories is 6366

-- Find the individual users who have gotten combined scores of more than 200, and their combined scores.
 SELECT user, SUM(score)
 FROM hacker_news
 GROUP BY user
 HAVING SUM(score) > 200
 ORDER BY 2 DESC;
-- There are five users who have gotten a combined score of more than 200

-- Then, we want to add these users’ scores together and divide by the total to get the percentage.
 SELECT (517 + 309 + 304 + 282) / 6366.0;
-- These users allot for 22% 

-- How many times has each offending user posted this link?
SELECT user,
   COUNT(*)
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ%'
GROUP BY user
ORDER BY COUNT(*) DESC;
-- There are two offenders. One offender posted it twice and the other offender posted it once. 

SELECT user,
   COUNT(*)
FROM hacker_news
WHERE url LIKE '%watch?v=dQw4w9WgXcQ%'
GROUP BY 1
ORDER BY 2 DESC;

-- Which of these sites feed Hacker News the most:
SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  END AS 'Source'
FROM hacker_news;

SELECT CASE
  WHEN url LIKE '%github.com%' THEN 'GitHub'
  WHEN url LIKE '%medium.com%' THEN 'Medium'
  WHEN url LIKE '%nytimes.com%' THEN 'New York Times'
  ELSE 'Other'
  END AS 'Source',
  COUNT (*)
FROM hacker_news
GROUP BY 1;
-- Another site outside of Github, Medium, and NYT feeds Hacker News the most with a total of 3952 clicks

-- What’s the best time of the day to post a story on Hacker News?
SELECT timestamp 
FROM hacker_news
LIMIT 10;

SELECT timestamp, 
  strftime('%H', timestamp)
FROM hacker_news
GROUP BY 1
LIMIT 20;

-- Write a query that returns three columns: the hours of the timestamp, the avg score for ach hour, and the count for each hour 
SELECT strftime('%H', timestamp), 
  AVG(score), 
  COUNT(*)
FROM hacker_news
GROUP BY 1
ORDER BY 1;

-- What are the best hours to post a story on Hacker News?
SELECT strftime('%H', timestamp) AS 'Hour', 
  ROUND(AVG(score),1) AS 'Average Score', 
  COUNT(*) AS 'Number of Stories'
FROM hacker_news
WHERE timestamp IS NOT NULL
GROUP BY 1
ORDER BY 1;
-- The best hours to post a story on Hacker News is at 6pm, 7am, 7pm, and 8pm
