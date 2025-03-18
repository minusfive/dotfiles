#!/usr/bin/env zsh
# Configure OS settings. Resources:
# - https://developer.apple.com/documentation/devicemanagement/profile-specific-payload-keys
# - https://marslo.github.io/ibook/osx/defaults.html
# - https://gist.github.com/sbolel/f6985346a33c65f5f7ce37b963a22531
# - https://ss64.com/mac/syntax-defaults.html
# - https://github.com/ryuichi1208/homecmd/blob/master/conf/macos.sh

# Exit immediately if a command fails and treat unset vars as error
set -euo pipefail

# Immediately invoked anonymous function with the script's path as its only argument
# used to contain variables and functions in a local scope
function {
  local __hammerspoon_config_file="$HOME/.config/hammerspoon/init.lua"
  local __screenshots_dir="$HOME/Pictures/screenshots"
  local __dock_icon_size_px=64
  local __dock_icon_magnified_size_px=72

  function underline() { print -P "%U$@%u" }
  function log_info() { print -P "%F{blue}󰬐  $1%f" }
  function log_ok() { print -P "%F{green}󰄲  $1%f" }
  function log_error() { print -P "%F{red}󰡅  $1%f" }


  # Screenshots
  # Create screenshots dir if it doesn't exist
  if [[ -d "$__screenshots_dir" ]]; then
    log_ok "Screenshots dir exists: $__screenshots_dir"
  else
    log_info "Creating screenshots dir: $__screenshots_dir"
    mkdir -p "$__screenshots_dir"

    if [[ $? == 0 ]]; then
      log_ok "Screenshots dir created: $__screenshots_dir"
    fi
  fi

  log_info "Moving screenshots from ~/Desktop to $__screenshots_dir"
  mv "$HOME/Desktop/Screenshot*" "$__screenshots_dir" 2>/dev/null || true
  log_ok "Screenshots moved to $__screenshots_dir"

  log_info "Set $(underline Screenshots) save location to $__screenshots_dir"
  defaults write com.apple.screencapture location -string "$__screenshots_dir"
  log_ok "$(underline Screenshots) location set to $__screenshots_dir"


  # Trackpad
  log_info "Set $(underline Trackpad) to use tap to click"
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  log_ok "$(underline Trackpad) set to use tap to click"

  log_info "Set $(underline Trackpad) speed"
  defaults write -g com.apple.trackpad.scaling -float 3.0
  log_ok "$(underline Trackpad) speed set"

  log_info "Set $(underline Trackpad) to disable 3-finger lookup"
  # 0: Disable
	# 1: Force Click with one finger
	# 2: Tap with Three fingers
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -int 0
  log_ok "$(underline Trackpad) set to disable 3-finger lookup"

  log_info "Set $(underline Trackpad) 3-finger horizontal swipe to switch pages"
  # Whether to enable three-finger horizontal swipe gesture:
  # 0: disable
  # 1: swipe between pages
  # 2: swipe between full-screen applications.
  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 1
  log_ok "$(underline Trackpad) 3-finger horizontal swipe set to switch pages"


  # Keyboard
  log_info "Enable $(underline Keyboard) UI navigation"
  defaults write -g AppleKeyboardUIMode -int 2
  log_ok "$(underline Keyboard) UI navigation enabled"


  # System
  log_info "Set $(underline System) to require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -bool true
  defaults write com.apple.screensaver askForPasswordDelay -int 0
  log_ok "$(underline System) set to require password immediately after sleep or screen saver begins"

  log_info "Set $(underline System) to dark mode"
  defaults write -g AppleInterfaceStyle -string "Dark"
  log_ok "$(underline System) set to dark mode"

  log_info "Set $(underline System) to use 24hr time"
  defaults write -g AppleICUForce24HourTime -bool true
  log_ok "$(underline System) set to use 24hr time"

  log_info "Set $(underline Printing) to quit printer app once the print jobs complete"
  defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
  log_ok "$(underline Printing) set to quit printer app once the print jobs complete"

  # log_info "Set $(underline System) wallpaper"
  # osascript -e "tell application 'Finder' to set desktop picture to POSIX file '$HOME/.config/minusfive/wallpaper.jpg'"
  # log_ok "$(underline System) wallpaper set"

  # Menu bar
  log_info "Set $(underline Menu Bar) to show date and 24hr time"
  defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM H:mm"
  defaults write com.apple.menuextra.clock Show24Hour -bool true
  defaults write com.apple.menuextra.clock ShowAMPM -bool false
  defaults write com.apple.menuextra.clock ShowDay -bool true
  defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
  defaults write com.apple.menuextra.clock ShowMonth -bool true
  defaults write com.apple.menuextra.clock ShowSeconds -bool false
  defaults write com.apple.menuextra.clock IsAnalog -bool false
  log_ok "$(underline menu bar) set to show date and 24hr time"


  # Enable subpixel font rendering on non-Apple LCDs
  log_info "Set $(underline font smoothing) to subpixel font rendering on non-Apple displays"
  defaults write -g AppleFontSmoothing -int 2
  log_ok "$(underline font smoothing) set to subpixel font rendering on non-Apple displays"


  # Hammerspoon
  log_info "Set $(underline "Hammerspoon") to read config from $__hammerspoon_config_file"
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$__hammerspoon_config_file"
  log_ok "$(underline "Hammerspoon") config dir set to $__hammerspoon_config_file"


  # Safari
  log_info "Set $(underline Safari) to show develop menu"
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
  defaults write -g WebKitDeveloperExtras -bool true
  log_ok "$(underline Safari) set to show develop menu"

  log_info "Set $(underline Safari) to show full URL in address bar"
  defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
  log_ok "$(underline Safari) set to show full URL in address bar"

  log_info "Set $(underline Safari) to use the compact tab bar"
  defaults write com.apple.Safari ShowStandaloneTabBar -bool false
  log_ok "$(underline Safari) set to use the compact tab bar"

  log_info "Set $(underline Safari) to always show website title"
  defaults write com.apple.Safari EnableNarrowTabs -bool false
  log_ok "$(underline Safari) set to always show website title"

  log_info "Set $(underline Safari) to always open new pages in tabs vs. windows"
  defaults write com.apple.Safari TabCreationPolicy -int 2
  log_ok "$(underline Safari) set to always open new pages in tabs vs. windows"

  log_info "Set $(underline Safari) to activate tabs when opened"
  defaults write com.apple.Safari OpenNewTabsInFront -bool true
  log_ok "$(underline Safari) set to activate tabs when opened"

  log_info "Set $(underline Safari) to clear downloads on success"
  defaults write com.apple.Safari DownloadsClearingPolicy -int 2
  log_ok "$(underline Safari) set to clear downloads on success"

  log_info "Set $(underline Safari) to NOT preload top hit"
  defaults write com.apple.Safari PreloadTopHit -bool false
  log_ok "$(underline Safari) set to NOT preload top hit"

  log_info "Set $(underline Safari) to NOT use website specific search"
  defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false
  log_ok "$(underline Safari) set to NOT use website specific search"

  log_info "Set $(underline Safari) to NOT show favorites under smart search field"
  defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false
  log_ok "$(underline Safari) set to NOT show favorites under smart search field"

  log_info "Set $(underline Safari) to NOT offer to store autofill data"
  defaults write com.apple.Safari AutoFillCreditCardData -bool false
  defaults write com.apple.Safari AutoFillFromAddressBook -bool false
  defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
  defaults write com.apple.Safari AutoFillPasswords -bool false
  log_ok "$(underline Safari) set to NOT offer to store autofill data"


  # Finder

  log_info "Set $(underline Finder) to start at $HOME"
  defaults write com.apple.finder NewWindowTarget -string "$HOME"

  log_info "Set $(underline Finder) to show all filename extensions"
  defaults write -g AppleShowAllExtensions -bool true
  log_ok "$(underline Finder) set to show all filename extensions"

  log_info "Set $(underline Finder) to show all files"
  defaults write com.apple.finder AppleShowAllFiles -bool true
  log_ok "$(underline Finder) set to show all files"

  log_info "Set $(underline Finder) to show path bar"
  defaults write com.apple.finder ShowPathbar -bool true
  log_ok "$(underline Finder) set to show path bar"

  log_info "Set $(underline Finder) to show status bar"
  defaults write com.apple.finder ShowStatusBar -bool true
  log_ok "$(underline Finder) set to show status bar"

  log_info "Set $(underline Finder) to show sidebar"
  defaults write com.apple.finder ShowSidebar -bool true
  log_ok "$(underline Finder) set to show sidebar"

  log_info "Set $(underline Finder) to show preview pane"
  defaults write com.apple.finder ShowPreviewPane -bool true
  log_ok "$(underline Finder) set to show preview pane"

  log_info "Set $(underline Finder) default view to $(underline Column)"
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
  log_ok "$(underline Finder) default view set to $(underline Column)"

  log_info "Set $(underline Finder) to show dirs first"
  defaults write com.apple.finder _FXSortFoldersFirst -bool true
  defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
  log_ok "$(underline Finder) set to show dirs first"

  log_info "Set $(underline Finder) to open dirs in tabs on command + double-click"
  defaults write com.apple.finder FinderSpawnTab -bool true
  log_ok "$(underline Finder) set to open dirs in tabs on command + double-click"

  log_info "Set $(underline Finder) default search scope to current dir"
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
  log_ok "$(underline Finder) default search scope set to current dir"

  log_info "Set $(underline Finder) to empty trash after 30 days"
  defaults write com.apple.finder FXRemoveOldTrashItems -bool true
  log_ok "$(underline Finder) set to empty trash after 30 days"

  log_info "Set $(underline Finder) to show file extension change warning"
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
  log_ok "$(underline Finder) set to show file extension change warning"

  log_info "Set $(underline Finder) to use full POSIX path in title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
  log_ok "$(underline Finder) set to use full POSIX path in title"

  log_info "Set $(underline Finder) to show window titlebar icons"
  defaults write com.apple.universalaccess showWindowTitlebarIcons -bool true
  log_ok "$(underline Finder) set to show window titlebar icons"

  log_info "Set $(underline Finder) to show window titlebar icons on hover immediately"
  defaults write -g NSToolbarTitleViewRolloverDelay -float "0"
  log_ok "$(underline Finder) set to show window titlebar icons on hover immediately"

  log_info "Set $(underline Finder) to sort dirs first on desktop"
  defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true
  log_ok "$(underline Finder) set to sort dirs first on desktop"

  log_info "Set $(underline Finder) to show hard drives on desktop"
  defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
  log_ok "$(underline Finder) set to show hard drives on desktop"

  log_info "Set $(underline Finder) to show external hard drives on desktop"
  defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
  log_ok "$(underline Finder) set to show external hard drives on desktop"

  log_info "Set $(underline Finder) to show removable media on desktop"
  defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
  log_ok "$(underline Finder) set to show removable media on desktop"

  log_info "Set $(underline Finder) to show mounted servers on desktop"
  defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
  log_ok "$(underline Finder) set to show mounted servers on desktop"

  log_info "Set $(underline Finder) and desktop icons to sort by name"
  defaults write com.apple.finder DesktopViewSettings.IconViewSettings.arrangeBy -string name
  defaults write com.apple.finder FK_StandardViewSettings.IconViewSettings.arrangeBy -string name
  defaults write com.apple.finder StandardViewSettings.IconViewSettings.arrangeBy -string name
  log_ok "$(underline Finder) and desktop icons set to sort by name"

  log_info "Set $(underline Finder) to NOT add DS_Store files to USB and network drives"
  defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  log_ok "$(underline Finder) set to NOT add DS_Store files to USB and network drives"


  # Dock
  # TODO: Explore dockutil
  # TODO: Explore adding folders with script https://gist.github.com/kamui545/c810eccf6281b33a53e094484247f5e8
  # TODO: Perhaps https://developer.apple.com/documentation/devicemanagement/dock/staticitem/tile-data-data.dictionary
  log_info "Set $(underline Dock) icon size to ${__dock_icon_size_px}px"
  defaults write com.apple.dock tilesize -int $__dock_icon_size_px
  log_ok "$(underline Dock) icon size set to ${__dock_icon_size_px}px"

  log_info "Set $(underline Dock) to magnify icons on hover"
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock largesize -int $__dock_icon_magnified_size_px
  log_ok "$(underline Dock) set to magnify icons on hover"

  log_info "Set $(underline Dock) to autohide"
  defaults write com.apple.dock autohide -bool true
  log_ok "$(underline Dock) set to autohide"

  log_info "Set $(underline Dock) to show only running apps"
  defaults write com.apple.dock "static-only" -bool true
  log_ok "$(underline Dock) set to show only running apps"

  log_info "Set $(underline Dock) to spring load items"
  defaults write com.apple.dock "enable-spring-load-actions-on-all-items" -bool true
  log_ok "$(underline Dock) set to spring load items"


  # Mission Control
  log_info "Set $(underline Dock) to group app windows in Mission Control"
  defaults write com.apple.dock "expose-group-apps" -bool true
  log_ok "$(underline Dock) set to group app windows in Mission Control"


  # Spaces
  log_info "Set $(underline Spaces) to switch on app activation"
  defaults write -g AppleSpacesSwitchOnActivate -bool true
  log_ok "$(underline Spaces) set to switch spaces on app activation"

  log_info "Set $(underline Spaces) to be unique per display"
  defaults write com.apple.spaces "spans-displays" -bool false
  log_ok "$(underline Spaces) set to be unique per display"


  # Restart processes to apply changes
  log_info "Clearing $(underline cfprefsd) cache"
  killall cfprefsd
  log_ok "$(underline cfprefsd) cache cleared"

  log_info "Restarting $(underline SystemUIServer) to apply changes"
  killall SystemUIServer
  log_ok "$(underline SystemUIServer) restarted"

  log_info "Restarting $(underline Finder) to apply changes"
  killall Finder
  log_ok "$(underline Finder) restarted"

  log_info "Restarting $(underline Dock) to apply changes"
  killall Dock
  log_ok "$(underline Dock) restarted"

  # Restart Safari if running
  if [[ $(pgrep -x "Safari") ]]; then
    log_ok "Restarting $(underline Safari) to apply changes"
    killall -q Safari 2>/dev/null || true
    open --background -a Safari
    log_ok "$(underline Safari) restarted"
  fi
} $(realpath $0)

