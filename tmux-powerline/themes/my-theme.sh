# My Theme

if patched_font_in_use; then
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD=""
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN=""
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'235'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'255'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_BOLD}

# See man tmux.conf for additional formatting options for the status line.
# The `format regular` and `format inverse` functions are provided as conveinences

# アクティブウィンドウ: 通常時は白背景、モード時はマゼンタ背景（弓矢の羽根形状）
if [ -z $TMUX_POWERLINE_WINDOW_STATUS_CURRENT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_CURRENT=(
		"#{?pane_in_mode," \
			"#[fg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,bg=colour165]" \
			"$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD" \
			"#[fg=colour16#,bold]" \
			" #I#F " \
			"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
			" #W " \
			"#[fg=colour165#,bg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,nobold]" \
			"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"," \
			"#[$(format inverse)]" \
			"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
			" #I#F " \
			"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
			" #W " \
			"#[$(format regular)]" \
			"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"}"
	)
fi

if [ -z $TMUX_POWERLINE_WINDOW_STATUS_STYLE ]; then
	TMUX_POWERLINE_WINDOW_STATUS_STYLE=(
		"$(format regular)"
	)
fi

# 非アクティブウィンドウ: 通常時は灰色、モード時はマゼンタ、ベル時はオレンジ背景（弓矢の羽根形状）
if [ -z $TMUX_POWERLINE_WINDOW_STATUS_FORMAT ]; then
	TMUX_POWERLINE_WINDOW_STATUS_FORMAT=(
		"#{?pane_in_mode," \
			"#[fg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,bg=colour165]" \
			"$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD" \
			"#[fg=colour16#,bold]" \
			" #I#{?window_flags,#F, } " \
			"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
			" #W " \
			"#[fg=colour165#,bg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,nobold]" \
			"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
		"," \
			"#{?window_bell_flag," \
				"#[none#,fg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,bg=colour208]" \
				"$TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD" \
				"#[none#,fg=colour16#,bg=colour208#,bold]" \
				" #I#{?window_flags,#F, } " \
				"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
				" ⚡#W " \
				"#[none#,fg=colour208#,bg=colour$TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR#,nobold]" \
				"$TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR" \
			"," \
				"#[$(format regular)]" \
				"  #I#{?window_flags,#F, } " \
				"$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN" \
				" #W " \
			"}" \
		"}"
	)
fi

# Format: segment_name background_color foreground_color [non_default_separator] [separator_background_color] [separator_foreground_color] [spacing_disable] [separator_disable]
#
# non_default_separator - specify an alternative character for this segment's separator
# separator_background_color - specify a unique background color for the separator
# separator_foreground_color - specify a unique foreground color for the separator
# spacing_disable - remove space on left, right or both sides of the segment:
#
#   "left_disable" - disable space on the left
#   "right_disable" - disable space on the right
#   "both_disable" - disable spaces on both sides
#   * - any other character/string produces no change to default behavior (eg "none", "X", etc.)
#
# separator_disable - disables drawing a separator on this segment, very useful for segments
# with dynamic background colours (eg tmux_mem_cpu_load)
#
#   "separator_disable" - disables the separator
#   * - any other character/string produces no change to default behavior
#
# Example segment with separator disabled and right space character disabled:
# "hostname 33 0 {TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD} 33 0 right_disable separator_disable"
#
# Note that although redundant the non_default_separator, separator_background_color and
# separator_foreground_color options must still be specified so that appropriate index
# of options to support the spacing_disable and separator_disable features can be used

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"tmux_session_info 148 234" \
		"hostname 33 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"date 235 136 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN}" \
	)
fi
