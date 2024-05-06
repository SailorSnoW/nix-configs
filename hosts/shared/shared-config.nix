{ pkgs, ... }:
{
  # Required for vscode.
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ 
    neovim
    nodejs
    python3
    curl
    git
    jq
    htop
  ];

  # Install fonts
  fonts.fontDir.enable = true;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 5d";
  };
  nix.optimise.automatic = true;

  programs.zsh.enable = true;
  programs.tmux.enable = true;
}