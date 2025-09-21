# Workstation-Setup

This project contains a series of configuration files for:
- bash
- gdb
- neovim
- tmux
- zsh

as well as a setup script that moves the configuration files to either $HOME or $HOME/.config/<software-name>, installs software depending on the os distribution (debian or kali), and install plugins for tmux and zsh.

## Software Installed

### All OS

- neovim
  - LazyVim
- wezterm (only desktops)
- 

### Windows

- 

### Linux

- zsh
  - OhMyZsh

### MacOS

- zsh
  - OhMyZsh

## Installation

Clone main branch into designated folder, change directory into the root of the project directory, run setup script:

(Windows/Linux - Nushell) use nushell to download and run the script:
```bash
http get https://raw.githubusercontent.com/haruvon/Workstation-Setup/refs/heads/main/script.nu | save script.nu; nu script.nu
```

(Windows/Linux - Powershell) use powershell to download and run the script:
```bash
powershell -Command "Invoke-WebRequest -Uri https://raw.githubusercontent.com/haruvon/Workstation-Setup/refs/heads/main/script.nu -OutFile script.nu" && nu script.nu
```

(Linux) Download from the internet and run:
```bash
wget -q https://raw.githubusercontent.com/haruvon/Workstation-Setup/refs/heads/main/script.nu -O script.nu && nu script.nu
```

(Linux) Clone the repository and run:
```bash
git clone https://github.com/HaruVON/Workstation-Setup.git
cd ./Workstation-Setup
./setup.sh

# Run in Debug mode
DEBUG=1 ./setup.sh
```
git clone https://github.com/HaruVON/Workstation-Setup.git
cd ./Workstation-Setup
./setup
```
