awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc | column -t -s $'\t' | rofi -dmenu -i -no-show-icons -theme $HOME/.config/polybar/scripts/rofi/nord.rasi -width 1500
