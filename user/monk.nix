{ pkgs, ... }:

# neovim packer sync - first boot
# cabal update; cabal install tidal --lib

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
      delta
      deno
      ghc
      gimp
      gitui
      haskellPackages.tidal
      imv
      inkscape-with-extensions
      just
      kicad
      krita
      lsd
      micromamba
      nix-bash-completions
      obs-studio
      obs-cli
      ocenaudio
      opencv
      pass-wayland
      qbittorrent
      qjackctl
      qmk
      qpwgraph
      qutebrowser
      supercollider-with-sc3-plugins
      taskwarrior
      tmux-mem-cpu-load
      zlib-ng
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
