ShitMap
=======

Experiment to find where people say shit in the world using twitter, meteorjs and nodejs.

Based on [fbomb.co](http://www.fbomb.co/)

### [DEMO](http://shitmap.meteor.com)

### How to run

```
$ meteor run --settings settings.json
```

Where settings.json have the following structure

```json
{
	"twitterConfig": {
		"consumer_key": <TWITTER_CONSUMER_KEY>,
		"consumer_secret": <TWITTER_CONSUMER_SECRET>,
		"access_token": <TWITTER_ACCESS_TOKEN>,
		"access_token_secret": <TWITTER_ACCESS_TOKEN_SECRET>
	}
}
```
