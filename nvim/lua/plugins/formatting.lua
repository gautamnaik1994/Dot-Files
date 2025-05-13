return {

    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                python = { "autopep8" },
                -- Use a sub-list to run only the first available formatter
                javascript = { "prettierd", "prettier"  },
                javascriptreact = {  "prettierd", "prettier"  },
                typescript = {  "prettierd", "prettier"  },
                typescriptreact = {  "prettierd", "prettier" },
                vue = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                -- less = { { "prettierd", "prettier" } },
                html = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                jsonc = { "prettierd", "prettier" },
                yaml = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                ["markdown.mdx"] = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                handlebars = { "prettierd", "prettier" },

            },
            format_on_save = {
                -- These options will be passed to conform.format()
                timeout_ms = 500,
                lsp_fallback = true,
            },
        })
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end

}
