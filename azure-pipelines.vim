" Plugin: azure-pipelines.vim
" Description: Detect Azure Pipelines YAML files by content and set filetype.

function! DetectAzurePipelinesYaml()
  " Only run if the filetype is yaml
  if &filetype !=# 'yaml'
    return
  endif

  " Search for Azure Pipelines top-level keys in the first 40 lines
  let l:max_lines = min([line('$'), 40])
  for lnum in range(1, l:max_lines)
    let text = getline(lnum)
    if text =~? '^\s*\(trigger\|pr\|pool\|jobs\|steps\|stages\)\s*:'
      " Set filetype to azure_pipelines
      execute "setlocal filetype=azure_pipelines"
      return
    endif
  endfor
endfunction

augroup azure_pipelines_yaml_detect
  autocmd!
  autocmd BufReadPost,BufWinEnter *.yml,*.yaml call DetectAzurePipelinesYaml()
augroup END
