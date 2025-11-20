# MY DOTFILES
While I myself use a modified version of these dotfiles, I still encourage you to explore and adapt them to your likings.

**DISCLAIMER**:These are my personal dotfiles for various text/code, shells and other tools tha I use or have used in the past. You're welcome to copy any parts of them, however do not blindly use my settings unless you know what they do. Proceed at your own risk!

## This Repository contains my configurations for...
- vim 
- emacs
- neovim
- powershell

## Installation
Use the installation scripts provided for each platform.

In linux use:
```bash
./install_linux.pl <manifest_file> [mapping_1] [mapping_2]
```

In windows use:
```ps1
./install_windows.ps1 <manifest_file> [mapping_1] [mapping_2]
```

The installation scripts will create by default soft symlinks to the dotfiles using the Manifest file you pass. Also you can pass specific mappings described in the Manifest file. If you want to move the dotfiles somewhere else, you need to delete the symlinks and re-run the scripts.

### Flags

To change the behaviour of the Installation scripts, the following flags are provided:

| Flag | Description |
|------|-------------|
|-u    | undo symlink from the manifest file|


### Manifest File Syntax

The manifest Syntax files supported are .xml, .json and .toml. The needed tags to be located by the parser:

- Symlinks
    - OS:  The OS name. (e.g. Windows for windows, Linux for linux)

