#! /bin/bash
random_number=$(shuf -i 1-30 -n 1)
end=$((SECONDS+180+random_number))
echo "RunCount: $end"
count=0
while [ $SECONDS -lt $end ]; do
    docker pull "ghcr.io/$1"
    #docker image rm "ghcr.io/$1"
    ((count++))
    :
done

currenttime=$(date +%s)
curl  -X POST -H "Content-type: application/json" -d "{ \"series\" : [{\"metric\":\"docker.pull.ghcr\", \"points\":[[$currenttime, $count]], \"type\":\"count\", \"host\":\"test.example.com\", \"tags\":[\"environment:test\"]} ]  }" "https://app.datadoghq.com/api/v1/series?api_key=$2"

