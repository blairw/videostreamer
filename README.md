# videostreamer

## 1. Installing ffmpeg with OpenSSL on Mac

This part adapted from https://gist.github.com/Piasy/b5dfd5c048eb69d1b91719988c0325d8

```bash
brew uninstall --force --ignore-dependencies ffmpeg
brew install chromaprint amiaopensource/amiaos/decklinksdk
brew tap homebrew-ffmpeg/ffmpeg
brew install homebrew-ffmpeg/ffmpeg/ffmpeg $(brew options homebrew-ffmpeg/ffmpeg/ffmpeg | grep -vE '\s' | grep -- '--with-' | grep -vi chromaprint | grep -vi game-music-emu | tr '\n' ' ')
```

## 2. Shell script
This assumes AAC encoding for the audio. If it isn't already AAC-encoded, use HandBrake to fix that up first!

Some comments:

- You have to set `PIXELS_WIDE` to the _horizontal_ pixel count that you want to broadcast at. For example, for 720p, this number should be set to `1280` for a 16:9 video (1280x720); for 1080p, this number should be set to `1920` for a 16:9 video (1920x1080).

```bash
RTMP_URL="rtmps://rtmp-api.facebook.com:443/rtmp"
RTMP_KEY="blahblahblah" #y your key goes here
PIXELS_WIDE="1280"

ffmpeg -re -i $1 \
	-deinterlace \
	-c:a copy -b:a 128k -ar 44100 \
	-vcodec libx264 -vf scale=$PIXELS_WIDE:-1 -pix_fmt yuv420p \
	-acodec aac -strict -2 \
	-flags +global_header \
	-r 30 -g 60 \
	-f flv "$RTMP_URL/$RTMP_KEY"
```
