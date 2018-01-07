---
author: tutysara
date: 2018-01-07
keywords:
- sklearn
- skipgrams
tags:
- sklearn
- python
title: Use Skipgrams with sklearn CountVectorizer and TfidfVectorizer
topics:
- ML
type: post
---

We don't have an implementation for skipgrams in sklearn. This post covers how to use the skipgram function in `nltk` with sklearn's CountVectorizer and TfidfVectorizer

We are going to create a skipgram tokenizer that can be passed to the `tokenizer` parameter of the vectorizer.

Create a basic tokenizer that can split the original strings to tokesn.
Tokenizer can be just `.split()` or a function to filter non-alpahbets etc. We can use tokenizer as below

	def basic_tokenize(tweet):
	    tweet = " ".join(re.split("[^a-zA-Z#]*", tweet)).strip()
	    return tweet.split()

This data will be fed to the skipgram tokenizer to get skipgrams

This is the function that creates skipgram given a string, k and n

    def skipgram_tokenize(tweet, n=None, k=None, include_all=True):
	    from nltk.util import skipgrams
	    tokens = [w for w in basic_tokenize(tweet)]
	    if include_all:
	        result = []
	        for i in range(k+1):
	            skg = [w for w in skipgrams(tokens, n, i)]
	            result = result+skg
	    else:
	        result = [w for w in skipgrams(tokens, n, k)]
	    result=set(result)
	    #print(result)
	    return result

	def make_skip_tokenize(n, k, include_all=True):
	    return lambda tweet: skipgram_tokenize(tweet, n=n, k=k, include_all=include_all)


It can be used with the vectorizer by setting the `tokenizer` param as shown below

	## using 3-skip bigrams
	vectorizer_3skipbigram = TfidfVectorizer(stop_words=other_exclusions,
                                       tokenizer=make_skip_tokenize(n=2, k=3))
  
  Happy hacking skipgrams with sklearn.
  Leave a comment if there are questions
