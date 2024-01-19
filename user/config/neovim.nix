{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

vim.api.nvim_create_user_command(
  "Columnize",
  "<line1>,<line2>!column -t",
  { range = "%" }
)

local check_package = function(package)
  local status_ok, pkg = pcall(require, package)
  if not status_ok then
    return nil
  end
  return pkg
end

local packer = check_package('packer')
if (packer) then
  packer.init {
    display = {
      open_fn = function()
        return require('packer.util').float { border = 'rounded' }
      end,
    },
  }

  require('packer').startup({ function(use)
    use {
      'junegunn/fzf.vim',
      cmd = { 'fzf#install()' }
    }
    use 'wbthomason/packer.nvim'
    use 'forrestbaer/minimal_dark'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-tree/nvim-web-devicons'
    use 'svermeulen/vim-easyclip'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-commentary'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lualine/lualine.nvim'
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'jamessan/vim-gnupg'
    use({
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup()
    end,
    })
    use {
      'nvim-telescope/telescope.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    }
    use 'tidalcycles/vim-tidal'
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end })
else
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
    }
    print 'Packer added close and reopen Neovim... run PackerSync'
    vim.cmd [[packadd packer.nvim]]
  end
end

local oil = check_package('oil')
if oil then
  oil.setup()
end

local ok, _ = pcall(vim.cmd, 'colorscheme minimal_dark')
if not ok then
  return
end

vim.opt.guifont        = "Iosevka Nerd Font:h16"
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

local lsp_servers = {"lua_ls","tsserver","html","bashls","eslint","jsonls","emmet_ls","pylsp","nil_ls"}

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

local treesitter = check_package("nvim-treesitter")
if (treesitter) then
  treesitter.setup {}

  require("nvim-treesitter.configs").setup {
    ensure_installed = { "vim", "python", "c", "cpp", "regex", "javascript", "lua", "typescript", "html", "vimdoc" },
    highlight = { enable = true, },
    indent = { enable = true, },
  }
else
  vim.cmd("lua TSUpdate")
end

local telescope = check_package("telescope")
if (telescope) then
  local actions = require("telescope.actions")
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

map("", "<leader>i", ":lua vim.lsp.buf.hover()<cr>")
map("", "<leader>I", ":lua vim.lsp.buf.type_definition()<cr>")
map("", "<leader>gd", ":lua vim.lsp.buf.definition()<cr>")
map("", "<leader>gD", ":lua vim.lsp.buf.declaration()<cr>")
map("", "<leader>d", ":lua vim.diagnostic.open_float()<cr>")

map("", "<Space>", ":silent noh<Bar>echo<cr>")
map("n", "U", "<C-r>")
map("n", "<leader>q", ":q!<cr>")
map("n", "<leader>s", ":w!<cr>")
map("n", "<leader>n", ":ene<cr>")
map("n", "<leader>x", ":bd<cr>")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("", "<C-w>", "<C-W>W")
map("t", "<C-z>", "<C-\\><C-n>")
map("n", "<C-z>", "<C-w>W")
map("i", "<C-z>", "<C-w>W")

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
}
