# My custom nixos configuration you can import it in "etc/nixos/configuration.nix"

{ config, pkgs, ... }:

{
  imports =
    [
      # Modules 
      ./modules/fhs-env.nix
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    let
      unstable = import
        (fetchTarball {
          # Specify the URL or channel of the unstable Nixpkgs
          url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
        })
        { };
    in
    with pkgs; [
      git
      openssh
      glibc
      wget
      xclip
      figlet
      ffmpeg
      zsh
      bash
      kitty

      zip
      unzip
      gnutar

      (unstable.fzf)
      (unstable.neovim)
    ];

  # Environment variables
  environment.variables.EDITOR = "neovim";

  # Shell stuff
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Garbage collect old builds
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than +3";
  };
}
