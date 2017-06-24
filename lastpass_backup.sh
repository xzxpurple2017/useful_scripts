#!/bin/bash

PROGNAME=$(basename "$0")
declare -A lpass_users=(["<LASTPASS_USERNAME>"]="<LASTPASS_PASSWORD>")
key_id="<GPG_USERNAME>"
export LPASS_DISABLE_PINENTRY=1

backup_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
curr_date=$(date +%Y-%m-%d)

for key in "${!lpass_users[@]}" ; do
	[[ -d ${backup_dir}/${key} ]] || mkdir ${backup_dir}/${key}
	echo ${lpass_users[$key]} | lpass login --trust ${key}
	echo ${lpass_users[$key]} | lpass export | gpg -e -r ${key_id} | ( umask 077 && cat > ${backup_dir}/${key}/lpass_bkp_${key}_${curr_date}.csv.gpg; )
	lpass logout <<- EOF
	Y
	EOF
done

