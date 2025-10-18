{
  description = "nixpkgs package overlay";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    iwmenu = {
      url = "github:e-tho/iwmenu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    pwmenu = {
      url = "github:e-tho/pwmenu";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    sweetbyte = {
      url = "github:hambosto/sweetbyte";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # swww = {
    #   url = "github:LGFae/swww";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.rust-overlay.follows = "rust-overlay";
    # };
  };
  outputs =
    {
      iwmenu,
      pwmenu,
      sweetbyte,
      # swww,
      ...
    }:
    {
      overlays.default = final: prev: {
        iwmenu = iwmenu.packages.${final.system}.default;
        pwmenu = pwmenu.packages.${final.system}.default;
        sweetbyte = sweetbyte.packages.${final.system}.default;
        # swww = swww.packages.${final.system}.swww;
      };
    };
}
