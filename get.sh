files=$(cat infos)
i=0
for imga in $files
do
        img=$(echo $imga | cut -d"/" -f7)
        fdate="${img:6:4}-${img:10:2}-${img:12:2} ${img:15:2}:${img:17:2}:${img:19:2}"
        etime=$(date --date="$fdate" +"%s")
        cp $img'/'$1 GET/$etime'.png'
        echo $img $etime $i
        ((i++))
done
echo finished
