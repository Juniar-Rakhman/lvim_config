vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.cmdheight = 1 -- more space in the neovim command line for displaying messages

local capabilities = require("lvim.lsp").common_capabilities()

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Determine OS
local home = os.getenv("HOME")
if vim.fn.has("mac") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
	CONFIG = "linux"
else
	print("Unsupported system")
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" then
	return
end

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir " .. workspace_dir)

-- get the mason install path
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
local java_test_path = require("mason-registry").get_package("java-test"):get_install_path()
local java_debug_adapter_path = require("mason-registry").get_package("java-debug-adapter"):get_install_path()

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {}

--- bundle Java debug and test ---

---@diagnostic disable-next-line: missing-parameter
vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))
---@diagnostic disable-next-line: missing-parameter
vim.list_extend(
	bundles,
	---@diagnostic disable-next-line: missing-parameter
	vim.split(vim.fn.glob(java_debug_adapter_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. install_path .. "/lombok.jar",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		install_path .. "/config_" .. CONFIG,
		"-data",
		workspace_dir,
	},
	root_dir = root_dir,
	capabilities = capabilities,
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-17",
						path = "/home/jrakhman/.sdkman/candidates/java/17.0.4-oracle",
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = false,
			},
			referencesCodeLens = {
				enabled = false,
			},
			references = {
				includeDecompiledSources = false,
			},
			inlayHints = {
				parameterNames = {
					enabled = "all", -- literals, all, none
				},
			},
			format = {
				enabled = true,
				settings = {
					url = "/home/jrakhman/.config/nvim/lua/user/autocmds/java-format.xml",
					profile = "GoogleStyle",
				},
			},
		},
		signatureHelp = { enabled = true },
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
		},
		contentProvider = { preferred = "fernflower" },
		extendedClientCapabilities = extendedClientCapabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
	flags = {
		allow_incremental_sync = true,
	},

	init_options = {
		bundles = bundles,
	},
}

function JdtAttach()
	local dap = require("dap")
	dap.configurations.java = {
		{
			type = "java",
			request = "attach",
			name = "Attach to the process",
			hostName = "localhost",
			port = "5005",
		},
	}
	dap.continue()
end

config["on_attach"] = function(client, bufnr)
	vim.lsp.codelens.refresh()
	require("jdtls.dap").setup_dap_main_class_configs()
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("lvim.lsp").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

vim.cmd(
	[[command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)]]
)
vim.cmd([[command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()]])

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	C = {
		name = "Java",
		o = { "<Cmd>lua require'jdtls'.organize_imports()<CR>", "Organize Imports" },
		v = { "<Cmd>lua require('jdtls').extract_variable()<CR>", "Extract Variable" },
		c = { "<Cmd>lua require('jdtls').extract_constant()<CR>", "Extract Constant" },
		t = { "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", "Test Method" },
		T = { "<Cmd>lua require'jdtls'.test_class()<CR>", "Test Class" },
		u = { "<Cmd>JdtUpdateConfig<CR>", "Update Config" },
		a = { ":lua JdtAttach()<CR>", "Attach Debugger" },
	},
}

local vmappings = {
	C = {
		name = "Java",
		v = { "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", "Extract Variable" },
		c = { "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", "Extract Constant" },
		m = { "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", "Extract Method" },
	},
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(vmappings, vopts)
