{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
        "unityhub"
    ];

  environment.systemPackages = with pkgs; [ unityhub dotnet-sdk dotnet-sdk_8 mono msbuild ];
}
