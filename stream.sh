RTMP_URL="rtmps://rtmp-api.facebook.com:443/rtmp" # change this if you're not using FB
RTMP_KEY="blahblahblah" # your key goes here
PIXELS_WIDE="1280"

ffmpeg -re -i $1 \
	-deinterlace \
	-c:a copy -b:a 128k -ar 44100 \
	-vcodec libx264 -vf scale=$PIXELS_WIDE:-1 -pix_fmt yuv420p \
	-acodec aac -strict -2 \
	-flags +global_header \
	-r 30 -g 60 \
	-f flv "$RTMP_URL/$RTMP_KEY"
