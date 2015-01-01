BigRedButton = require("big-red-button-node-hid-2")
request = require("request")
fs = require('fs')

class HipChat

  @data: ->
    JSON.parse(fs.readFileSync("#{__dirname}/../config.json"))

  @send: (message, callback) ->
    console.log {message}
    request HipChat.options(message), (error, response, body) ->
      callback(not error and not body)

  @options: (message) ->
    uri: "https://api.hipchat.com/v2/room/#{@data().room}/notification?auth_token=#{@data().auth_token}"
    method: "POST"
    json:
      message_format: "text"
      message: message
      notify: true

bigRedButton = new BigRedButton.BigRedButton(0)

for type in ['buttonPressed', 'buttonReleased', 'lidClosed', 'lidRaised']
  bigRedButton.on type, ( (type)->
    data = JSON.parse(fs.readFileSync("#{__dirname}/../config.json"))
    if message = data.messages[type]
      HipChat.send message, (status) ->
        console.log {status}
  ).bind(@, type)
