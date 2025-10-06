# mynixpkgs

Personal Nix flake providing overlays for custom package versions.

## Usage

### In NixOS Configuration

Add this flake as an input to your NixOS flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    nixpkgs-overlays = {
      url = "github:hambosto/mynixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, mynixpkgs, ... }: {
    nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            mynixpkgs.overlays.default
          ];
        })
      ];
    };
  };
}
```

Then use the overlayed packages in your `configuration.nix`:

```nix
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Your overlayed packages are now available
  ];
}
```

### In Home Manager

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    
    nixpkgs-overlays = {
      url = "github:hambosto/mynixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, mynixpkgs, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ nixpkgs-overlay.overlays.default ];
      };
      
      modules = [ ./home.nix ];
    };
  };
}
```

## Rebuild

After adding the overlay, rebuild your system:

```bash
sudo nixos-rebuild switch --flake .#yourhostname
```

Or for Home Manager:

```bash
home-manager switch --flake .#yourusername
```

## Supported Systems

- `x86_64-linux`
- `aarch64-linux`

## License

See individual package repositories for their respective licenses.
