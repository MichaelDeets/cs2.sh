#!/bin/bash -a

GAMEROOT=$(cd "${0%/*}" && echo $PWD)
UNAMEPATH=/bin/uname
UNAME=`${UNAMEPATH}`
GAMEEXE=bin/linuxsteamrt64/cs2

#STEAM_RUNTIME_PREFIX=/valve/steam-runtime/shell.sh
#USE_STEAM_RUNTIME=1

export LD_LIBRARY_PATH="${GAMEROOT}"/bin/linuxsteamrt64:$LD_LIBRARY_PATH
export ENABLE_PATHMATCH=1
export SDL_VIDEO_DRIVER=x11

LAUNCHOPTS="-nojoy -no-browser"

. ~/.cs2/pre.sh
cd "$GAMEROOT"
STATUS=42
while [ $STATUS -eq 42 ]; do
	${STEAM_RUNTIME_PREFIX} ${SCHEDRT} ionice -c 2 -n 0 "${GAMEROOT}"/${GAMEEXE} ${LAUNCHOPTS} "$@"
	STATUS=$?
done
. ~/.cs2/post.sh
exit $STATUS
