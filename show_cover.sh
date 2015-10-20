#!/bin/bash
#
# @(#)$Id$
#
# A small script for showing cover art in a separate feh window
# USAGE:
#   I will post it here ASAP

# first ask 'cmus-remote' for the song's dir and attach cover's fielname 
# (here I use '.cover.jpg', but it can be changed)
COVER=$( cmus-remote -Q 2>/dev/null | grep file | cut -d " " -f 2- )
COVER=$( dirname "${COVER}"  )/.cover.jpg
# read previous cover's name from the 'cover_url' file
PREV_COVER=$(</home/$USER/.config/cmus/cover_url)
# check if the cover should change - prevents from closing and opening the same
# file all over again when you play songs from one album
if [ ! "$COVER" == "$PREV_COVER" ]; then
    # kill the instance of feh with the window name FEH_CMUS (so as not to kill other feh instances)
    pkill -f FEH_CMUS
    # store current cover url in a file (if it does not exists an empty file
    # will be created)
    echo "$COVER" > /home/$USER/.config/cmus/cover_url
    # check if the new cover actually exists
    if [ -e "$COVER" ]; then
        #if so, open a new instance of feh with the window name FEH_CMUS (-^ option)
        /usr/bin/feh -x -. -^ FEH_CMUS  -Z -B black "${COVER}" &
    fi
fi

