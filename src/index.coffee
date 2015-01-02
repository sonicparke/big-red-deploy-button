BigRedButton = require("BigRedButtonNodeHID")
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

class Button

  raw: null

  constructor: (button) ->
    @raw = button
    for type in ['buttonPressed', 'buttonReleased', 'lidClosed', 'lidRaised']
      button.on(type, @action.bind(@, type))

  data: ->
    JSON.parse(fs.readFileSync("#{__dirname}/../config.json"))

  action: (type) ->
    if message = @data().messages[type]
      HipChat.send message, (status) ->
        console.log {status}

  dead: ->
    !@raw.interval

class ButtonManager

  buttons: {}

  find_buttons: =>
    for i in [0...BigRedButton.deviceCount()]
      try
        button = new BigRedButton.BigRedButton(i)
      catch e
        continue
      unless @buttons[button.button.path]
        console.log 'new button', button.button.path
        @buttons[button.button.path] = new Button(button)

  find_zombie_buttons: =>
    for i,button of @buttons
      console.log 'deleted button' if button.dead()
      delete @buttons[i] if button.dead()


manager = new ButtonManager
setInterval(manager.find_zombie_buttons, 500)
setInterval(manager.find_buttons, 500)
