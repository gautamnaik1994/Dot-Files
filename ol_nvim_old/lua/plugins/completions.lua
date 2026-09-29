return {
    {
    'hrsh7th/nvim-cmp',
    -- dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'tzachar/cmp-tabnine' },
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },

    config = function()
        local cmp = require 'cmp'
        local luasnip = require 'luasnip'
        local lspkind = require('lspkind')
        local source_mapping = {
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            -- cmp_tabnine = "[TN]",
            path = "[Path]",
        }

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            formatting = {
                format = function(entry, vim_item)
                    -- if you have lspkind installed, you can use it like
                    -- in the following line:
                    vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
                    vim_item.menu = source_mapping[entry.source.name]
                    -- if entry.source.name == "cmp_tabnine" then
                    --     local detail = (entry.completion_item.labelDetails or {}).detail
                    --     vim_item.kind = ""
                    --     if detail and detail:find('.*%%.*') then
                    --         vim_item.kind = vim_item.kind .. ' ' .. detail
                    --     end

                    --     if (entry.completion_item.data or {}).multiline then
                    --         vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
                    --     end
                    -- end
                    local maxwidth = 80
                    vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
                    return vim_item
                end,
            },

            mapping = cmp.mapping.preset.insert {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            sources = {
                -- { name = 'cmp_tabnine' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            },
        }
    end
},
    -- {

    --     'tzachar/cmp-tabnine',
    --     build = './install.sh',
    --     dependencies = 'hrsh7th/nvim-cmp',
        -- config = function()
        --     local tabnine = require('cmp_tabnine.config')
        --     tabnine:setup({
        --         max_lines = 1000,
        --         max_num_results = 20,
        --         sort = true,
        --         run_on_every_keystroke = true,
        --         snippet_placeholder = '..',
        --         ignored_file_types = {
        --             -- default is not to ignore
        --             -- uncomment to ignore in lua:
        --             -- lua = true
        --         },
        --         show_prediction_strength = true
        --     })
        -- end

    -- },
    {
        "github/copilot.vim",
        -- set keymap to accept completion on right arrow
        config = function()
            vim.keymap.set('i', '<S-Right>', 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false
              })
              vim.g.copilot_no_tab_map = true
        end
    }
    --  {
    --     "zbirenbaum/copilot.lua",
    --     cmd = "Copilot",
    --     event = "InsertEnter",
    --     config = function()
    --       require("copilot").setup({})
    --     end,
    --   }
}