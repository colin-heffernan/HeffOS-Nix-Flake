#? /bin/bash

rawWeather=$(wego -frontend json | grep Desc | sed -n 1p | sed "s/\t//; s/\"Desc\": \"//; s/\",//g")
IFS=" "
read -rasplitIFS<<< "$rawWeather"
weather=""
index=0
for i in "${splitIFS[@]}"
do
	temp=$(echo $i | sed "s/\t//g")
	weather+=${temp^}
	if [ ${#splitIFS[@]} != ${index+1} ]; then
		weather+=" "
	fi
	index+=1
done
echo $weather
