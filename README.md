# azure-pipelines.vim

very simple azure-pipelines plugins for the follow devops engineers suffering
from ADO.

it adds:

1. filetype `azure_pipelines`
2. detects if file is azure_pipelines format by looking at the top 40 lines
3. treesitter grammar for `azure_pipelines` ft based on `yaml`

## lazy

```lua
return {
  {
    "ChristofferNissen/azure-pipelines.nvim",
    config = function()
      require("azure_pipelines")
    end,
    event = { "BufReadPre", "BufNewFile" },
    ft = "yaml",
  },
}
```

setup lsp for azure pipelines(nvim > 0.11):

```lua
--@type vim.lsp.Config
return {
    cmd = { "azure-pipelines-language-server", "--stdio" },
    filetypes = { "azure_pipelines" },
    -- filetypes = { "yaml" },
    single_file_support = true,
    capabilities = {
        textDocument = {
            foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            },
        },
    },
    settings = {
        yaml = {
            completions = true,
            validate = true,
            redhat = { telemetry = { enabled = false } },
            schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                    "*",
                },
            },
            schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
            },
        },
    },
    root_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
    root_markers = { "azure-pipelines.yml" },
}
```
