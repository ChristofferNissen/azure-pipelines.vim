" Syntax highlighting for azure_pipelines filetype

" Load YAML syntax first
runtime! syntax/yaml.vim

" Azure Pipelines top-level keys
syn keyword azurePipelinesKeyword trigger pr pool jobs steps stages variables resources
syn keyword azurePipelinesTask checkout script task
syn match azurePipelinesCondition /\<condition\>/

" Highlight links
hi def link azurePipelinesKeyword Keyword
hi def link azurePipelinesTask Function
hi def link azurePipelinesCondition Conditional
