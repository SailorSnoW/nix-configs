{ inputs, pkgs, lib, config, ... }:
{
      imports = [
        # Import shared configuration module
        (import ../shared/shared-config.nix { inherit inputs pkgs lib config; })
      ];

      users.users.snow = {
        name = "snow";
        home = "/Users/snow";
      };

      # nix-darwin use fonts.fonts which is deprecated on NixOS!!
      fonts.fonts = with pkgs; [
        fira-code
        fira-code-symbols
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
      ];

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;

      services.yabai.enable = true;
      services.yabai.package = pkgs.yabai;

      programs.tmux.enableVim = true;
      programs.tmux.enableSensible = true;
      programs.tmux.enableMouse = true;

      system.defaults = {
        # minimal dock
        dock = {
          autohide = true;
          show-process-indicators = false;
          show-recents = false;
          static-only = true;
        };
        # a finder that tells me what I want to know and lets me work
        finder = {
          AppleShowAllExtensions = true;
          ShowPathbar = true;
          FXEnableExtensionChangeWarning = false;
        };
        NSGlobalDomain = {
          "com.apple.swipescrolldirection" = false;
        };
      };

      # Enable TouchId for sudo
      security.pam.enableSudoTouchIdAuth = true;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 4;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Enable Rosetta compatibility for Apple silicon
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
}
