#!/bin/bash
USER="iTunes | Jon"
ROOM="YOUR_ROOM_ID_HERE"
COLOR="purple"
TOKEN="YOUR_TOKEN_HERE"

if ps x | grep iTunes | grep -q -v grep;   then
  OUT=`osascript -e 'tell application "iTunes"
set trackname to name of current track
set artistname to artist of current track
set albumname to album of current track

if artistname is null then
set artistshow to ""
else if artistname is "" then
set artistshow to ""
else
set artistshow to " | " & artistname & ""
end if

if albumname is null then
set albumshow to ""
else if albumname is "" then
set albumshow to ""
else
set albumshow to " - " & albumname & ""
end if

set output to "" & trackname & artistshow & albumshow
  end tell'`
fi

# TODO remove duplication by looping through the vars
ENCODED_MESSAGE=$(echo $OUT | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg');
ENCODED_USER=$(echo $USER | perl -pe's/([^-_.~A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg');
# echo $ENCODED

# RAW Curl example
# curl -sS -d "notify=1&color=purple&room_id=<ROOM_ID>&from=iTunes&message=hi" http://api.hipchat.com/v1/rooms/message?format=json&auth_token=<API_TOKEN>

CURLARGS="-sS"
JSON="-d notify=1&color=$COLOR&room_id=$ROOM&from=$ENCODED_USER&message=$ENCODED_MESSAGE"
APIURL="http://api.hipchat.com/v1/rooms/message?format=json&auth_token=$TOKEN"

curl $CURLARGS $JSON $APIURL