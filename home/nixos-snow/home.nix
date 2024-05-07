# home-manager module that basically just extend the darwin module to add OS related stuff like WM...
{ config, pkgs, lib, ... }:

{
  imports = [
    (import ../snow/home.nix { inherit config pkgs lib; } )
    (import ./conf/ui/hyprland/default.nix { inherit pkgs config; })
    (import ./conf/ui/wlogout/default.nix { inherit pkgs; })
    (import ./conf/ui/waybar/default.nix { inherit pkgs hyprland lib config; })
    (import ./conf/utils/rofi/default.nix { inherit pkgs; })
  ]
}