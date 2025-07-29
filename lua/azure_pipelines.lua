-- Detect Azure Pipelines YAML by content and set filetype

local azure_keys = {
	"trigger",
	"pr",
	"pool",
	"jobs",
	"steps",
	"stages",
	"variables",
	"resources",
}

local function is_azure_pipelines_yaml(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, math.min(vim.api.nvim_buf_line_count(bufnr), 40), false)
	for _, line in ipairs(lines) do
		for _, key in ipairs(azure_keys) do
			if line:match("^%s*" .. key .. "%s*:") then
				return true
			end
		end
	end
	return false
end

local function set_azure_pipelines_filetype()
	local ft = vim.bo.filetype
	if ft == "yaml" or ft == "yml" then
		if is_azure_pipelines_yaml(0) then
			vim.bo.filetype = "azure_pipelines"
		end
	end
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
	pattern = { "*.yml", "*.yaml", "*" },
	callback = set_azure_pipelines_filetype,
	group = vim.api.nvim_create_augroup("AzurePipelinesDetection", { clear = true }),
})

if vim.treesitter.language and vim.treesitter.language.register then
	vim.treesitter.language.register("yaml", "azure_pipelines")
end
