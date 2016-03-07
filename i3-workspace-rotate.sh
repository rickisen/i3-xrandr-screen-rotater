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


echo "rotating output is $output direction $direction"


