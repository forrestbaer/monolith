{
  programs.qutebrowser = {
    enable = true;
    extraConfig = ''
      config.bind("<Down>", "move-to-next-line", mode="caret")
      config.bind("<Left>", "move-to-prev-char", mode="caret")
      config.bind("<Right>", "move-to-prev-char", mode="caret")
      config.bind("<Up>", "move-to-prev-line", mode="caret")
      config.unbind("H", mode="caret")
      config.unbind("J", mode="caret")
      config.unbind("K", mode="caret")
      config.unbind("L", mode="caret")
      config.unbind("c", mode="caret")
      config.unbind("h", mode="caret")
      config.unbind("j", mode="caret")
      config.unbind("k", mode="caret")
      config.unbind("l", mode="caret")
      config.bind("[", "back", mode="normal")
      config.bind("[[", "navigate prev", mode="normal")
      config.bind("]", "forward", mode="normal")
      config.bind("]]", "navigate next", mode="normal")
      config.unbind("<Ctrl+PgDown>", mode="normal")
      config.unbind("<Ctrl+PgUp>", mode="normal")
      config.bind("<Ctrl+Shift+Tab>", "tab-prev", mode="normal")
      config.unbind("<Ctrl+Shift+t>", mode="normal")
      config.unbind("<Ctrl+Shift+w>", mode="normal")
      config.bind("<Ctrl+Tab>", "tab-next", mode="normal")
      config.unbind("<Ctrl+^>", mode="normal")
      config.unbind("<Ctrl+a>", mode="normal")
      config.unbind("<Ctrl+b>", mode="normal")
      config.unbind("<Ctrl+d>", mode="normal")
      config.unbind("<Ctrl+f>", mode="normal")
      config.unbind("<Ctrl+p>", mode="normal")
      config.unbind("<Ctrl+u>", mode="normal")
      config.unbind("<Ctrl+v>", mode="normal")
      config.unbind("<Ctrl+x>", mode="normal")
      config.bind("<Left>", "tab-move -", mode="normal")
      config.bind("<Right>", "tab-move +", mode="normal")
      config.unbind("D", mode="normal")
      config.unbind("H", mode="normal")
      config.unbind("J", mode="normal")
      config.unbind("K", mode="normal")
      config.unbind("L", mode="normal")
      config.unbind("gJ", mode="normal")
      config.unbind("gK", mode="normal")
      config.unbind("gm", mode="normal")
      config.unbind("h", mode="normal")
      config.unbind("j", mode="normal")
      config.unbind("k", mode="normal")
      config.unbind("l", mode="normal")
      config.unbind("q", mode="normal")
      config.unbind("th", mode="normal")
      config.unbind("tl", mode="normal")
      config.unbind("wf", mode="normal")
      config.unbind("wh", mode="normal")
      config.unbind("wl", mode="normal")
      config.bind("x", "tab-close", mode="normal")
    '';

    settings = {
      auto_save.session = true;
      colors.webpage.preferred_color_scheme = "dark";
      completion.height = "30%";
      confirm_quit = [ "multiple-tabs" "downloads" ];
      content.cookies.accept = "no-unknown-3rdparty";
      content.geolocation = false;
      content.notifications.enabled = false;
      content.pdfjs = true;
      content.prefers_reduced_motion = true;
      downloads.location.directory = "~/tmp";
      fonts.default_family = "Iosevka Term";
      fonts.default_size = "15px";
      fonts.hints = "default_size default_family";
      fonts.statusbar = "17px default_family";
      hints.radius = 1;
      input.insert_mode.auto_load = false;
      messages.timeout = 2000;
      statusbar.widgets = [
        "clock"
        "keypress"
        "search_match"
        "url"
        "scroll"
        "history"
        "tabs"
        "progress"
	];
      tabs.background = true;
      tabs.favicons.show = "never";
      tabs.indicator.width = 0;
      tabs.max_width = 200;
      tabs.mousewheel_switching = false;
      tabs.title.format = "{index} = {host}";
      zoom.default = 115;
    };
  };
}
