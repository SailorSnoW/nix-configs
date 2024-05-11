{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    
    userSettings = {
      "editor.fontFamily" = "FiraCode Nerd Font";
      "editor.fontSize" = 14;
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "catppuccin-mocha";
    };
    
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      vadimcn.vscode-lldb
      # Theming
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      # LSP
      bbenoist.nix
      tamasfe.even-better-toml
      rust-lang.rust-analyzer
    ];
  };
}
