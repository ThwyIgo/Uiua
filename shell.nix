{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3650808d85dccbfa3be3d785dfd3ce33a757bd2c.tar.gz") {} }:

let vscodium = pkgs.vscode-with-extensions.override {
      vscode = pkgs.vscodium;
      vscodeExtensions = with pkgs.vscode-extensions; [
        uiua-lang.uiua-vscode
      ];
    };
    uiua = pkgs.uiua.override {
      audioSupport = false;
    };
in
pkgs.mkShell {
  buildInputs = [
    uiua # 0.0.19
  ];
  packages = [ vscodium ];
}
