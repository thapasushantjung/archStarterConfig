# Arch Linux Development Setup: Walkthrough

This guide provides a detailed explanation of the `setup_arch.sh` script and how it configures your development environment.

## 1. Prerequisites
The script assumes you have an AUR helper installed. It specifically looks for `yay`. If you don't have it, you can install it via:
```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

## 2. Installation Phase
The script first installs a curated list of modern developer tools:
- **Editor**: `neovim` with full support for modern configurations.
- **Development Runtimes**: `nodejs`/`npm` (for LSPs), `python-pynvim`, `luarocks`, and `php`/`composer` (for Laravel/PHP).
- **Build Tools**: `base-devel`, `cmake`, `unzip`, and `tree-sitter` for plugin compilation and management.
- **Data & Clipboard**: `sqlite` (for database/storage plugins), `xclip`, and `wl-clipboard`.
- **Fonts**: `ttf-firacode-nerd` provides ligatures and the icons needed for Starship, Eza, and Neovim plugins.
- **VCS**: `lazygit` for terminal-based Git management.
- **Shell & Navigation**: `zsh-antidote`, `starship`, `zoxide`, and `fzf`.
- **Core Utilities**: `ripgrep` (search), `fd` (find), `bat` (view), and `eza` (list).
- **Productivity**: `lazydocker` (Docker UI), `tmux` (multiplexer), and `dbeaver` (Database GUI).

## 3. Zsh Configuration (Antidote)
The script creates `~/.zsh_plugins.txt` and populates it with:
- **Autosuggestions**: Fish-like suggestions based on history.
- **Completions**: Enhanced tab-completion for many commands.
- **Syntax Highlighting**: Real-time coloring of commands as you type.

It then injects the `antidote load` command into your `~/.zshrc`.

## 4. NPM Global Configuration
The script configures `npm` to install global packages in `~/.npm-global` to avoid using `sudo`. It also adds `~/.npm-global/bin` to your `$PATH` in `~/.zshrc`.

## 5. Starship Prompt
The script applies the **Pastel Powerline** preset:
```bash
starship preset pastel-powerline -o ~/.config/starship.toml
```
This gives you a beautiful, informative, and high-performance prompt.

## 6. FZF, FD, and BAT Integration
This is the "Power User" configuration.
- **`fd`** is set as the default engine for FZF, making it respect your `.gitignore` and find files instantly.
- **`bat`** is used as a previewer, so when you scroll through results in FZF, you see a syntax-highlighted preview of the file content on the right.

## 7. User Aliases
The script adds several quality-of-life aliases to your `.zshrc`:
- `ls` & `ll`: Maps to `eza` for icons and better formatting.
- `cat`: Maps to `bat` for highlighted file viewing.
- `docker-ui`: Maps to `lazydocker`.


## 8. Usage

Run the setup script:
```bash
./setup_arch.sh
```
After installation, restart your shell or run `source ~/.zshrc`.

If you aren't already using Zsh, you can change your default shell with:
```bash
chsh -s $(which zsh)
```

## Troubleshooting
- **Icons not showing?** Ensure your terminal emulator (e.g., Alacritty, Kitty, or Konsole) is configured to use `FiraCode Nerd Font`.
- **Command not found?** Ensure `/usr/bin` is in your `$PATH` and that the `yay` installation completed without errors.
