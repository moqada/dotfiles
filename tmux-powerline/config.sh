# General {
	# Show which segment fails and its exit code.
	export TMUX_POWERLINE_DEBUG_MODE_ENABLED="false"
	# Use patched font symbols.
	export TMUX_POWERLINE_PATCHED_FONT_IN_USE="true"

	# The theme to use.
	export TMUX_POWERLINE_THEME="my-theme"
	# Overlay directory to look for themes. There you can put your own themes outside the repo. Fallback will still be the "themes" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_THEMES="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/themes"
	# Overlay directory to look for segments. There you can put your own segments outside the repo. Fallback will still be the "segments" directory in the repo.
	export TMUX_POWERLINE_DIR_USER_SEGMENTS="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/segments"

	# The initial visibility of the status bar. Can be {"on, off"}.
	export TMUX_POWERLINE_STATUS_VISIBILITY="on"
	# The status bar refresh interval in seconds.
	# Note that events that force-refresh the status bar (such as window renaming) will ignore this.
	export TMUX_POWERLINE_STATUS_INTERVAL="1"
	# The location of the window list. Can be {"absolute-centre, centre, left, right"}.
	export TMUX_POWERLINE_STATUS_JUSTIFICATION="left"

	# The maximum length of the left status bar.
	export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
	# The maximum length of the right status bar.
	export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"

	# Uncomment these if you want to enable tmux bindings for muting (hiding) one of the status bars.
	# E.g. this example binding would mute the left status bar when pressing <prefix> followed by Ctrl-[
	#export TMUX_POWERLINE_MUTE_LEFT_KEYBINDING="C-["
	#export TMUX_POWERLINE_MUTE_RIGHT_KEYBINDING="C-]"
# }

# date.sh {
	# date(1) format for the date. If you don't, for some reason, like ISO 8601 format you might want to have "%D" or "%m/%d/%Y".
	export TMUX_POWERLINE_SEG_DATE_FORMAT="%m/%d %H:%M"
# }

# hostname.sh {
	# Use short or long format for the hostname. Can be {"short, long"}.
	export TMUX_POWERLINE_SEG_HOSTNAME_FORMAT="short"
# }

# tmux_session_info.sh {
	# Session info format to feed into the command: tmux display-message -p
	# For example, if FORMAT is '[ #S ]', the command is: tmux display-message -p '[ #S ]'
	export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#S:#I.#P"
# }
