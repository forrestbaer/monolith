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
      toggle-fullscreen = ["<Control><Super>e"];
      toggle-maximized = ["<Control><Super>i"];
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = 15;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/settings-daemon/plugins/power" ={ 
      sleep-inactive-ac-type = "nothing";
    };
  };
}
