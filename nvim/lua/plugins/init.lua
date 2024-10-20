return {
    -- 'wbthomason/packer.nvim',
    'wakatime/vim-wakatime',
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        },
    },




    -- { 'codota/tabnine-nvim', build = "./dl_binaries.sh" },

    { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },

    { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = 'nvim-treesitter',
    },

    --'m4xshen/autoclose.nvim'
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    -- require("nvim-autopairs").setup {}

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'lewis6991/gitsigns.nvim',

    'navarasu/onedark.nvim', -- Theme inspired by Atom
    { "catppuccin/nvim",                          name = "catppuccin" },
    'nvim-tree/nvim-web-devicons',

    'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
    'numToStr/Comment.nvim',               -- "gc" to comment visual regions/lines
    'JoosepAlviste/nvim-ts-context-commentstring',
    'tpope/vim-sleuth',                    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-surround',
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    'tpope/vim-repeat',
    "rafamadriz/friendly-snippets",

    --- Fuzzy Finder (files, lsp, etc)-- Fuzzy Finder (files, lsp, etc)- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim',            branch = '0.1.x',   dependencies = { 'nvim-lua/plenary.nvim' } },

    -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make',     cond = vim.fn.executable 'make' == 1 },
    'mattn/emmet-vim',
    --{ 'alvarosevilla95/luatab.nvim', dependencies = 'kyazdani42/nvim-web-devicons' }
    -- use({
    --     'crispgm/nvim-tabline',
    --     config = function()
    --         require('tabline').setup({})
    --     end,
    -- })


    { "nvim-telescope/telescope-file-browser.nvim" },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {},
        config = function()
            local hop = require('hop')
            hop.setup({})
            vim.keymap.set('n', 's', function()
                hop.hint_char2()
            end, { remap = true })
        end
    },

    'windwp/nvim-ts-autotag',

    --'RRethy/vim-illuminate'
    'nvim-treesitter/nvim-treesitter-refactor',
    'wellle/targets.vim',
    'onsails/lspkind.nvim'


}
