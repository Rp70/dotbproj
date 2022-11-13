#!/usr/bin/env bash
set -e

exit 0;

# This function borrowed from docker.sh
chain_exists() {
    [ $# -lt 1 -o $# -gt 2 ] && {
        echo "Usage: chain_exists <chain_name> [table]" >&2
        return 1
    }
    local chain_name="$1" ; shift
    [ $# -eq 1 ] && local table="--table $1"
    iptables $table -n --list "$chain_name" >/dev/null 2>&1
}


chain_BOGON_add_RETURN() {
    iface=$1
    if [ "$iface" = '' ]; then
        echo "Please speicify an interface."
        exit 1
    fi
    
    chain_exists BOGON && {
        if [ "`iptables --list BOGON -nv | grep RETURN | grep $iface`" = '' ]; then
            iptables -I BOGON -i $iface -j RETURN
        fi

        return 0
    }
}
