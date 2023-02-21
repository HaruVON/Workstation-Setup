#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

home_option_string="@home_icon"
away_option_string="@away_icon"
work_option_string="@work_icon"
lab_option_string="@atr_icon"
ping_timeout_string="@ping_timeout"
route_to_ping_string="@route_to_ping"

work_icon="M"
away_icon="A"
atr_icon="L"
home_icon="H"
ping_timeout_default="3"
route_to_ping_default="www.google.com"


source $CURRENT_DIR/shared.sh

is_osx() {
	[ $(uname) == "Darwin" ]
}

is_cygwin() {
	[[ $(uname) =~ CYGWIN ]]
}



home_icon_default() {
	if is_osx; then
		echo "$home_icon_osx"
	else
		echo "$home_icon"
	fi
}

lab_icon_default() {
	echo "$atr_icon"
}

work_icon_default() {
	echo "$work_icon"
}



away_icon_default() {
	if is_osx; then
		echo "$away_icon_osx"
	elif is_cygwin; then
		echo "$away_icon_cygwin"
	else
		echo "$away_icon"
	fi
}

online_status() {
	if is_osx; then
		local timeout_flag="-t"
	else
		local timeout_flag="-w"
	fi
	if is_cygwin; then
		local number_pings_flag="-n"
	else
		local number_pings_flag="-c"
	fi
	local ping_timeout="$(get_tmux_option "$ping_timeout_string" "$ping_timeout_default")"
	local ping_route="$(get_tmux_option "$route_to_ping_string" "$route_to_ping_default")"
	ping "$number_pings_flag" 1 "$timeout_flag" "$ping_timeout" "$ping_route" >/dev/null 2>&1
}

print_icon() {
	if $(online_status); then
		EXT=$(dig @resolver1.opendns.com -t A -4 myip.opendns.com +short)
		ASN_ME=$(whois -h whois.cymru.com " -v $EXT" | tail -n 1 | cut -f1 -d'|')
        MIP=`dig +short mcafee.com`
		ASN_M=$(whois -h whois.cymru.com " -v $MIP" | tail -n 1 | cut -f1 -d'|')
        LIP=`dig +short frontier.com`
		ASN_L=$(whois -h whois.cymru.com " -v $LIP" | tail -n 1 | cut -f1 -d'|')
        FIP=`dig +short fibersphere.net`
		ASN_F=$(whois -h whois.cymru.com " -v $FIP" | tail -n 1 | cut -f1 -d'|')

        if [ "$ASN_ME" == "$ASN_M" ]; then
            printf "$(get_tmux_option "$work_option_string" "$(work_icon_default)")"
		elif [ "$ASN_ME" == "$ASN_F" ]; then
			printf "$(get_tmux_option "$home_option_string" "$(home_icon_default)")"
		elif [ "$ASN_ME" == "$ASN_L" ]; then
			printf "$(get_tmux_option "$lab_option_string" "$(lab_icon_default)")"
		else
		    printf "$(get_tmux_option "$away_option_string" "$(away_icon_default)")"
        fi
    else
        printf "$(get_tmux_option "$away_option_string" "N")"
	fi
}

main() {
	print_icon
	sleep 30
}
main
