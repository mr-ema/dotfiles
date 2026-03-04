{ config, pkgs, lib, ... }:

{
  # Enable X11 (required even for Wayland sessions)
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    kitty               # terminal
    waybar              # top bar
    wofi                # app launcher
    dunst               # notifications
    hyprpaper           # wallpaper
    networkmanager      # network manager
  ];
}
