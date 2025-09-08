{
  description = "Keyboard.io firmware management";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default =
          removeAttrs
            (pkgs.mkShell {
              buildInputs = with pkgs; [
                arduino
                gitAndTools.git-filter-repo
              ];

              ARDUINO_PATH = "${pkgs.arduino}/share/arduino";
            })
            [
              "CXX"
              "CC"
              "AR"
            ]; # otherwise they override arduino tools
      }
    );
}
