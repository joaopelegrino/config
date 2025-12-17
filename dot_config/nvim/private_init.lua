-- ~/.config/nvim/init.lua
-- Configuracao Neovim para Ubuntu 24.04 - Sistema AGENT
-- Versao: 2.0.0 | Data: 2025-12-15
-- Melhorias: Clojure/Lisp otimizado

-- ============================================================================
-- OPCOES BASICAS
-- ============================================================================

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"  -- Separado para Conjure (Clojure REPL)

-- Interface
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Indentacao
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Busca
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Comportamento
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

-- Scroll
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- ============================================================================
-- BOOTSTRAP LAZY.NVIM
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- PLUGINS
-- ============================================================================

require("lazy").setup({
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          treesitter = true,
          telescope = true,
          mason = true,
          cmp = true,
          gitsigns = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "catppuccin",
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },

  -- Bufferline (tabs visuais para buffers)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          show_buffer_close_icons = true,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              separator = true,
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
      { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
      { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
      { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
      { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
      { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
      { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "Pick buffer to close" },
      { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "markdown", "markdown_inline",
          "clojure", "json", "yaml", "toml", "bash", "python",
          "javascript", "typescript", "html", "css",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/", "target/" },
          hidden = true,  -- Mostrar arquivos/pastas ocultos (.claude/, etc)
        },
      })
    end,
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<C-f>", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    },
  },

  -- LSP (usando nova API vim.lsp.config do Neovim 0.11)
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "clojure_lsp",
          "pyright",
        },
      })

      -- Usar nova API vim.lsp.config (Neovim 0.11+)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Lua Language Server
      vim.lsp.config.lua_ls = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      }

      -- Clojure LSP
      vim.lsp.config.clojure_lsp = {
        cmd = { "clojure-lsp" },
        filetypes = { "clojure", "edn" },
        root_markers = { "project.clj", "deps.edn", "build.boot", "shadow-cljs.edn", ".git" },
        capabilities = capabilities,
      }

      -- Pyright (Python)
      vim.lsp.config.pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      }

      -- Habilitar LSPs
      vim.lsp.enable({ "lua_ls", "clojure_lsp", "pyright" })

      -- LSP Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        end,
      })
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "conjure" },   -- Completions do REPL (prioridade)
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
      })
    end,
  },

  -- Editing
  {
    "numToStr/Comment.nvim",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = { dotfiles = false },
      })
    end,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup()

      -- Grupos para Clojure (apenas em buffers Lisp)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "clojure", "fennel", "lisp", "scheme" },
        callback = function()
          wk.add({
            { "<localleader>", group = "Conjure" },
            { "<localleader>e", group = "eval" },
            { "<localleader>l", group = "log" },
            { "<localleader>t", group = "test" },
            { "<localleader>r", group = "repl" },
            { "<localleader>c", group = "connect" },
            { "<localleader>g", group = "go-to" },
          })
        end,
      })
    end,
  },

  -- ============================================================================
  -- CLOJURE/LISP
  -- ============================================================================

  -- Conjure (Clojure REPL) - Otimizado
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "racket", "scheme", "lisp" },
    init = function()
      -- HUD (janela flutuante com resultados)
      vim.g["conjure#log#hud#enabled"] = true
      vim.g["conjure#log#hud#width"] = 0.42
      vim.g["conjure#log#hud#height"] = 0.38
      vim.g["conjure#log#hud#anchor"] = "SE"

      -- Highlight de expressao avaliada
      vim.g["conjure#highlight#enabled"] = true
      vim.g["conjure#highlight#timeout"] = 500

      -- Prefixo de keymaps
      vim.g["conjure#mapping#prefix"] = "<localleader>"

      -- Log buffer
      vim.g["conjure#log#wrap"] = true
      vim.g["conjure#log#trim#at"] = 10000
      vim.g["conjure#log#trim#to"] = 5000
    end,
    dependencies = { "PaterJason/cmp-conjure" },
  },

  -- Paredit (S-expressions)
  {
    "julienvincent/nvim-paredit",
    ft = { "clojure", "fennel", "lisp", "scheme" },
    config = function()
      require("nvim-paredit").setup()
    end,
  },

  -- Rainbow Delimiters (parenteses coloridos)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufRead",
    config = function()
      local rainbow = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow.strategy["global"],
          clojure = rainbow.strategy["local"],
          fennel = rainbow.strategy["local"],
          lisp = rainbow.strategy["local"],
          scheme = rainbow.strategy["local"],
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- Parinfer (indentacao inteligente) - DESABILITADO: conflita com paredit
  -- FIX: Mantido apenas Paredit para evitar comportamento imprevisivel
  -- {
  --   "gpanders/nvim-parinfer",
  --   ft = { "clojure", "fennel", "lisp", "scheme", "racket" },
  --   init = function()
  --     vim.g.parinfer_mode = "smart"
  --   end,
  -- },

  -- tsin.nvim (Plugin local - Sistema AGENT SSOT v3.1)
  {
    dir = "~/tsin.nvim",  -- FIX: path correto do repositorio
    name = "tsin",
    ft = { "markdown", "text" },
    config = function()
      local ok, tsin = pcall(require, "tsin")
      if ok and tsin.setup then
        tsin.setup({
          -- Estrutura SSOT v3.1
          agent = {
            root = "",  -- Raiz do projeto (paths relativos)
            textos_base = "textos-base",
            contextos = {
              root = "contextos",
              variaveis = "variaveis",
              globais = "globais",
              projetos = "projetos",
              conceituais = "conceituais",  -- legado
            },
            relatorios = "historico/relatorios",
          },
          -- Keymaps com prefixo ,t
          keymaps = {
            enabled = true,
            prefix = "<leader>t",
          },
        })
      end
    end,
  },
}, {
  -- Lazy.nvim options
  checker = { enabled = false },
  change_detection = { notify = false },
})

