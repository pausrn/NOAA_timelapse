exePath=$1
fps=$2
path=$3
out=$4

$exePath -y -framerate $fps -vcodec png -i $path -vcodec h264 -acodec aac -strict experimental -ac 2 -r 15 -ab 44100 -preset ultrafast -crf 15 -r $fps $out 
