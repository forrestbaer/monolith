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
    alacritty
    bash
    binutils
    clang
    clang-tools
    cmake
    cool-retro-term
    coreutils
    fd
    fzf
    gawk
    gcc
    gh
    git
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.tiling-assistant
    gnome.gnome-tweaks
    gnupg
    gnused
    gnutar
    jq
    lua
    luajit
    lsusb
    neovim
    nodePackages.typescript
    nodePackages.typescript-language-server
    python311Full
    python311Packages.pynvim
    python311Packages.opencv4
    python311Packages.numpy
    nodejs
    gnumake
    ripgrep
    tmux
    tree-sitter
    unrar
    unzip
    vim
    w3m
    waylock
    wget
    which
    wl-clipboard
    zip
  ];
  environment.variables.EDITOR = "nvim";

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
    ];
  };

  hardware.pulseaudio.enable = false;
  hardware.keyboard.qmk.enable = true;

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
    udev = {
      extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"
      '';
    };
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
