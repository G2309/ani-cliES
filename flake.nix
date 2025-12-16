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
      
      anicli-es = pkgs.stdenv.mkDerivation {
        pname = "anicli-es";
        version = "1.0.0";
        src = ./.;
        
        nativeBuildInputs = [ pkgs.makeWrapper ];
        
        installPhase = ''
          mkdir -p $out/bin
          cp anicli-es $out/bin/anicli-es
          chmod +x $out/bin/anicli-es
          
          wrapProgram $out/bin/anicli-es \
            --prefix PATH : ${pkgs.lib.makeBinPath [ python pkgs.mpv pkgs.yt-dlp ]} \
            --set PLAYWRIGHT_BROWSERS_PATH ${pkgs.playwright-driver.browsers} \
            --set PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS true
        '';
      };
    in
    {
      packages.${system} = {
        default = anicli-es;
        anicli-es = anicli-es;
      };
      
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
