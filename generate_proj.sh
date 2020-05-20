folder=$1
files=$(cat fileList)
ind=0
tot=($files)
tot=${#tot[@]}

mkdir $folder'_rect'

for name in $files
do
	wxproj -d -l47.4667 -m-0.55 -b 70,30,-30,30 -p eckert4 $folder/$name.png $folder'_rect'/$name.png
	echo -e "\e[32m$ind/$tot\e[0m"
	ind=$(( $ind + 1 ))
	sleep 0.5
done
