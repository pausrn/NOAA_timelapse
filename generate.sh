enhanc=$1
files=$(cat fileList)
ind=0
tot=($files)
tot=${#tot[@]}

for name in $files
do
	wxtoimg -m MAP/$name.png -e $enhanc RAW/$name.png $enhanc/$name.png
	echo $ind/$tot
	ind=$(( $ind + 1 ))
done
