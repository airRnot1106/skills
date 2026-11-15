{
  description = "Agent skills used in this repository";

  inputs = {
    agenput-skills = {
      url = "github:airRnot1106/agenput-skills-nix";
      inputs.layat.follows = "layat";
    };
    flake-utils.url = "github:numtide/flake-utils";
    layat = {
      url = "github:yasunori0418/layat";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    yomiyasu = {
      url = "github:nanaism/yomiyasu";
      flake = false;
    };
  };

  outputs =
    {
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };

        skills = inputs.agenput-skills.lib.mkSkills {
          inherit pkgs;
          sets.skills = {
            scope = "project";
            paths = [
              inputs.agenput-skills.lib.presets.claude.project
            ];
            sources = [
              {
                src = inputs.yomiyasu;
                dir = "skills";
                skills = [ "yomiyasu" ];
              }
            ];
          };
        };
      in
      {
        inherit (skills) layat;
        devShells.default = skills.devShell;
      }
    );
}
