#!/bin/bash

set -e
set -u

cleanup() {
    if [[ -v includes ]] && [[ -n "${includes}" ]] ; then
        rm "${includes}"
    fi
}
trap cleanup INT TERM EXIT ERR

usage_helper() {
    echo 'backup-sysfs.sh <target_sys_dir>'
}

usage() {
    retval=$1 && shift
    if [[ ${retval} -gt 0 ]]; then
        usage_helper 1>&2
    else
        usage_helper
    fi
    exit ${retval}
}

if [[ $# -ne 1 ]] ; then
    usage 1
else
    case " ${1} " in
    " -h "|" --help "|" -? "|" --usage ")
        usage 0
        ;;
    esac
fi

target="${1}" && shift
if [[ $# -gt 0 ]] ; then
    usage 1
fi

#(
#find -H /sys/ -xdev -type d -exec mkdir -p .{} \;
#find -H /sys/ -xdev -type l -exec rsync --exclude-from=rsync-excludes.txt -avSHPl {} .{} \;
#find -H /sys/ -xdev '(' -iname uuid -o -iname guid ')' -exec rsync --exclude-from=rsync-excludes.txt -avSHPl {} .{} \;
#) 2>/dev/null

includes=$(mktemp)
mkdir "${target}"
find -H /sys -xdev '(' -type d -o -type l \
		    -o '(' -type f \
			-a '(' \
				-name uuid -o -name guid -o -name wwid -o -name eui -o \
				-name host_sas_address -o -name sas_address -o \
				-name port_no -o \
				-name hid -o -name cid -o -name uid -o \
				-name partition ')' \
			')' \
		    ')' -print | sed 's,^/,,g' > "${includes}"
rsync -W -x -d -avSHP --specials --files-from="${includes}" --include-from="${includes}" / "${target}/" 2>/dev/null
