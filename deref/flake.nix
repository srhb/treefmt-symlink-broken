{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt.url = "github:numtide/treefmt/v2.1.1";
    nix.url = "github:nixos/nix/2.25.4";
  };

  description = "treefmt-nix broken on flakes";

  outputs = inputs @ {
    flake-parts,
    # such formatting
                     ...  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [inputs.treefmt-nix.flakeModule];
      perSystem = { inputs', pkgs, ... }: {
        treefmt = {
          package = inputs'.treefmt.packages.default;
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
        };
        devShells.default = pkgs.mkShell {
          packages = [
            # inputs'.nix.packages.default
          ];
        };
      };
    };
}
