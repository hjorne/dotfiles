function yt-dlp-playlist --wraps='yt-dlp -o "%(channel)s/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s"' --description 'alias yt-dlp-playlist=yt-dlp -o "%(channel)s/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s"'
  yt-dlp -o "%(channel)s/%(playlist_title)s/%(playlist_index)s-%(title)s.%(ext)s" -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" $argv; 
end
