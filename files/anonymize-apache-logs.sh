#!/usr/bin/env bash
set -e

# Number of rotated logfiles to keep unanonymized (excludes current ones!)
KEEP_ROTATED_FILES=6
WORKDIR="/var/log"

(( KEEP_ROTATED_FILES++ ))
cd $WORKDIR

# Determine how many different logs there are to check
for LOGFILE in httpd-*.log
do
    # Are there more than KEEP_ROTATED_FILES rotated versions of the logfile?
    ROTATED_FILES=($(find -s . -maxdepth 1 -name "${LOGFILE}-*.xz" -print | sort -r | tail -n +$KEEP_ROTATED_FILES))

    COUNT="${#ROTATED_FILES[@]}"

    if [ $COUNT -gt 0 ]
    then
        # Find rotated files to anonymize
        for FILE in "${ROTATED_FILES[@]}"
        do
            # Uncompress, pipe into anonip, compress again and redirect output to archive dir
            cat $FILE | unxz | /root/bin/anonip.py | xz >> ./httpd-anonymized/$FILE
            rm $FILE
        done
    fi
done