{ pkgs, ... }:

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

  home = {
    username = "monk";
    homeDirectory = "/home/monk";
    packages = with pkgs; [
      bun
      cabal-install
      cool-retro-term
      delta
      deno
      ghc
      gitui
      haskellPackages.tidal
      just
      lsd
      nix-bash-completions
      ocenaudio
      opencv
      pass-wayland
      qjackctl
      qmk
      qpwgraph
      qutebrowser
      supercollider-with-sc3-plugins
      taskwarrior
      tmux-mem-cpu-load
    ];
    sessionVariables = {
      PROMPT_COMMAND = "history -a";
      PROMPT_DIRTRIM = 2;
    };
    stateVersion = "23.11"; # don't touch
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = false;
  };

  programs.home-manager.enable = true;
}
