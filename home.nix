{ config, pkgs, ... }:

{
  home.username = "monk";
  home.homeDirectory = "/home/monk";

  home.packages = with pkgs; [
    lsd
    neofetch
    nix-bash-completions
  ];

  home.sessionVariables = {
    PROMPT_COMMAND = "history -a";
    PROMPT_DIRTRIM = 2;
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraLuaConfig = ''
      --
      -- helper functions
      --
      local check_package = function(package)
        local status_ok, pkg = pcall(require, package)
        if not status_ok then
          return nil
        end
        return pkg
      end
      
      -- Create a keymap with some sane defaults.
      local map = function(mode, lhs, rhs, opts)
        local options = { noremap = true, silent = true }
        if opts then options = vim.tbl_extend("force", options, opts) end
        vim.keymap.set(mode, lhs, rhs, options)
      end
      
      -- Columnize content
      vim.api.nvim_create_user_command(
        "Columnize",
        "<line1>,<line2>!column -t",
        { range = "%" }
      )
      
      
      --
      -- packer/plugins
      --
      local packer = check_package("packer")
      if (packer) then
        packer.init {
          display = {
            open_fn = function()
              return require("packer.util").float { border = "rounded" }
            end,
          },
        }
      
        require("packer").startup({ function(use)
          use {
            "junegunn/fzf.vim",
            cmd = { "fzf#install()" }
          }
          use "wbthomason/packer.nvim"
          use "forrestbaer/minimal_dark"
          use "nvim-lua/plenary.nvim"
          use "nvim-tree/nvim-web-devicons"
          use "svermeulen/vim-easyclip"
          use "tpope/vim-surround"
          use "tpope/vim-repeat"
          use "tpope/vim-commentary"
          use "nvim-treesitter/nvim-treesitter"
          use "nvim-lualine/lualine.nvim"
          use "neovim/nvim-lspconfig"
          use "williamboman/mason.nvim"
          use "williamboman/mason-lspconfig.nvim"
          use "jamessan/vim-gnupg"
          use({
          "stevearc/oil.nvim",
          config = function()
            require("oil").setup()
          end,
          })
          use {
            "nvim-telescope/telescope.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
          }
          use "tidalcycles/vim-tidal"
          if PACKER_BOOTSTRAP then
            require("packer").sync()
          end
        end })
      end
      
      
      --
      -- initialize colorscheme
      --
      local ok, _ = pcall(vim.cmd, "colorscheme minimal_dark")
      if not ok then
        return
      end
      
      
      --
      -- options
      --
      vim.opt.guifont        = "Iosevka Term:h18"
      vim.opt.termguicolors  = true
      vim.opt.fileencoding   = "utf-8"
      vim.opt.backspace      = "indent,eol,start"
      vim.opt.tabstop        = 2
      vim.opt.shiftwidth     = 2
      vim.opt.expandtab      = true
      vim.opt.showmatch      = true
      vim.opt.signcolumn     = "yes"
      vim.opt.number         = true
      vim.opt.numberwidth    = 3
      vim.opt.hidden         = true
      vim.opt.mouse          = ""
      vim.opt.autoread       = true
      vim.opt.pumheight      = 20
      vim.opt.ignorecase     = true
      vim.opt.smartcase      = true
      vim.opt.remap          = true
      vim.opt.wrap           = false
      vim.opt.timeout        = false
      vim.opt.guicursor      = "i:ver20-blinkon100,n:blinkon100"
      vim.opt.linebreak      = true
      vim.opt.scrolloff      = 4
      vim.opt.backup         = false
      vim.opt.splitbelow     = true
      vim.opt.grepprg        = "rg"
      vim.opt.updatetime     = 150
      vim.opt.undofile       = true
      vim.opt.undodir        = "/home/monk/tmp/nvim"
      vim.opt.undolevels     = 2000
      vim.opt.helpheight     = 15
      vim.opt.completeopt    = "menuone,noselect,noinsert"
      vim.opt.omnifunc       = "syntaxcomplete#Complete"
      
      vim.g.mapleader                        = ","
      vim.g.maplocalleader                   = ","
      vim.g.loaded_netrw                     = 1
      vim.g.loaded_netrwPlugin               = 1
      
      vim.g.tidal_target                     = "tmux"
      vim.g.tidal_default_config             = {socket_name = "default", target_pane = ":1.1"}
      
      vim.opt.clipboard      =  "unnamedplus"
      
      --
      -- devicons
      --
      local devicons = check_package("nvim-web-devicons")
      if (devicons) then
        devicons.setup {
          color_icons = true,
          default = true
        }
      end
      
      
      --
      -- lsp / mason
      --
      local lsp_servers = {"lua_ls","tsserver","zls","html","bashls","eslint","jsonls","emmet_ls","pylsp"}
      
      local mason = check_package("mason")
      if (mason) then
        mason.setup {}
        require("mason-lspconfig").setup {
          ensure_installed = lsp_servers
        }
      end
      
      local lspconfig = check_package("lspconfig")
      if (lspconfig) then
        for _, lsp in ipairs(lsp_servers) do
          lspconfig[lsp].setup {}
        end
      
        lspconfig.lua_ls.setup {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = {"vim"} },
              telemetry = { enable = false },
            }
          },
        }
      end
      
      --
      ---- treesitter
      --
      local treesitter = check_package("nvim-treesitter")
      if (treesitter) then
        treesitter.setup {}
      
        require("nvim-treesitter.configs").setup {
          ensure_installed = { "vim", "python", "c", "cpp", "regex", "javascript", "lua", "typescript", "html", "vimdoc" },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "gnn",
              node_incremental = "grn",
              scope_incremental = "grc",
              node_decremental = "grm",
            },
          },
          highlight = {
            enable = true,
          },
          indent = {
            enable = true,
          },
        }
      else
        vim.cmd("lua TSUpdate")
      end
      
      --
      -- telescope stuff
      --
      local telescope = check_package("telescope")
      if (telescope) then
        local actions = require("telescope.actions")
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.setup {
          defaults = {
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            file_ignore_patterns = {
              "node_modules",
              "vendor",
              "__tests__",
              "__snapshots__",
            },
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.4,
              width = 0.8,
              height = 0.9,
            },
            mappings = {
              i = {
                ["<esc>"] = actions.close,
                ["<C-i>"] = actions.preview_scrolling_up,
                ["<C-e>"] = actions.preview_scrolling_down,
              },
            },
            pickers = {
              find_files = {
                follow = true,
                hidden = true,
              },
            },
            extensions = {
              file_browser = {
                mappings = {
                  i = {
                    ["<esc>"] = actions.close,
                  },
                },
              },
            },
          },
        }
      end
      
      
      ---
      --- lualine
      ---
      local lualine = check_package("lualine")
      if (lualine) then
        lualine.setup {
          options = {
            icons_enabled = true,
            fmt = string.lower,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            always_divide_middle = true,
            color = {
              fg = "#CCCCCC",
              bg = "#222222"
            }
          },
          sections = {
            lualine_a = {
              { "mode",
                color = function (section)
                  local mode = vim.api.nvim_get_mode().mode
                  local fgc = "#000000"
      
                  if (mode == "n") then
                    if (vim.bo.modified) then
                      return { fg = fgc, bg = "#008834" }
                    else
                      return { fg = fgc, bg = "#00AF87" }
                    end
                  elseif (mode == "v") then
                    return { fg = fgc, bg = "#EEEEEE" }
                  elseif (mode == "i") then
                    return { fg = fgc, bg = "#A0A0A0" }
                  end
      
                end}
            },
            lualine_b = {
              {
                "filename",
                file_status = true,
                newfile_status = true,
                path = 4,
                shorting_target = 40,
                symbols = {
                  modified = "*",
                  readonly = "-",
                  unnamed = "[No Name]",
                  newfile = "[New]",
                },
                color = { fg = "#999999" }
              },
              { "diff", colored = false},
            },
            lualine_c = {
              { "diagnostics",
                sources = { "nvim_diagnostic", "nvim_lsp" },
                colored = true,
                padding = 1,
                sections = { "error", "warn", "info" },
                color = { fg = "#CCCCCC", bg = "#000" }
              },
            },
            lualine_x = {
              { "encoding"},
              { "filetype", colored = true, color = { bg = "#222222" } }
            },
            lualine_y = {
              { "progress", "location", color = { fg = "#FFFFFF" } }
            },
            lualine_z = { {
              "location",
              color = { fg = "#000000", bg = "#009933" }
            }
            }
          },
        }
      end
      
      
      --
      -- key mappings
      --
      
      -- misc
      map("", "<leader>D", ":put =strftime('### %A %Y-%m-%d %H:%M:%S')<CR>")
      
      -- lsp
      map("", "<leader>i", ":lua vim.lsp.buf.hover()<cr>")
      map("", "<leader>I", ":lua vim.lsp.buf.type_definition()<cr>")
      map("", "<leader>gd", ":lua vim.lsp.buf.definition()<cr>")
      map("", "<leader>gD", ":lua vim.lsp.buf.declaration()<cr>")
      map("", "<leader>d", ":lua vim.diagnostic.open_float()<cr>")
      
      -- telescope
      map("", "<leader>ff", ":Telescope find_files<cr>")
      map("", "<leader>fg", ":Telescope live_grep<cr>")
      map("", "<leader>ft", ":Telescope file_browser<cr>")
      map("", "<leader>fb", ":Telescope buffers<cr>")
      map("", "<leader>fh", ":Telescope help_tags<cr>")
      map("", "<leader>fd", ":Telescope diagnostics<cr>")
      
      -- vim
      map("", "<Space>", ":silent noh<Bar>echo<cr>")
      map("n", "U", "<C-r>")
      map("n", "<leader>q", ":q!<cr>")
      map("n", "<leader>s", ":w!<cr>")
      map("n", "<leader>n", ":ene<cr>")
      map("n", "<leader>x", ":bd<cr>")
      map("", "<c-o>", ":<cr>")
      map("", "<c-n>", ":<cr>")
      map("n", "<leader>ev", ":cd ~/code/dotfiles/config/nvim | e init.lua<cr>")
      map("n", "<leader>rv", ":so ~/code/dotfiles/config/nvim/init.lua<cr>")
      
      map("v", "<", "<gv")
      map("v", ">", ">gv")
      
      map("", "<C-w>", "<C-W>W")
      map("t", "<C-z>", "<C-\\><C-n>")
      map("n", "<C-z>", "<C-w>W")
      map("i", "<C-z>", "<C-w>W")
      
      
      --
      -- autocmds
      --
      vim.api.nvim_create_autocmd("TextYankPost", {
        command = "silent! lua vim.highlight.on_yank()",
      })
      
      vim.api.nvim_create_autocmd("FocusGained", {
        command = [[:checktime]]
      })
      
      vim.api.nvim_create_autocmd("BufEnter", {
        command = [[set formatoptions-=cro]]
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown", command = "set awa"
      })
    '';
  };

  programs.lsd = {
    enable = true;
    settings = {
      blocks = [ "user" "permission" "date" "size" "name" ];
      color.theme = "custom";
      date = "+%D";
      icons.when = "auto";
      icons.theme = "fancy";
      icons.separator = " ";
      indicators = true;
      permission = "octal";
      total-size = true;
      sorting.dir-grouping = "first";
    };
    colors = {
      user = 238;
      group = 238;
      permission = {
        read = 248;
        write = 248;
        exec = 248;
        exec-sticky = 248;
        no-access = 248;
        octal = 248;
        acl = 248;
        context = 248;
      };
      date = {
        hour-old = 248;
        day-old = 240;
        older = 234;
      };
      size = {
        none = 6;
        small = 6;
        medium = 6;
        large = 6;
      };
      inode = {
        valid = 13;
        invalid = 245;
      };
      links = {
        valid = 13;
        invalid = 245;
      };
      tree-edge = 245;
      git-status = {
        default = 245;
        unmodified = 245;
        ignored = 245;
        new-in-index = "dark_green";
        new-in-workdir = "dark_green";
        typechange = "dark_yellow";
        deleted = "dark_red";
        renamed = "dark_green";
        modified = "dark_yellow";
        conflicted = "dark_red";
      };
    };
  };


  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "alacritty.desktop"
        "qutebrowser.desktop"
        "supercollider.desktop"
      ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Control>w"];
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


  programs.git = {
    enable = true;
    userName = "Forrest Baer";
    userEmail = "forrest@forrestbaer.com";

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      navigate = true;
      side-by-side = true;
    };

    extraConfig = {
      core.autocrlf = false;
      merge.conflictstyle = "diff3";
      mergetool = {
        keepBackup = false;
        prompt = false;
      };
      push.autoSetupRemote = true;
      credential."https://github.com" = {
	helper = "!gh auth git-credential";
	autoSetupRemote = true;
      };
    };
  };


  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "none";
      window.dynamic_padding = true;
      window.padding.x = 10;
      window.padding.y = 10;
      env.TERM = "screen-256color";
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
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PS1="$? [\[\e[0;97m\]\w\[\e[0m\]] \[\e[0;90m\]\$ \[\e[0m\]"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      set -o noclobber
      set -o vi

      bind "set completion-ignore-case on"
      bind "set completion-map-case on"
      bind "set show-all-if-ambiguous on"
      bind "set mark-symlinked-directories on"
      '';
    historyControl = [ "erasedups" ];
    historyIgnore = ["[ ]*" "exit" "ls" "bg" "fg" "history" "clear"];
    shellAliases = {
      less = "less -RX";
      ls = "lsd";
      lsa = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
      mv = "mv -i";
      md = "mkdir -p";
      more = "less";
      sudo = "sudo ";
      vi = "nvim";
      vim = "nvim";
      t = "task";
      gs = "git status";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gf = "git fetch";
      ga = "git add";
    };
    shellOptions = [
      "histappend"
      "cmdhist"
      "nocaseglob"
      "checkwinsize"
      "autocd"
      "dirspell"
      "cdspell"
    ];
  };

  programs.dircolors = {
    enable = true;
    settings = { 
      COLOR = "all";
      TERM = "xterm*";
      NORMAL = "00";
      RESET = "0";
      FILE = "01;37";
      DIR = "33";
      LINK = "97";
      MULTIHARDLINK = "97";
      FIFO = "30;100";
      SOCK = "30;100";
      DOOR = "30;100";
      BLK = "30;100";
      CHR = "30;100";
      ORPHAN = "31";
      MISSING = "01;37;41";
      EXEC = "32";
      SETUID = "01;04;37;";
      SETGID = "01;04;37;";
      CAPABILITY = "01;37";
    };
  };

  programs.direnv = {
    enable = true;
    # config = { };
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
        set -g default-terminal "screen-256color"
	bind c new-window -c "#{pane_current_path}"
	bind r source-file ~/.tmux.conf \; display "Config reloaded"
	bind n select-pane -L
	bind o select-pane -R
	bind e select-pane -D
	bind i select-pane -U
	bind d detach-client
	bind x kill-pane
	bind | split-window -h
	bind - split-window -v
	set -g set-clipboard external
	set -s set-clipboard off
	set -s copy-command "wl-copy --type text/plain"
	
	set-option -g history-limit 50000
	set-option -g escape-time 0
	set-option -g status-interval 1
	
	set-option -g visual-activity on
	set-window-option -g monitor-activity on
	
	set-window-option -g mode-keys vi
	set-option -g status-keys vi
	set-option -g bell-action none
	set-option -g focus-events on
	
	set-option -g pane-border-style bg=colour0
	set-option -g pane-border-style fg=colour8
	set-option -g pane-active-border-style bg=colour0
	set-option -g pane-active-border-style fg=colour8

	set-option -g default-terminal "screen-256color"
	set-option -ga terminal-overrides ",screen-256color:Tc"
	set-option -sa terminal-overrides ",screen-256color:RGB"
	
	set-option -g status-position bottom
	set-option -g status-bg colour234
	set-option -g status-fg colour137
	set-option -g status-right-length 240
	set-option -g status-left-length 40
	set-option -g status-left "#[fg=colour233,bg=colour234]#[fg=colour137,bg=colour234]"
	set-option -g status-right "#[fg=colour243] #[fg=colour245,bg=colour234]"
	set-option -ag status-right "#[fg=colour233,bg=colour241]#(tmux-mem-cpu-load --averages-count 0) #[fg=colour233,bg=colour245]  %r #[fg=colour233,bg=colour245] "
	
	set-window-option -g window-status-current-style fg=colour81
	set-window-option -g window-status-current-style bg=colour238
	set-window-option -g window-status-current-style bold
	set-window-option -g window-status-current-format " #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "
	
	set-window-option -g window-status-style fg=colour135
	set-window-option -g window-status-style bg=colour235
	set-window-option -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "
	
	set-option -g message-style bold
	set-option -g message-style fg=colour232
	set-option -g message-style bg=colour238
	
	set-window-option -g window-status-activity-style bg=black
	set-window-option -g window-status-activity-style fg=green
    '';
    prefix = "C-a";
    terminal = "screen-256color";
  };

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

  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
