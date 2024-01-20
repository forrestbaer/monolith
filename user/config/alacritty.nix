{
  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
      window.dynamic_padding = true;
      window.padding.x = 10;
      window.padding.y = 10;
      env.TERM = "screen-256color";
      mouse = {
        hide_when_typing = true;
      };
      font = {
        size = 18;
      	builtin_box_drawing = true;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regluar";
	      };
        bold = {
          family = "Iosevka Nerd Font";
          style = "Regular";
	      };
        italic = {
          family = "Iosevka Nerd Font";
          style = "Italic";
        };
      };
      colors = {
        draw_bold_text_with_bright_colors = true;
        primary = {
          background = "#000000";
          foreground = "#A8A8A8";
	      };
        normal = {
          black = "#111111";
          red = "#A80000";
          green = "#00A800";
          yellow = "#936f39";
          blue = "#0219b0";
          magenta = "#AA00AA";
          cyan = "#00AAAA";
          white = "#A8A8A8";
	      };
        bright = {
          black = "#545454";
          red = "#f76375";
          green = "#4CE54C";
          yellow = "#FFFF55";
          blue = "#2970e3";
          magenta = "#EC60EC";
          cyan = "#55F7F7";
          white = "#FEFEFE";
	      };
      };
      scrolling.history = 50000;
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      cursor = {
        style = {
         shape = "Block";
         blinking = "On";
	      };
        blink_interval = 350;
      };
    };
  };
}
