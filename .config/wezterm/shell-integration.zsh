# Wezterm shell integration
if [[ "$TERM" == "wezterm" && -f "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh" ]]; then
  source "$WEZTERM_EXECUTABLE_DIR/../Resources/wezterm.sh"
fi
