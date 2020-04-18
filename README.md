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

```bash
RTMP_URL="rtmps://rtmp-api.facebook.com:80/rtmp"
RTMP_KEY="blahblahblah" #y your key goes here

ffmpeg -re -i $1 \
	-c:a copy -b:a 128k -ar 44100 \
	-vcodec libx264 -pix_fmt yuv420p \
	-r 30 -g 60 \
	-f flv "$RTMP_URL/$RTMP_KEY"
```
