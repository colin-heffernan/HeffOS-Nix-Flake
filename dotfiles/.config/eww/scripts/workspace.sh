#? /bin/bash

# Define icons for workspaces 1-9
ic=("" "" "" "" "" "" "" "" "")

# Initial check for workspaces
for num in $(hyprctl workspaces | grep ID | sed 's/()/(1)/g' | awk 'NR>1{print $1}' RS='(' FS=')'); do
	export o"$num"="$num"
done

# Initial check for focused workspace
for num in $(hyprctl monitors | grep active | sed 's/()/(1)/g' | awk 'NR>1{print $1}' RS='(' FS=')'); do 
	export f"$num"="$num"
	export fnum=f"$num"
done

workspaces() {
	if [[ ${1:0:9} == "workspace" ]]; then
		unset -v "$fnum"
		num=${1:11}
		export f"$num"="$num"
		export fnum=f"$num"
	elif [[ ${1:0:15} == "createworkspace" ]]; then
		num=${1:17}
		export o"$num"="$num"
		export f"$num"="$num"
	elif [[ ${1:0:16} == "destroyworkspace" ]]; then
		num=${1:18}
		unset -v o"$num" f"$num"
	fi

	if [[ $o1 == "1" ]]; then
		ic[1]="●"
	else
		ic[1]="○"
	fi

	if [[ $o2 == "2" ]]; then
		ic[2]="●"
	else
		ic[2]="○"
	fi

	if [[ $o3 == "3" ]]; then
		ic[3]="●"
	else
		ic[3]="○"
	fi

	if [[ $o4 == "4" ]]; then
		ic[4]="●"
	else
		ic[4]="○"
	fi

	if [[ $o5 == "5" ]]; then
		ic[5]="●"
	else
		ic[5]="○"
	fi
	
	if [[ $o6 == "6" ]]; then
		ic[6]="●"
	else
		ic[6]="○"
	fi
	
	if [[ $o7 == "7" ]]; then
		ic[7]="●"
	else
		ic[7]="○"
	fi
	
	if [[ $o8 == "8" ]]; then
		ic[8]="●"
	else
		ic[8]="○"
	fi
	
	if [[ $o9 == "9" ]]; then
		ic[9]="●"
	else
		ic[9]="○"
	fi

	echo "(box :orientation \"v\" :spacing 0 :space-evenly \"false\" \
			(label :class \"w$o1$f1\" :text \"${ic[1]}\") \
			(label :class \"w$o2$f2\" :text \"${ic[2]}\") \
			(label :class \"w$o3$f3\" :text \"${ic[3]}\") \
			(label :class \"w$o4$f4\" :text \"${ic[4]}\") \
			(label :class \"w$o5$f5\" :text \"${ic[5]}\") \
			(label :class \"w$o6$f6\" :text \"${ic[6]}\") \
			(label :class \"w$o7$f7\" :text \"${ic[7]}\") \
			(label :class \"w$o8$f8\" :text \"${ic[8]}\") \
			(label :class \"w$o9$f9\" :text \"${ic[9]}\") \
		)"
}

workspaces

socat -u UNIX-CONNECT:/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock - | while read -r event; do 
workspaces "$event"
done
