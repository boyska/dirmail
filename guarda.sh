#!/usr/bin/env bash
# dirmail - send mail when new file are created in dir

dir=$1
to=$2

inotifywait -m -r --format '%f' "$dir"  -e modify | while read f; do
	f="$dir/$f"
	if [ ! -f "$f" ]; then
		echo "uh? not existent! $f" >&2
		continue
	fi
	if [ ! -r "$f" ]; then
		echo "mh, not readable! $f" >&2
		continue
	fi
	echo "Trovato '$f'"
	mail "$to" -s "Notification" < "$f"
done

