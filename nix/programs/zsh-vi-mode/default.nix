{ pkgs, user, ... }:
{
  home-manager.users.${user} = {
    # TODO: Use overlays on existing packages instead of fetching from gh
    programs.zsh.plugins = [
      {
        name = "vi-mode";
        src = pkgs.fetchFromGitHub {
          owner = "jeffreytse";
          repo = "zsh-vi-mode";
          rev = "cd730cd347dcc0d8ce1697f67714a90f07da26ed";
          hash = "sha256-UQo9shimLaLp68U3EcsjcxokJHOTGhOjDw4XDx6ggF4=";
        };
        file = "zsh-vi-mode.plugin.zsh";
      }
    ];

    programs.zsh.initExtraFirst = ''
      # zsh-vi-mode settings
      zvm_config() {
        # ZVM_LINE_INIT_MODE=$ZVM_MODE_NORMAL

        ZVM_VI_HIGHLIGHT_BACKGROUND=#cba6f7
        ZVM_VI_HIGHLIGHT_FOREGROUND=#181825

        ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
        ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK

        local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
        local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
        local vcur=$(zvm_cursor_style $ZVM_VISUAL_MODE_CURSOR)
        local vlcur=$(zvm_cursor_style $ZVM_VISUAL_LINE_MODE_CURSOR)
        local opcur=$(zvm_cursor_style $ZVM_OPPEND_MODE_CURSOR)

        # Append your custom color for your cursor
        ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#89b4fa\a'
        ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#a6e3a1\a'
        ZVM_VISUAL_MODE_CURSOR=$vcur'\e\e]12;#cba6f7\a'
        ZVM_VISUAL_LINE_MODE_CURSOR=$vlcur'\e\e]12;#cba6f7\a'
        ZVM_OPPEND_MODE_CURSOR=$opcur'\e\e]12;#f38ba8\a'

        # Custom functions
        local __term_exit() {
          exit
        }

        # Custom widgets
        zvm_define_widget term_exit __term_exit

        # Custom keybindings
        zvm_bindkey vicmd 'q' term_exit
      }
    '';
  };
}
