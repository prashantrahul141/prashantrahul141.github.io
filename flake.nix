{
  description = "dev environment";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      tex = (
        pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-medium
            titlesec
            xcolor
            hyperref
            enumitem
            tex-gyre
            microtype
            ;
        }
      );
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          zola # static site builder

          yq # for toml, json conversion
          jq

          tex

          gnumake # eh
        ];

        shellHook = ''
          echo "Run make serve or make build"
        '';
      };
    };
}
