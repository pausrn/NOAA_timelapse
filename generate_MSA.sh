files=$(cat fileList)
ind=0
tot=($files)
tot=${#tot[@]}

for name in $files
do
	average=$(./getFirstColumnAverage RAW/$name.png)
	if (( $(echo "$average < 1500" | bc -l) ))
	then
		enhanc="MSA"
	else
		enhanc="MCIR"
	fi
	echo $enhanc
	wxtoimg -m MAP/$name.png -e $enhanc RAW/$name.png MSA/$name.png
	echo $ind/$tot
	ind=$(( $ind + 1 ))
done
