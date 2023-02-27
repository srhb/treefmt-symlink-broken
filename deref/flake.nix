{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  description = "treefmt-nix broken on flakes";

  outputs = inputs @ {
    flake-parts,
    # such formatting
                     ...  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [inputs.treefmt-nix.flakeModule];
      perSystem = {
        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
        };
      };
    };
}
