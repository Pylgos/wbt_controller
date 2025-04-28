{
  inputs = {
    rosnix.url = "github:Pylgos/rosnix/release";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      flake-utils,
      rosnix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = rosnix.legacyPackages.${system}.jazzy;
        inherit (pkgs) rosPackages;
      in
      {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [
            pkgs.bashInteractive
            rosPackages.ament-cmake
          ];
        };
      }
    );
}
