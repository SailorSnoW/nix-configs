{ pkgs, config, ... }:

with config; {
  programs.kitty = {
    enable = true;
    catppuccin.enable = true;
    # theme = "Catppuccin-Mocha";
    settings = {
      font_family = "FiraCode Nerd Font";
      font_size = 15;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      
    hide_window_decorations = "titlebar-only";

      window_padding_width = 6;      
      background_opacity = "0.8";
      background_blur = 16;
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
    };
    keybindings = {
      "f1" = "show_kitty_env_vars";
    };
   # extraConfig = ''
   #   # Black
   #   color0 #${colorScheme.colors.base00}
   #   color8 #${colorScheme.colors.base00}

   #   # Red
   #   color1 #${colorScheme.colors.base01}
   #   color9 #${colorScheme.colors.base09}

   #   # Green
   #   color2 #${colorScheme.colors.base02}
   #   color10 #${colorScheme.colors.base0A}
   # '';
  };
}
