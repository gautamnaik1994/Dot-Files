local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting

local sources = {
    formatting.autopep8,
    formatting.eslint,
    formatting.eslint_d,
    -- formatting.prettier,
    formatting.prettierd,
    formatting.stylelint,
    formatting.csharpier
}

null_ls.setup({
    sources = sources,
    on_attach = function(client)
        if client.server_capabilities.documentFormattingProvider then
            vim.cmd(
                [[
                    augroup LspFormatting
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                    augroup END
            ]]
            )
        end
    end,
})
