{
  description = "My agent skills";

  inputs = {
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      git-hooks,
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      inherit (nixpkgs) lib;
      forEachSystem = lib.genAttrs [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          inherit (self.checks.${system}.pre-commit-check) shellHook enabledPackages;
        in
        {
          default = pkgs.mkShell {
            inherit shellHook;
            packages =
              enabledPackages
              ++ (with pkgs; [
                nodejs-slim_24
                uv
              ]);
          };
        }
      );
      formatter = forEachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        treefmt-nix.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            ruff.enable = true;
          };
        }
      );
      checks = forEachSystem (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              actionlint.enable = true;
              ghalint = rec {
                enable = true;
                package = pkgs.ghalint;
                entry = "${pkgs.lib.getExe package} run";
                files = "^\\.github/workflows/.*\\.ya?ml$";
                pass_filenames = false;
              };
              ghalint-action = rec {
                enable = true;
                package = pkgs.ghalint;
                entry = "${pkgs.lib.getExe package} act";
                files = "^\\.github/actions/.*/action\\.ya?ml$";
                pass_filenames = true;
              };
              gitleaks = rec {
                enable = true;
                package = pkgs.gitleaks;
                entry = "${pkgs.lib.getExe package} git --pre-commit --redact --staged --verbose";
                pass_filenames = false;
              };
              pinact = rec {
                enable = true;
                package = pkgs.pinact;
                entry = "${pkgs.lib.getExe package} run -u --min-age 7";
                files = "^\\.github/workflows/.*\\.ya?ml$";
                pass_filenames = true;
              };
              ruff.enable = true;
              treefmt = {
                enable = true;
                package = self.formatter.${system};
              };
            };
          };
        }
      );
    };
}
