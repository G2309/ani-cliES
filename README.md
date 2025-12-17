# anicli-es

CLI para ver anime en español desde la terminal.

## Dependencias

- Python 3.8+
- mpv
- yt-dlp
- Librerías Python: beautifulsoup4, requests, simple-term-menu, playwright

## Instalacion

### Arch Linux
```bash
sudo pacman -S python mpv yt-dlp python-pip
pip install --user beautifulsoup4 requests simple-term-menu playwright
playwright install chromium

git clone https://github.com/G2309/ani-cliES.git
cd ani-cliES
chmod +x anicli-es
./anicli-es
```

### Debian/Ubuntu
```bash
sudo apt update
sudo apt install python3 python3-pip mpv
pip3 install --user beautifulsoup4 requests simple-term-menu playwright yt-dlp
playwright install chromium
sudo playwright install-deps

git clone https://github.com/G2309/ani-cliES.git
cd ani-cliES
chmod +x anicli-es
./anicli-es
```

### NixOS / Nix

Opcion 1 - Ejecutar directamente:
```bash
nix run github:G2309/ani-cliES
```

Opcion 2 - Shell temporal:
```bash
nix develop github:G2309/ani-cliES
./anicli-es
```

Opcion 3 - Instalar en sistema (flake):
```nix
# flake.nix
inputs.anicli-es.url = "github:G2309/ani-cliES";

# En configuration.nix o home.nix
environment.systemPackages = [ inputs.anicli-es.packages.x86_64-linux.default ];
```

## Uso
```bash
./anicli-es
```

Busca anime, selecciona episodio y reproduce con mpv.

## Notas

- Requiere conexion a internet
- Primera ejecucion descarga navegador para playwright (~150MB)
