# zsh history daily backup
# Creates a backup once per day, skips if today's backup already exists
_backup_zsh_history() {
  local backup_dir="$HOME/.zsh_history_backup"
  local backup_file="$backup_dir/zsh_history.$(date +%Y%m%d)"

  # Skip if today's backup already exists
  [[ -f "$backup_file" ]] && return

  # Create backup directory if not exists
  [[ ! -d "$backup_dir" ]] && mkdir -p "$backup_dir"

  # Create backup
  cp "$HISTFILE" "$backup_file"

  # Remove backups older than 30 days (only when new backup is created)
  find "$backup_dir" -name "zsh_history.*" -mtime +30 -delete 2>/dev/null
}

_backup_zsh_history
