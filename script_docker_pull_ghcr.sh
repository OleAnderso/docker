#! /bin/bash
end=$((SECONDS+60))
count=0
while [ $SECONDS -lt $end ]; do
    docker pull ghcr.io/michaelknightdriver/docker-nginx-brotli:latest
    #docker image rm ghcr.io/michaelknightdriver/docker-nginx-brotli:latest
    ((count++))
    :
done

currenttime=$(date +%s)
curl  -X POST -H "Content-type: application/json" -d "{ \"series\" : [{\"metric\":\"docker.pull.ghcr\", \"points\":[[$currenttime, $count]], \"type\":\"count\", \"host\":\"test.example.com\", \"tags\":[\"environment:test\"]} ]  }" 'https://app.datadoghq.com/api/v1/series?api_key=45814898a6681cc7e7e10086d3cae350'

