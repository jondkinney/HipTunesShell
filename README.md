# iTunes > HipChat

Allows you to trigger a shell script through the interface of your choosing (Alfred, Spark, Automator, etc) to post your currently playing iTunes track/artist/album to a specified HipChat room.

The script uses Curl to hit the HipChat API and URL Encodes the iTunes info with perl before embedding it in the JSON data string.