--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
-- lvim.format_on_save.pattern
-- lvim.colorscheme = "vscode"
-- lvim.colorscheme = "rvcs"
lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "onedark"
-- theme for jetbrains
-- lvim.colorscheme = "darcula"
vim.opt.wrap = true

-- indent_blankline vim config
vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
-- lvim.builtin.treesitter.rainbow = { enable = true }
-- lvim.builtin.treesitter.highlight = { enable = true }
-- vim.opt.termguicolors = true
-- vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

--[[lunarvim 的快捷键配置必须使用lvim来配置
    vim.cmd()以及nvim_set_keymap()的方法虽然可以配置，但是
    在重新启动lunarvim之后，快捷键会被覆盖或者清除
    并且lunarvim的normal_mode映射无法进行递归映射
]]

lvim.keys.normal_mode = {
  ["<Leader>n"] = ":Vista!!<CR>",
  ["<Leader>a"] = ":Autoformat<CR>",
  ["<Leader>an"] = ":AutoformatLine<CR>",
  -- ["<leader><leader>"] = "<Plug>(easymotion-prefix)",
  -- ["<Leader><Leader>s"] = "<Plug>(easymotion-s)",
  -- ["<Leader><Leader>w"] = "<Plug>(easymotion-w)",
  --[[
    easymotion快捷键映射
  ]]
  -- ["<Leader><Leader>s"] = ":<C-U>call EasyMotion#S(1,0,2)<CR>",
  -- ["<Leader><Leader>s2"] = ":<C-U>call EasyMotion#S(2,0,2)<CR>",
  ["<Leader><Leader>sn"] = ":<C-U>call EasyMotion#S(-1,0,2)<CR>",
  ["<Leader><Leader>w"] = ":<C-U>call EasyMotion#WB(0,0)<CR>",
  ["<Leader><Leader>W"] = ":<C-U>call EasyMotion#WBW(0,0)<CR>",
  ["<Leader>r"] = ":LspRestart<CR>",
  ["<Leader>o"] = ":set fdm=syntax<CR>",
  ["<Leader><Leader>p"] = ":Glow<CR>",
}
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
-- lvim.builtin.dashbord.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true


-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- vim.cmd([[
--     map <Leader><Leader> <Plug>(easymotion-prefix)
--     map <Leader><Leader>s <Plug>(easymotion-s)
-- ]])

-- vim.cmd(
--   [[
--     map <Leader>v :Vista<cr>
--     map <Leader>vc :Vista!<cr>
--   ]]
-- )



-- vim.api.nvim_set_keymap('n', '<Leader>v', ':Vista<CR>', {noremap = true, silent = true})

-- Additional Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  { "fatih/vim-go" },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb', '<S-[>', '<S-]>' },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
      }
    end
  },
  { "Chiel92/vim-autoformat" },
  { "easymotion/vim-easymotion" },
  { "tpope/vim-surround" },
  { "wakatime/vim-wakatime" },
  { 'liuchengxu/vista.vim' },
  -- { 'luochen1990/rainbow' },
  { 'mg979/vim-visual-multi' },
  -- { "p00f/nvim-ts-rainbow" },
  { 'rust-lang/rust.vim' },
  { 'gko/vim-coloresque' },
  {
    'ojroques/nvim-lspfuzzy',
    requires = {
      { 'junegunn/fzf' },
      { 'junegunn/fzf.vim' }, -- to enable preview (optional)
    },
    config = function()
      require('lspfuzzy').setup {}
    end
  },
  -- {'junegunn/fzf', { 'do': { -> fzf#install() } }},
  -- {'junegunn/fzf.vim'},
  -- {"github/copilot.vim"},
  -- vim theme
  { 'Mofiqul/vscode.nvim' },
  { 'shaeinst/roshnivim-cs' },
  -- like jetbrain
  { 'doums/darcula' },
  { "folke/tokyonight.nvim" },
  -- indentLine
  {
    'lukas-reineke/indent-blankline.nvim',
    -- config = function()
    --   require("indent_blankline").setup {}
    -- end
  },

  -- { 'Yggdroot/indentLine' },
  -- debug
  -- { 'puremourning/vimspector' },
  -- { 'skywind3000/vim-rt-format' },
  -- preview of markdown in terminal
  {"ellisonleao/glow.nvim", branch = 'main'},
  {'kdheepak/lazygit.nvim'},
}
-- vim.g.rainbow_active = 1
vim.g.vscode_style = "dark"
vim.g.vscode_italic_comment = 1
vim.g.indentLine_enabled = 1
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_current_context_start = true
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
