## Big Red Button

Now your [Dream Cheeky 902 Big Red Button](http://www.amazon.com/dp/B004D18MCK/ref=wl_it_dp_o_pd_nS_ttl?_encoding=UTF8&colid=OVJFOUTFS7DF&coliid=I1WLSU3GTK1935) can send hipchat messages!

## TODO
Modify this code to send the following terminal command to lock computer:
```
/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
```

## Setup

First run `npm install`.

Copy the `config.json.sample` file to `config.json` and fill it out. If a message is blank, no message will be sent when that event happens.

Now run `coffee src/index.coffee` to get it running!

## On Startup (for mac)

Want it to run on startup? Edit the `com.bigred.button.plist` file to point to the correct paths, copy it using the command below, and restart your mac.

~~~
sudo cp ./com.bigred.button.plist /Library/LaunchDaemons/
~~~
