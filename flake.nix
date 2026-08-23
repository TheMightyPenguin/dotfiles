{
  description = "TheMightyPenguin's dotfiles — one config, macOS + Linux 🐧";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # macOS-only system layer (defaults, fonts, Homebrew casks).
    # Ignored entirely on Linux.
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      # Everything user-facing hangs off these two values.
      username = "victor";
      email = "victormtortolero@gmail.com";

      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      darwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      allSystems = linuxSystems ++ darwinSystems;

      forAllSystems = nixpkgs.lib.genAttrs allSystems;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      specialArgs = { inherit inputs username email; };

      # Standalone home-manager: works on any Linux distro (including WSL)
      # and on a Mac where you don't want the nix-darwin system layer.
      mkHome =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor system;
          extraSpecialArgs = specialArgs;
          modules = [ ./modules/home ];
        };

      # macOS: nix-darwin system config with home-manager wired in as a module.
      mkDarwin =
        system:
        nix-darwin.lib.darwinSystem {
          inherit specialArgs;
          modules = [
            ./modules/darwin
            { nixpkgs.hostPlatform = system; }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
                users.${username} = import ./modules/home;
                backupFileExtension = "hm-bak";
              };
            }
          ];
        };
    in
    {
      # macOS   → darwin-rebuild switch --flake .#penguin
      darwinConfigurations = {
        penguin = mkDarwin "aarch64-darwin";
        penguin-intel = mkDarwin "x86_64-darwin";
      };

      # Linux / bare home-manager → home-manager switch --flake .#victor@linux
      homeConfigurations = {
        "${username}@linux" = mkHome "x86_64-linux";
        "${username}@linux-aarch64" = mkHome "aarch64-linux";
        "${username}@mac" = mkHome "aarch64-darwin";
      };

      formatter = forAllSystems (system: (pkgsFor system).nixfmt-rfc-style);

      # `nix develop` — a shell with the tools needed to drive this repo,
      # useful on a machine that has nix but nothing else yet.
      devShells = forAllSystems (
        system:
        let
          pkgs = pkgsFor system;
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.git
              pkgs.nixfmt-rfc-style
              home-manager.packages.${system}.default
            ];
          };
        }
      );
    };
}
