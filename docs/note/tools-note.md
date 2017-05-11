##Restart sogou-qimpanel
~~~script
#!/bin/sh
pidof fcitx | xargs kill
pidof sogou-qimpanel | xargs kill -9
nohup fcitx  1>/dev/null 2>/dev/null &
nohup sogou-qimpanel  1>/dev/null 2>/dev/null &
~~~