{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: let
        basePkgs = base.targetPkgs pkgs;
      in
        basePkgs ++ [
          pkgs.pkg-config
          pkgs.ncurses
          pkgs.glibc
          pkgs.appimage-run
        ];
      profile = "export FHS=1";
      runScript = "zsh";
      extraOutputsToInstall = ["dev"];
    }))
  ];
}
