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

  # Enable extra-container
  programs.extra-container.enable = true;

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
      [ coreutils openssh glibc xclip wget git curl ]
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
      [ libreoffice ]
      [ (unstable.oh-my-posh) (unstable.fzf) ]

      # [Image - Video] Stuff
      [ ffmpeg imagemagick flameshot ]

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

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;
}
