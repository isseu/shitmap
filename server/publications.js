Meteor.publish('tweets', function() {
  return Tweets.find( { created_on: { "$gte": (new Date().getTime()) } } );
})