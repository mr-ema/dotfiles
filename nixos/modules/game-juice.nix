{ pkgs, username, ... }:

{
  environment.systemPackages = with pkgs; [
    steam
    lutris-free

    # Support both 32- and 64-bit applications
    wineWowPackages.stable

    # Support 32-bit only
    wine

    # Support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # Support 64-bit only
    wine64

    # Wine-staging (version with experimental features)
    wineWowPackages.staging

    # Winetricks (all versions)
    winetricks

    # Native Wayland support (unstable)
    wineWowPackages.waylandFull
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
