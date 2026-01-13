{
  description = "dev environment";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          zola # static site builder

          (python313.withPackages (
            python-pkgs: with python-pkgs; [
              toml # converting json to toml
            ]
          ))

          # fonts
          pkgs.lmodern

          typst

          gnumake # eh
        ];

        # make font available for typst
        TYPST_FONT_PATHS = "${pkgs.lmodern}/share/fonts/";

        shellHook = ''
          echo "Run make serve or make build"
        '';
      };
    };
}
