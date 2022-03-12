#! /bin/bash
random_number=$(shuf -i 1-30 -n 1)
end=$((SECONDS+400+random_number))
echo "RunCount: $end"
count=0
while [ $SECONDS -lt $end ]; do
    echo "Count: $count"
    docker pull --quiet michaelknightdriver/docker-nginx-brotli 
    docker image rm michaelknightdriver/docker-nginx-brotli > /dev/null
    ((count++))
    #if (( count > 49 )); then
    #    curl  -X POST -H "Content-type: application/json" -d "{ \"series\" : [{\"metric\":\"docker.pull.dockerhub\", \"points\":[[$currenttime, $count]], \"type\":\"count\", \"host\":\"test.example.com\", \"tags\":[\"environment:test\"]} ]  }" 'https://app.datadoghq.com/api/v1/series?api_key=45814898a6681cc7e7e10086d3cae350'
    #    count=$((count-50))
    # fi
    :
done

currenttime=$(date +%s)
curl  -X POST -H "Content-type: application/json" -d "{ \"series\" : [{\"metric\":\"docker.pull.dockerhub\", \"points\":[[$currenttime, $count]], \"type\":\"count\", \"host\":\"test.example.com\", \"tags\":[\"environment:test\"]} ]  }" 'https://app.datadoghq.com/api/v1/series?api_key=45814898a6681cc7e7e10086d3cae350'
