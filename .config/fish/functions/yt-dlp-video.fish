function yt-dlp-video --description 'alias yt-dlp=yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
 command yt-dlp -o "%(channel)s/%(title)s.%(ext)s" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" $argv; 
end
