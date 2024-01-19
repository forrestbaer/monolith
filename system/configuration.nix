{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    alacritty bash binutils btop cabal-install cargo clang cmake conda
    cool-retro-term coreutils curl delta ethtool fd fzf gawk gcc gh ghc
    git glow gnome.gnome-tweaks gnupg gnused gnutar go iftop iotop jq julia just
    lm_sensors lsof ltrace lua luajit luarocks mtr neovim ninja nix-output-monitor
    nodejs openjdk pass-wayland pciutils php python3Full qjackctl qpwgraph
    qutebrowser ripgrep ruby rustup strace sysstat tmux tmux-mem-cpu-load
    tree-sitter unrar unzip usbutils vimPlugins.vim-nix wget which
    wl-clipboard zig zip zstd
  ];
  environment.variables.EDITOR = "nvim";

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
    ];
  };

  hardware.pulseaudio.enable = false;

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  networking = {
    hostName = "monolith";
    networkmanager.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    fzf.keybindings = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    mtr.enable = true;
  };

  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      layout = "us";
      displayManager = {
        gdm.enable = true;
        autoLogin.enable = true;
        autoLogin.user = "monk";
      };
      desktopManager.gnome.enable = true;
      xkbVariant = "";
    };
  };

  security.rtkit.enable = true;

  sound.enable = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
    stateVersion = "23.11"; # don't touch
  };

  systemd = {
    services = {
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };

  time.timeZone = "America/Chicago";

  users.users.monk = {
    isNormalUser = true;
    description = "monk";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };
}
