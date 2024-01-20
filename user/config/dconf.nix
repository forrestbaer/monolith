{
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "alacritty.desktop"
        "qutebrowser.desktop"
        "supercollider.desktop"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Control>q"];
      toggle-fullscreen = ["<Control><Super>u"];
      # toggle-maximized = ["<Control><Super>i"];
      switch-input-source = [];
      switch-input-source-backward = [];
      show-desktop = [];
      panel-run-dialog = [];
      switch-windows = [];
      switch-windows-backward = [];
      switch-applications = ["<Super><Shift>Tab"];
      switch-applications-backward = ["<Super>Tab"];
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = 15;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/settings-daemon/plugins/media-keys/screensaver" = {
      sleep-inactive-ac-type = "nothing";
    };
    "org/gnome/mutter/keybindings" = {
      # toggle-tiled-left = ["<Control><Super>n"];
      # toggle-tiled-right = ["<Control><Super>o"];
    };
    "org/gnome/shell/keybindings" = {
      focus-active-notification = [];
      toggle-message-tray = [];
    };
  };
}
