#!/bin/bash
TMPFILE=$(mktemp)

# save the message to a file
cat - >"$TMPFILE"
# extract the date header
DATE=$( formail -xDate: < "$TMPFILE" )
# convert to the current timezone (defined by TZ)
DATE=$( date -R -d "$DATE" )
# output the modified message
echo "Date: $DATE"
formail -fI Date < "$TMPFILE"
# clean up
rm -f "$TMPFILE"
