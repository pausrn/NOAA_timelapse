files=$(cat enhanc.list)
ind=0
tot=($files)
tot=${#tot[@]}

for line in $files
do
	name=$(echo $line | cut -d: -f1)
	enhanc=$(echo $line | cut -d: -f2-4)
	echo $name $enhanc
	wxtoimg -o -m MAP/$name -e $enhanc RAW/$name MSA/$name

	echo $ind/$tot
	ind=$(( $ind + 1 ))
done
