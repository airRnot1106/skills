{
  description = "airRnot's agent skills";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur-packages.url = "github:airRnot1106/nur-packages";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        textlint-filter-rule-comments =
          inputs.nur-packages.packages.${pkgs.stdenv.hostPlatform.system}.textlint-filter-rule-comments;
        textlint-rule-preset-ai-writing =
          inputs.nur-packages.packages.${pkgs.stdenv.hostPlatform.system}.textlint-rule-preset-ai-writing;

        textlint = pkgs.textlint.withPackages (
          with pkgs;
          [
            textlint-filter-rule-comments
            textlint-rule-preset-ai-words-ja
            textlint-rule-preset-ai-writing
            textlint-rule-preset-ja-spacing
            textlint-rule-preset-ja-technical-writing
            textlint-rule-terminology
          ]
        );

        formatter = inputs.treefmt-nix.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            oxfmt.enable = true;
          };
        };

        git-hooks-check = inputs.git-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            gitleaks.enable = true;
            jactionlint = rec {
              enable = true;
              package = pkgs.jactionlint.overrideAttrs { doCheck = false; };
              entry = "${pkgs.lib.getExe package} --shellcheck=${pkgs.lib.getExe pkgs.shellcheck}";
              files = "^\\.github/(workflows/.*|dependabot)\\.ya?ml$|(^|/)action\\.ya?ml$";
            };
            textlint = {
              enable = true;
              package = textlint;
              entry = pkgs.lib.getExe' textlint "textlint";
              files = "\\.md$";
            };
            treefmt = {
              enable = true;
              package = formatter;
            };
          };
        };
      in
      {
        inherit formatter;
        checks = {
          inherit git-hooks-check;
        };
        devShells.default = pkgs.mkShellNoCC {
          inherit (git-hooks-check) shellHook;
          packages = git-hooks-check.enabledPackages;
        };
      }
    );
}
