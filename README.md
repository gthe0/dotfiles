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
./install.sh <manifest_file> [mapping_1 mapping_2 ...]
```
On other platforms and/or


### Flags

To change the behaviour of the Installation scripts, the following flags are provided:

| Flag | Description |
|------|-------------|
|-u    | undo symlink from the manifest file|


### Manifest File Syntax

I wanted something very very simple and easy to parse for the configuration installer. The extension stoml is derived from Simple TOML. The only things that are permited are:
 - Simple tags e.g. \[Linux\]
 - The comments can be started only from the start of the line
 - Keys and Values are both Strings
