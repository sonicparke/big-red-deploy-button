## Big Red Button

Now your [Dream Cheeky 902 Big Red Button](http://www.amazon.com/dp/B004D18MCK/ref=wl_it_dp_o_pd_nS_ttl?_encoding=UTF8&colid=OVJFOUTFS7DF&coliid=I1WLSU3GTK1935) can send hipchat messages!

~~~
AUTH_TOKEN=foo ROOM=111 MESSAGE="@BlaineSch rules" coffee index.coffee
~~~

## On Startup

After Editing `./big-red-button-deploy` to have your correct paths, auth_token, room and message.

~~~
sudo cp ./com.bigred.button.plist /Library/LaunchDaemons/
~~~
