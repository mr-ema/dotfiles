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

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

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
    with pkgs; builtins.concatLists [
      # Core
      [ coreutils openssh glibc xclip wget git ]
      [ zsh bash ]

      # Compression
      [ zip unzip gnutar ]

      # Text manipulation
      [ figlet ripgrep jq ]

      # Other
      [ du-dust btop hyperfine ]
      [ (unstable.fzf) bat tldr entr ]
      [ oh-my-posh ]

      # [Image - Video] Stuff
      [ ffmpeg imagemagick ]

      # Terminal - Editor
      [ (unstable.kitty) (unstable.neovim) ]
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
