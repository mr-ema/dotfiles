{ config, pkgs, lib, ... }:

{
  # Enable X11 (required even for Wayland sessions)
  services.xserver.enable = true;

  # Display manager
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
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

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.dbus.enable = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    kitty               # terminal
    waybar              # top bar
    wofi                # app launcher
    dunst               # notifications
    hyprpaper           # wallpaper
    pavucontrol         # sound manager
    nautilus            # file manager
    gvfs                # file manager lib
    polkit_gnome        # authentication agent
  ];
}
