local cmp = require('blink.cmp')
local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

cmp.build():pwait()
-- cmp.setup()


-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
	Error = "\u{f057} ",
	Warn = "\u{f071} ",
	Hint = "\u{ea61}",
	Info = "\u{f05a}",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<leader>gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)

	vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, opts)

	vim.keymap.set("n", "<leader>gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	vim.keymap.set("n", "<leader>D", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	vim.keymap.set("n", "<leader>d", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
	vim.keymap.set("n", "<leader>nd", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)

	vim.keymap.set("n", "<leader>pd", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

cmp.setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        -- ["Tab"] = {"select_next"}
		-- ["<Tab>"] = { "snippet_forward", "fallback" },
		-- ["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	-- appearance = { nerd_font_variant = "mono" },
	completion = {
		menu = {
			auto_show = function()
				return vim.bo.filetype ~= "markdown"
			end,
		},
	},
	-- -- signature help while typing function calls (was previously unset)
	signature = { enabled = true },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	-- -- snippets now use blink's native engine — LuaSnip dependency removed
	fuzzy = {
		implementation = "prefer_rust",
	},
})


vim.lsp.config["*"] = {
	capabilities = cmp.get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})
-- vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {})
-- vim.lsp.config("gopls", {})
-- vim.lsp.config("clangd", {})
-- vim.lsp.config("omnisharp", {})

vim.g.rustaceanvim = {
	server = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true, -- Automatically load feature flags
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true, -- Smooth experience with macros like serde
              },
            --   checkOnSave = {
            --     command = "clippy", -- Use clippy instead of cargo check
            --   },
            },
          },
	},
}

-- do
-- 	local luacheck = require("efmls-configs.linters.luacheck")
-- 	local stylua = require("efmls-configs.formatters.stylua")

-- 	local ruff_lint = require("efmls-configs.linters.ruff")
-- 	local ruff_format = require("efmls-configs.formatters.ruff")

-- 	local prettier_d = require("efmls-configs.formatters.prettier_d")
-- 	local eslint_d = require("efmls-configs.linters.eslint_d")

-- 	local fixjson = require("efmls-configs.formatters.fixjson")

-- 	local shellcheck = require("efmls-configs.linters.shellcheck")
-- 	local shfmt = require("efmls-configs.formatters.shfmt")

-- 	local cpplint = require("efmls-configs.linters.cpplint")
-- 	local clangfmt = require("efmls-configs.formatters.clang_format")

-- 	local go_revive = require("efmls-configs.linters.go_revive")
-- 	local gofumpt = require("efmls-configs.formatters.gofumpt")

-- 	vim.lsp.config("efm", {
-- 		filetypes = {
-- 			"c",
-- 			"cpp",
-- 			"css",
-- 			"go",
-- 			"html",
-- 			"javascript",
-- 			"javascriptreact",
-- 			"json",
-- 			"jsonc",
-- 			"lua",
-- 			"markdown",
-- 			"python",
-- 			"sh",
-- 			"typescript",
-- 			"typescriptreact",
-- 			"vue",
-- 			"svelte",
-- 		},
-- 		init_options = { documentFormatting = true },
-- 		settings = {
-- 			languages = {
-- 				c = { clangfmt, cpplint },
-- 				go = { gofumpt, go_revive },
-- 				cpp = { clangfmt, cpplint },
-- 				css = { prettier_d },
-- 				html = { prettier_d },
-- 				javascript = { eslint_d, prettier_d },
-- 				javascriptreact = { eslint_d, prettier_d },
-- 				json = { eslint_d, fixjson },
-- 				jsonc = { eslint_d, fixjson },
-- 				lua = { luacheck, stylua },
-- 				markdown = { prettier_d },
-- 				python = { ruff_lint, ruff_format },
-- 				sh = { shellcheck, shfmt },
-- 				typescript = { eslint_d, prettier_d },
-- 				typescriptreact = { eslint_d, prettier_d },
-- 				vue = { eslint_d, prettier_d },
-- 				svelte = { eslint_d, prettier_d },
-- 			},
-- 		},
-- 	})
-- end

-- vim.lsp.enable({
-- 	"lua_ls",
-- 	"pyright",
-- 	"bashls",
-- 	"ts_ls",
-- 	"gopls",
-- 	"clangd",
-- 	"omnisharp",
-- 	"efm",
-- })



vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
-- vim.lsp.enable('rust_analyzer')
