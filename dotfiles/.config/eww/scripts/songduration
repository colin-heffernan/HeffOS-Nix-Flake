#? /bin/bash

stdout=$(mpc | sed -n 2p)
times=($stdout)
IFS="/"
read -rasplitIFS<<< "${times[2]}"
time_elapsed=${splitIFS[0]}
time_total=${splitIFS[1]}
IFS=":"
read -rasplitIFS<<< "$time_elapsed"
time_elapsed_minutes=${splitIFS[0]}
time_elapsed_seconds=${splitIFS[1]}
read -rasplitIFS<<< "$time_total"
time_total_minutes=${splitIFS[0]}
time_total_seconds=${splitIFS[1]}
time_elapsed_in_seconds=$(($(($time_elapsed_minutes*60))+$time_elapsed_seconds))
time_total_in_seconds=$(($(($time_total_minutes*60))+$time_total_seconds))

echo $(($(($time_elapsed_in_seconds*10000))/$time_total_in_seconds)) | sed -e 's/..$/.&/;t' -e 's/.$/.0&/'
