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
        ps.playwright
      ]);
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          python
          pkgs.mpv
          pkgs.yt-dlp
          pkgs.playwright-driver.browsers
        ];
        
        shellHook = ''
          export PLAYWRIGHT_BROWSERS_PATH=${pkgs.playwright-driver.browsers}
          export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true
        '';
      };
    };
}
