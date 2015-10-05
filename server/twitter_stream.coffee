getLocationTweet = (tweet) ->
  if tweet.coordinates != null
   return tweet.coordinates
  if tweet.geo != null
   return tweet.geo
  if tweet.place != null and tweet.place.bounding_box != null and tweet.place.bounding_box.coordinates != null
    latitude = 0
    longitude = 0
    for lat_long in tweet.place.bounding_box.coordinates[0]
      latitude  += lat_long[0]
      longitude += lat_long[1]
    cantidad = tweet.place.bounding_box.coordinates[0].length
    return [ longitude / cantidad, latitude / cantidad]
  return null

if Meteor.isServer
  Meteor.startup () ->
    Fiber = Npm.require('fibers');
    # Connect to the twitter api
    twit = new TwitMaker Meteor.settings.twitterConfig

    # Callback for data
    stream = twit.stream 'statuses/filter', { track: 'shit', filter_level: 'low' }
    stream.on 'tweet', (tweet) ->
      Fiber( () ->
        if getLocationTweet(tweet) != null
          tweet.coordinates = getLocationTweet(tweet)
          _.extend(tweet,
          {
            created_on: new Date().getTime()
          })
          Tweets.insert(tweet)
          console.log(Tweets.find().count())
      ).run()

    stream.on 'error', (error) ->
      console.log(error)

    # We delete old tweets
    Meteor.setInterval( () ->
      now = (new Date()).getTime()
      tweets = Tweets.remove( { created_on: { "$lte": now - 1000 * 60 * 15} } )
    , 1000 * 60 * 7)