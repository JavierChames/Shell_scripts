#!/bin/bash
for f in $(find . -name '*.srt'); 
do
  if grep -qi HeBits "$f"; then ##note the space after the string you are searching for
	newfile=`echo "$f" | awk -F '.srt' '{ print $1 }'`
	echo "$newfile"
	cp $f $newfile.he.srt  
else
  echo "no hebits file"
fi
done

