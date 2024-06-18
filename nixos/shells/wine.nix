{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
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
}
