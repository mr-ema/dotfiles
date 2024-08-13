{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Game manager
    lutris-free

    # Additional dependencies
    pkgsi686Linux.SDL2
    pkgsi686Linux.dbus
    pkgsi686Linux.sqlite


    # Support both 32- and 64-bit applications
    wineWowPackages.stableFull

    # Support 32-bit only
    wine

    # Support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # Support 64-bit only
    wine64

    # Winetricks (all versions)
    winetricks
  ];
}
