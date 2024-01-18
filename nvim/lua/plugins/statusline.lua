return {
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            -- The line beneath this is called `modeline`. See `:help modeline`
            -- vim: ts=2 sts=2 sw=2 et
            -- require("autoclose").setup({})
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,
                    color_icons = true,
                    show_buffer_icons = true,
                },
                -- highlights = {
                --     buffer_selected = {
                --         italic = false,
                --     },
                --     diagnostic_selected = {
                --         italic = false,
                --     },
                --     error_selected = {
                --         italic = false,
                --     },
                --     error_diagnostic_selected = {
                --         italic = false,
                --     },
                --     warning_selected = {
                --         italic = false,
                --     },
                --     hint_selected = {
                --         italic = false,
                --     },
                --     warning_diagnostic_selected = {
                --         italic = false,
                --     },
                --     hint_diagnostic_selected = {
                --         italic = false,
                --     },
                --     info_selected = {
                --         italic = false,
                --     },
                --     info_diagnostic_selected = {
                --         italic = false,
                --     },
                --     numbers_selected = {
                --         italic = false,
                --     },
                -- }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = function()
            -- Set lualine as statusline
            -- See `:help lualine.txt`
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'catppuccin',
                    -- component_separators = '|',
                    -- section_separators = '',
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff',
                        {
                            'diagnostics',

                            -- Table of diagnostic sources, available sources are:
                            --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                            -- or a function that returns a table as such:
                            --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
                            sources = { 'nvim_lsp' },

                            -- Displays diagnostics for the defined severity types
                            sections = { 'error', 'warn', 'info', 'hint' },

                            -- diagnostics_color = {
                            --     -- Same values as the general color option can be used here.
                            --     error = 'DiagnosticError', -- Changes diagnostics' error color.
                            --     warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
                            --     info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
                            --     hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
                            -- },
                            symbols = { error = 'E:', warn = 'W:', info = 'I:', hint = 'H:' },
                            colored = true,           -- Displays diagnostics status in color if set to true.
                            update_in_insert = false, -- Update diagnostics in insert mode.
                            always_visible = false,   -- Show diagnostics even if there are none.
                        },
                    },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                }
                -- sections = { lualine_c = { 'lsp_progress' }, lualine_x = { 'tabnine' } }
                -- tabline = {
                --     lualine_a = {
                --         {
                --             "buffers",

                --             right_padding = 2,
                --             symbols = { alternate_file = "" },
                --         },
                --     },
                -- },
            }
        end
    }
}
