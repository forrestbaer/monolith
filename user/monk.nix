{ pkgs, ... }:

# rustup default stable - first boot
# neovim packer sync - first boot

{
  imports = [
    ./config/neovim.nix
    ./config/lsd.nix
    ./config/dconf.nix
    ./config/tmux.nix
    ./config/git.nix
    ./config/bash.nix
    ./config/alacritty.nix
    ./config/dircolors.nix
    ./config/qutebrowser.nix
  ];

  home.username = "monk";
  home.homeDirectory = "/home/monk";

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
  };

  home.packages = with pkgs; [
    gitui
    taskwarrior
    lsd
    qmk
    neofetch
    nix-bash-completions
    haskellPackages.tidal
    supercollider-with-sc3-plugins
    ocenaudio
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  home.sessionVariables = {
    PROMPT_COMMAND = "history -a";
    PROMPT_DIRTRIM = 2;
  };

  programs.direnv = {
    enable = true;
    # config = { };
  };

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
