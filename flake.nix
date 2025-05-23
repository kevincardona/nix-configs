{
  description = "Basic NixOS flake";

  inputs = {
    # Option 1: Both on unstable (recommended for latest features)
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nvim.url = "github:kevincardona/nvim?ref=main";
    dotfiles.url = "github:kevincardona/.dotfiles?ref=main";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nvim, dotfiles, ... }@inputs:
    let
      overlays = [ ];
      mkSystem = import ./lib/mksystem.nix {
        inherit overlays nixpkgs inputs;
      };
    in
    {
      nixosConfigurations.proart13 = mkSystem "proart13" {
        system = "proart13";
        user = "kevincardona";
      };

      nixosConfigurations.vm-aarch64-utm = mkSystem "vm-aarch64-utm" {
        system = "vm-aarch64-utm";
        user = "kevincardona";
      };

      darwinConfigurations.m1 = mkSystem "m1" {
        system = "aarch64-darwin";
        user = "kevincardona";
        darwin = true;
      };
    };
}

