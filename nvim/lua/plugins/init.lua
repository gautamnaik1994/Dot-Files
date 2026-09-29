vim.pack.add({
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-mini/mini.nvim",
    -- "https://github.com/folke/flash.nvim",
    -- "https://github.com/smoka7/hop.nvim",   
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    "https://github.com/lewis6991/gitsigns.nvim",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
    },
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    "https://github.com/ibhagwan/fzf-lua",
  {
  src = 'https://github.com/mrcjkb/rustaceanvim',
  -- To avoid being surprised by breaking changes,
  -- I recommend you set a version range
  version = vim.version.range('^9')
    },
{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" } 
})

local function packadd(name)
    vim.cmd("packadd " .. name)
end

packadd("nvim-treesitter")
packadd("nvim-tree.lua")
packadd("mini.nvim")
packadd("gitsigns.nvim")
packadd("rustaceanvim")
-- packadd("flash.nvim")
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("blink.lib")
packadd("blink.cmp")
packadd("fzf-lua")
packadd("catppuccin")


require("mini.comment").setup({})
require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.statusline").setup({})
require("mini.tabline").setup({})
require("mini.icons").setup({})

require("mason").setup({})

require("plugins.tree")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.fzf")