-- ============================================================================
-- KEYMAPS GERAIS
-- ============================================================================

local keymap = vim.keymap.set

-- Salvar
keymap("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
keymap("n", "<leader>x", "<cmd>x<cr>", { desc = "Save and quit" })

-- Navegacao entre janelas
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows
keymap("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Buffers
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
keymap("n", "<C-b>", "<cmd>Telescope buffers<cr>", { desc = "List buffers (Telescope)" })
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "List buffers" })
keymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
keymap("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })
keymap("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
keymap("n", "<leader>ba", "<cmd>bufdo bd<cr>", { desc = "Close all buffers" })

-- Limpar highlight de busca
keymap("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Mover linhas
keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
keymap("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- Manter cursor centralizado
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap("n", "n", "nzzzv", { desc = "Next search result" })
keymap("n", "N", "Nzzzv", { desc = "Previous search result" })

-- Terminal (FIX: <leader>T para evitar conflito com tsin <leader>t)
keymap("n", "<leader>Tt", "<cmd>terminal<cr>", { desc = "Open terminal" })
keymap("n", "<leader>Tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal vsplit" })
keymap("n", "<leader>Th", "<cmd>split | terminal<cr>", { desc = "Terminal hsplit" })
keymap("n", "<leader>Tf", "<cmd>tabnew | terminal<cr>", { desc = "Terminal new tab" })

-- Terminal mode keymaps
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Move to left window" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Move to bottom window" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Move to top window" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Move to right window" })

-- Diagnostic
keymap("n", "<leader>dd", "<cmd>Telescope diagnostics<cr>", { desc = "Show diagnostics" })

-- ============================================================================
-- AUTOCOMMANDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Return to last edit position
augroup("RestoreCursor", { clear = true })
autocmd("BufReadPost", {
  group = "RestoreCursor",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- ============================================================================
-- FIX: CONFLITOS CLOJURE/LISP (v2)
-- ============================================================================

-- Fix 1: Tab/S-Tab em arquivos Lisp (liberar para paredit)
autocmd("FileType", {
  pattern = { "clojure", "fennel", "lisp", "scheme", "racket" },
  callback = function()
    -- Remover keymaps do bufferline para Lisps
    pcall(vim.keymap.del, "n", "<Tab>", { buffer = true })
    pcall(vim.keymap.del, "n", "<S-Tab>", { buffer = true })

    -- Navegacao de buffers com Alt em Lisps
    vim.keymap.set("n", "<M-l>", "<cmd>BufferLineCycleNext<cr>", {
      buffer = true,
      desc = "Next buffer (Alt)",
    })
    vim.keymap.set("n", "<M-h>", "<cmd>BufferLineCyclePrev<cr>", {
      buffer = true,
      desc = "Prev buffer (Alt)",
    })
  end,
})

-- ============================================================================
-- FIM
-- ============================================================================

-- Mensagem de boas vindas (opcional)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.defer_fn(function()
        -- vim.notify("Neovim 0.11.5 - Sistema AGENT", vim.log.levels.INFO)
      end, 100)
    end
  end,
})
