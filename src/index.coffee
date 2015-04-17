BigRedButton = require("BigRedButtonNodeHID")
request = require("request")
fs = require('fs')
shell = require('shelljs')

class Button

  raw: null

  constructor: (button) ->
    @raw = button
    for type in ['buttonPressed', 'buttonReleased', 'lidClosed', 'lidRaised']
      button.on(type, @action.bind(@, type))

  data: ->
    JSON.parse(fs.readFileSync("#{__dirname}/../config.json"))

  action: (type) ->
    if type == 'buttonReleased'
      shell.exec('open -a /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app', {silent:true})

  dead: ->
    !@raw.interval

class ButtonManager

  buttons: {}

  find_buttons: =>
    BigRedButton.resetDevices()
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
