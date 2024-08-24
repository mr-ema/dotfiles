# My custom configuration for nix-on-droid "https://github.com/nix-community/nix-on-droid"

{ config, lib, pkgs, ... }:

{
  environment.packages =
    let
      unstable = import
        (fetchTarball {
          # Specify the URL or channel of the unstable Nixpkgs
          url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
        })
        { };
    in
    with pkgs; builtins.concatLists
      [
        # Core
        [ coreutils openssh glibc xclip wget git curl ]
        [ findutils streamlink ]
        [ zsh bash ]

        # Version Control
        [ verco ]

        # Compression
        [ zip unzip gnutar ]

        # Text manipulation
        [ figlet ripgrep jq ]

        # Other Tools
        [ du-dust btop hyperfine ]
        [ bat tldr entr ]
        [ (unstable.oh-my-posh) (unstable.fzf) ]

        # [Image - Video] Stuff
        [ ffmpeg imagemagick ]

        # Terminal - Editor
        [ (unstable.kitty) (unstable.neovim) ]
      ];

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  user.shell = "${pkgs.zsh}/bin/zsh"; # default shell
  terminal.font = "${pkgs.fira-code-nerdfont}/share/fonts/truetype/NerdFonts/FiraCodeNerdFontMono-Regular.ttf";

  # Text to show on every new shell created by Nix-on-Droid.
  environment.motd = null;

  # Add termux-am package
  android-integration.am.enable = true;
}

# vim: ft=nix
