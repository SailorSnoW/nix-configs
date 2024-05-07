{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # Import shared configuration module
    (import ../shared/shared-config.nix { inherit inputs pkgs lib config; })
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings = {
    trusted-users = [ "root" "@wheel" ];
  };

  users.users = {
    snow = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "audio" "video" "libvirtd"];
      shell = pkgs.zsh;
    };
  };

  time = {
    timeZone = "Europe/Paris";
    hardwareClockInLocalTime = true;
  };
  
  i18n.defaultLocale = "fr_FR.UTF-8";

  networking.hostName = "snOwOS";

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  security.sudo.enable = true;
  services.blueman.enable = true;
  location.provider = "geoclue2";

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # console.keyMap = "fr";
  console.useXkbConfig = true;
  programs.hyprland.enable = true;

  virtualisation = {
    libvirtd.enable = true;
  };
  services.dbus.enable = true;
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
    glxinfo
    blueman
    bluez
    pulseaudioFull
    bluez-tools
    xorg.xwininfo
    brightnessctl
    pulseaudio
    xdg-utils
    gtk3
    firefox
  ];  

  # Hyprland fixes
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.WLR_RENDERER_ALLOW_SOFTWARE = "1";

  programs.dconf.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  
  security.polkit.enable = true;

  services = {
    printing.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    upower.enable = true;
    xserver = {
      enable = true;
      xkb.layout = "fr";
      xkb.variant = "mac";
     # desktopManager = {
     #   plasma5.enable = true;
     # };
    };
    displayManager.sddm.enable = true;
    libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        middleEmulation = true;
        naturalScrolling = true;
      };
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --remember --cmd Hyprland";
          user = "snow";
        };
      };
    };
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        # Remove if you want to SSH using passwords
        PasswordAuthentication = false;
      };
    };
  };

  # Prevent systemd spam on tuigreet interface
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StantardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  }; 

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}