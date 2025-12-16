{
  description = "anicli-es - CLI para ver anime en español";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      
      python = pkgs.python3.withPackages (ps: [
        ps.beautifulsoup4
        ps.requests
        ps.simple-term-menu
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          python
          pkgs.mpv
          pkgs.yt-dlp
        ];
      };
    };
}
