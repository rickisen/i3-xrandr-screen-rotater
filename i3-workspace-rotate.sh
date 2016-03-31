#!/bin/bash

direction="$1"

# find the active display (output)
for (( i = 0; i < 10; i++ )); do

	output=$( i3-msg -t get_workspaces | jq -c '.['"$i"'] | {output}' | sed -e 's?{"output":"??g' -e 's?"}??g' )
	status=$( i3-msg -t get_workspaces | jq -c '.['"$i"'] | {focused}' | sed -e 's?{"focused":??g' -e 's?}??g')

	if [[ $status == "true" ]] ; then
		break
	fi
done

# specific to my setup
if [[ "$output" == "DVI-I-1" ]]; then
	if [[ "$direction" == "normal" ]]; then
		options=" --mode 1920x1080 --rate 144 --right-of DVI-D-0 --output DVI-D-0 --auto "
	else
		options=" --mode 1920x1080 --rate 144 --right-of DVI-D-0 --output DVI-D-0 --auto "
	fi
elif [[ "$output" == "DP-0" ]]; then
	options=" --right-of DVI-I-1 --output DVI-I-1 --auto "
elif [[ "$output" == "DVI-D-0" ]]; then
	options=" --left-of DVI-I-1 --output DVI-I-1 --auto "
else
	options=" "
fi

# correct the height of middle display, Not optimal, should check width of left display
if [[ "$direction" == "normal" && "$output" == "DVI-I-1" ]]; then
	echo "xrandr --output "$output" --rotate normal --mode 1920x1080 --pos 1080x539 --rate 144" | sh -
else
	echo "xrandr --output "$output" --rotate "$direction" "$options"" | sh -
fi

~/.fehbg &
