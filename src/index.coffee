BigRedButton = require("big-red-button-node-hid-2")
request = require("request")

###
# AUTH_TOKEN=foo ROOM=111 MESSAGE="@BlaineSch rules" coffee index.coffee
###
options =
  uri: "https://api.hipchat.com/v2/room/#{process.env.ROOM}/notification?auth_token=#{process.env.AUTH_TOKEN}"
  method: "POST"
  json:
    message_format: "text"
    message: process.env.MESSAGE
    notify: true

bigRedButton = new BigRedButton.BigRedButton(0)

# buttonPressed, lidRaised, lidClosed
bigRedButton.on "buttonReleased", ->
  request options, (error, response, body) ->
    if error or body
      console.log 'Something went wrong'
    else
      console.log 'Deployed it'
