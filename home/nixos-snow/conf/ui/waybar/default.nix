{ config, lib, pkgs, ... }:

{
  programs.waybar =
    with config; {
      enable = true;
      package = pkgs.waybar;
      catppuccin.enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = ''
        window#waybar {
          /*background: transparent;*/
          transition-duration: 0.5s;
          border-radius: 10px;
        }
        #workspaces {
          font-family: "Material Design Icons Desktop";
          font-size: 20px;
          margin : 4px 0;
          border-radius : 5px;
        }
        #workspaces button {
          font-size: 18px;
          background-color: transparent;
          transition: all 0.1s ease;
        }
        #workspaces button.focused {
          font-size: 18px;
        }
        #workspaces button.persistent {
          font-size: 12px;
        }
        #custom-launcher {
          margin : 4px 4.5px;
          padding : 5px 12px;
          font-size: 18px;
          border-radius : 5px;
        }
        #custom-power {
          margin : 4px 4.5px 4px 4.5px;
          padding : 5px 11px 5px 13px;
          border-radius : 5px;
        }

        #clock {
          margin : 4px 9px;
          padding : 5px 12px;
          border-radius : 5px;
        }
        
        #network {
          margin : 4px 0 4px 4.5px;
          padding : 5px 12px;
          border-radius : 5px 0 0 5px;
        }
        #battery {
          margin : 4px 0px;
          padding : 5px 12px;
          border-radius : 5px 0 0 5px;
        }
        #custom-swallow {
          margin : 4px 4.5px;
          padding : 5px 12px;
          border-radius : 5px;
        }
        * {
          font-size: 16px;
          min-height: 0;
          font-family: "FiraCode Nerd Font";
        }
      '';
      settings = [{
        height = 45;
        layer = "top";
        position = "top";
	exclusive = true;
	margin-top = 10;
	margin-right = 150;
	margin-left = 150;
        tray = { spacing = 10; };
        modules-center = [ "clock" ];
        modules-left = [ "custom/launcher" "hyprland/workspaces" ];
        modules-right = [
          "network"
          "battery"
          "custom/power"
          "tray"
        ];
        "hyprland/workspaces" = {
          on-click = "activate";
          all-outputs = true;
          format = "{icon}";
          disable-scroll = true;
          active-only = false;
          format-icons = {
            default = "󰊠 ";
            persistent = "󰊠 ";
            focused = "󰮯 ";
          };
          persistent_workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
        };
        battery = {
          format = "{icon}";
          on-click = "eww open --toggle control";
          format-charging = " ";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-plugged = "󰚦 ";
          states = {
            critical = 15;
            warning = 30;
          };
        };
        clock = {
          format = "{:%d %A %H:%M}";
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        network = {
          interval = 1;
          on-click = "eww open --toggle control";
          format-disconnected = "󰤮 ";
          format-wifi = "󰤨 ";
        };
        "custom/launcher" = {
          on-click = "eww open --toggle dash";
          format = " ";
        };
        "custom/power" = {
          on-click = "wlogout &";
          format = " ";
        };
      }];
    };
}