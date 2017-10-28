#!/bin/bash

#curl "http://countdown.api.tfl.gov.uk/interfaces/ura/instant_V1?Stopid=18898&ReturnList=Stoppointname,LineName,DestinationName,EstimatedTime" 2> /dev/null | awk -F"," '{print $5}' | sed 's/\r//g' | sed 's/000]//g' | sort | xargs -I{} date -d @{}

f=MountViewRoadS; now=$(date +%s); curl -o $f "http://countdown.api.tfl.gov.uk/interfaces/ura/instant_V1?Stopid=18898&ReturnList=Stoppointname,LineName,DestinationName,EstimatedTime" 2> /dev/null; for t in $(cat $f | awk -F"," '{print $5}' | sed 's/\r//g' | sed 's/000]//g' | sort); do diff_s=$(echo $t-$now | bc); diff=$(echo $diff_s/60 | bc); arrival_time=$(date -d @$t); echo "$arrival_time | in $diff mins"; done

