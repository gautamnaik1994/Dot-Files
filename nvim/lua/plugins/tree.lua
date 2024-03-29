return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
        -- on_attach = on_attach,
    },
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            disable_netrw = false,
            hijack_netrw = false,

            view = {
                adaptive_size = true,
                mappings = {
                    list = {
                        { key = "u", action = "dir_up" },
                    },
                },
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        })
    end
}
