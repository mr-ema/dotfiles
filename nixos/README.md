## NixOS
NixOS is a Linux distribution based on Nix a package manager which comes
in a form of many command line tools. Packages that Nix can build are
defined with the Nix Expression Language.


## Remove Old Generations
```
nix-env --list-generations

nix-collect-garbage  --delete-old

nix-collect-garbage  --delete-generations 1 2 3

# recommeneded to sometimes run as sudo to collect additional garbage
sudo nix-collect-garbage -d

# As a separation of concerns - you will need to run this command to clean out boot
sudo /run/current-system/bin/switch-to-configuration boot
```
