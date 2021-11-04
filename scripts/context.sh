#!/usr/bin/env bash


local contexts=""
IFS=$'\n' contexts=($(kubectl config get-contexts -o name))

declare -a VAR
for i in "${!contexts[@]}"
do
 local sum=$(($i + 1))
 VAR+=("${contexts[i]}")
 VAR+=("$sum")
 VAR+=("run-shell -b 'kubectl config use-context ${contexts[i]} > /dev/null'")
done

$(tmux display-menu \
 -T "#[align=centre fg=green]Kubernetes context switcher" -x R -y P \
   "#[nodim]Current context: $(kubectl config current-context)" "" "" \
   "" \
   "${VAR[@]}"\
   "" \
   "Close menu" q "")
