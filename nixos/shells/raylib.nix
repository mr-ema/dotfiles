{ pkgs ? import <nixpkgs> { } }:

let
  devDeps = with pkgs; builtins.concatLists [
    [ alsa-lib libxkbcommon mesa libGL wayland ]

    (with xorg; [
      libX11
      libXcursor
      libXrandr
      libXinerama
      libXi
      libXrender
      libXext
      libXfixes
    ])
  ];
in
# Default Shell
pkgs.mkShell
  {
    nativeBuildInputs = with pkgs; [ pkg-config rustup cmake clang ];
    buildInputs = with pkgs; [ (map (lib: lib.dev) devDeps) glfw ];

    shellHook = ''
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/run/opengl-driver/lib:/run/opengl-driver/lib64
      export CPATH=$(echo ${pkgs.lib.concatStringsSep ":" (map (dep: "${dep.dev}/include") devDeps)})
    '';
  }
  # Other Shells (ex: nix-shell -A emscripten)
  // {
  emscripten = pkgs.mkShell {
    nativeBuildInputs = with pkgs; [ pkg-config rustup cmake clang ];
    buildInputs = with pkgs; (map (lib: lib.dev) devDeps) ++ [ glfw emscripten pkgsi686Linux.glibc ];

    shellHook = ''
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/run/opengl-driver/lib:/run/opengl-driver/lib64
      export CPATH=$(echo ${pkgs.lib.concatStringsSep ":" (map (dep: "${dep.dev}/include") devDeps)})
      export CPATH=$CPATH:${pkgs.pkgsi686Linux.glibc}/include:${pkgs.emscripten}/share/emscripten/cache/sysroot/include
    '';
  };
}
