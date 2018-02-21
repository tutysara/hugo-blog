---
author: tutysara
date: 2018-02-09
keywords:
- twitter
- python
- machine learning
tags:
- machine learning
- python
- twitter
title: Machine Learning Flashcards from Twitter -- Part 1 Data Collection and Preprocessing
topics:
- ML
type: post
---

I was searching the net for mlflashcards, I found this incredible machine learning flashcard [tweet series](https://twitter.com/search?q=machinelearningflashcards.com%20and%20chrisalbon%20&src=typd) from [Chris Albon](https://twitter.com/chrisalbon).
It looks pretty and covers a lot of ground, Got a thought -- why not download them for later use?
I thought it would be a fun exercise to start the weekend and jumped into action.

## Step 1 -- Collect/Scrape data from twitter
I evaluated using twitter api using [tweetpy](https://github.com/tweepy/tweepy), but it has its own limitation aka we can search only a week worth of data which is not good for our use case.
We shoud be able to get data spread across months since the tweets we are interested are spread across a wide time range.

So, the next step is to try scraping. We got [twitterscraper](https://github.com/taspinar/twitterscraper) to our rescue here. 
Scraping was an one step painless process with this tool.

Install it using
```bash
pip install twitterscraper
```

Scrape the data matching a query using

	twitterscraper "machinelearningflashcards.com  from:chrisalbon" -o mlflashcards_tweets_large.json

The data is scraped and stored in a json file. The next step is preprocessing.

## Step 2 -- Preprcessing
	
Here we want to preprocess the data to learn about it and to process further. We will convert the data from json and read it into a dataframe.

### 2.1 Read the data
```python
import codecs, json
with codecs.open('mlflashcards_tweets_large.json', 'r', 'utf-8') as f:
	tweets = json.load(f, encoding='utf-8')
```
Look at a sample data

	t = tweets[5]
	t

output

	{'fullname': 'Chris Albon',
	 'id': '960977759915851776',
	 'likes': '6',
	 'replies': '2',
	 'retweets': '1',
	 'text': 'Alpha In Ridge Regression https://machinelearningflashcards.com\xa0pic.twitter.com/DFdSKO7DiH',
	 'timestamp': '2018-02-06T20:45:26',
	 'url': '/chrisalbon/status/960977759915851776',
	 'user': 'chrisalbon'}

###	2.2 Write and test few utility methods to extract data
```python
## get full tweet url
def get_tweet_url(tweet):
	return 'https://twitter.com' + tweet['url']

#test
tweet_url = get_tweet_url(t)
print(tweet_url)

# output: https://twitter.com/chrisalbon/status/960977759915851776

## get tweet text (text without url)
def get_tweet_text(tweet):
    text = tweet['text']
    res = re.search('(.*) https.*', text)
    if res:
        text = res.group(1)
    else:
        text = None
    return text

#test
get_tweet_text(t)
# output: 'Alpha In Ridge Regression'
```
###	2.3 Convert to dataframe
```python
rows = []
for tweet in tweets[:]:
    row = {"id": tweet['id'],
            "likes": tweet['likes'],
            "replies": tweet['replies'],
            "retweets": tweet['retweets'],
            "timestamp": tweet['timestamp'],
            "url": get_tweet_url(tweet),
            "text": get_tweet_text(tweet)}
rows.append(row)
df = pd.DataFrame.from_dict(rows)
df
```
looks something like this

	 	id 	likes 	replies 	retweets 	text 	timestamp 	url
	0 	892802102702911488 	1 	0 	1 	None 	2017-08-02T17:39:43 	https://twitter.com/chrisalbon/status/89280210...
	1 	961698946698567680 	5 	0 	0 	Threshold Activation 	2018-02-08T20:31:11 	https://twitter.com/chrisalbon/status/96169894...
	2 	961666291189743616 	23 	0 	5 	Chi-Squared 	2018-02-08T18:21:25 	https://twitter.com/chrisalbon/status/96166629...

###	2.4 Extract image url from tweet url
```python
def get_img_url(tweet_url):
    page_data = requests.get(tweet_url).text
    res = re.search('data-image-url="(.*)"', page_data)
    if res:
        img_url = res.group(1)
    else:
        img_url = None
    return img_url

#test
get_img_url(tweet_url)
# output: 'https://pbs.twimg.com/media/DViGZR3VoAAAoNf.png'

df['img_url'] = [get_img_url(tweet_url)  for tweet_url in df.url]
df.tail()
```
looks something like this

	 	id 	likes 	replies 	retweets 	text 	timestamp 	url 	img_url
	236 	946078250698018816 	19 	1 	0 	Bayes Error 	2017-12-27T18:00:06 	https://twitter.com/chrisalbon/status/94607825... 	https://pbs.twimg.com/media/DSElJ54VQAEtuvF.png
	237 	945751084974333952 	47 	3 	13 	Occams Razor 	2017-12-26T20:20:04 	https://twitter.com/chrisalbon/status/94575108... 	https://pbs.twimg.com/media/DR_7mSwV4AAw6ZW.png
	238 	945717937234591744 	8 	0 	1 	K-Fold Cross-Validation 	2017-12-26T18:08:21 	https://twitter.com/chrisalbon/status/94571793... 	https://pbs.twimg.com/mediDR_dc5RVAAAMkcK.png

## Step 3 -- Write to csv
	Its time to save it to csv for further processing
```python
df.to_csv("chrisalbon_mlflashcards.csv")
```

By this time I got other ideas to test. Instead of just downloading the images, I wanted to anaylze the tweets to know more about it using the data we have. 

The result is we are going to split this post into two parts where the next post will contain details on the analyis and code to download images. It will be published when the analysis is complete, let me go work on it. See you till then.

***Update 02/21 -- source code for this reop can be found [here](https://github.com/tutysara/chrisablon-mlflashcards)




