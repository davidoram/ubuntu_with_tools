#!/bin/bash
#
# Retrieve CORS headers until we get a sucesfull response (empty)
#
# Usage is curl_cors.sh origin url retrycount wait
#
# eg:
#
#   curl_cors.sh http://svc_authentication:8080 http://edge_splitter:8080/1/Log 10 2
#
# Will retrieve the OPTIONS 10 times, with a pausesec of 2 sec in between each request until it gets an empty body response, or fails
#
# will exit 0 if k, non-zero on failure
#
origin=$1
url=$2
retrycount=$3
pausesec=$4

while [  $retrycount -gt 0 ]; do
  let retrycount=retrycount-1

  output=$(curl -X OPTIONS --connect-timeout 2  -H "Access-Control-Request-Method: GET" -H "Origin: $origin" "$url")

  if [ $? -ne 0 ]; then
    echo "Command failed with code: $?"
  elif [ "$output" != "" ]; then
    echo "Got error: ${output}"
  else
    echo "OK"
    exit 0
  fi
  sleep $pausesec
done
echo "FAILED: Exceeded retry count"
exit 1