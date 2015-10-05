map = null

Meteor.startup () ->
  mapCanvas = $("#map")
  mapOptions =
    center: new google.maps.LatLng(44.5403, -78.5463),
    zoom: 3,
    disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map(mapCanvas[0], mapOptions)
  mapCanvas.css("height" , $(window).height() + "px")
  google.maps.event.addDomListener window, "resize", () ->
    mapCanvas.css("height" , $(window).height() + "px")

Template.tweetsMap.helpers({

});

poo_image = 'images/poo.png';
markers = []

setTweetPanel = (tweet) ->
  tweet_panel = $('#tweet-panel')
  tweet_panel.empty()
  twttr.widgets.createTweet tweet.id_str, tweet_panel[0]

turnOffAnimations = () ->
  for marker in markers
    marker.setAnimation null

Tweets.find().observe
  added: (tweet) ->
    # Agregamos a mapa y hacemos movimiento
    latLong = new google.maps.LatLng tweet.coordinates[0], tweet.coordinates[1]
    marker = new google.maps.Marker
        position: latLong,
        map: map,
        title: tweet.text
        icon: poo_image

    markers.push(marker)
    turnOffAnimations()
    marker.setAnimation google.maps.Animation.BOUNCE
    marker.addListener 'click', () ->
      setTweetPanel tweet
    setTweetPanel tweet
    map.setCenter marker.getPosition()