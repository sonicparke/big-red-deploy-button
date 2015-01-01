BigRedButton = require("big-red-button-node-hid-2")
request = require("request")
data = JSON.parse(require('fs').readFileSync("#{__dirname}/../config.json"))

class HipChat

  @send: (message, callback) ->
    console.log {message}
    request HipChat.options(message), (error, response, body) ->
      callback(not error and not body)

  @options: (message) ->
    uri: "https://api.hipchat.com/v2/room/#{data.room}/notification?auth_token=#{data.auth_token}"
    method: "POST"
    json:
      message_format: "text"
      message: message
      notify: true

bigRedButton = new BigRedButton.BigRedButton(0)

for type in ['buttonPressed', 'buttonReleased', 'lidClosed', 'lidRaised']
  bigRedButton.on type, ( (data, type)->
    if data.messages[type]
      HipChat.send data.messages[type], (status) ->
        console.log {status}
  ).bind(@, data, type)
