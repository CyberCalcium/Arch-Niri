#!/bin/bash

API_KEY=""
CITY=""
UNITS="metric"
LANG="es"

DATA=$(curl -s "https://api.openweathermap.org/data/2.5/weather?q=${CITY}&appid=${API_KEY}&units=${UNITS}&lang=${LANG}")

TEMP=$(echo "$DATA" | jq -r '.main.temp | round')
DESC=$(echo "$DATA" | jq -r '.weather[0].description')
ICON=$(echo "$DATA" | jq -r '.weather[0].icon')

case "$ICON" in
  01d) ICON="";;
  01n) ICON="";;
  02d|02n) ICON="";;
  03d|03n|04d|04n) ICON="";;
  09d|09n|10d|10n) ICON="";;
  11d|11n) ICON="";;
  13d|13n) ICON="";;
  50d|50n) ICON="";;
  *) ICON="";;
esac

echo "${ICON}  ${TEMP}°C"
