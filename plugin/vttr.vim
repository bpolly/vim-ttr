if exists("g:loaded_vttr") || v:version < 700
  finish
endif
let g:loaded_vttr = 1

"---------------------------------------------------------
" RSpec Test Runner
"---------------------------------------------------------
function! CurrentProjectRoot()
  let localfilename = @% " spec/models/drug_spec.rb
  let fullfilename = expand('%:p') " /users/bpolly/dev/apps/hubservices/spec/models/drug_spec.rb
  let project_root_path = substitute(fullfilename, localfilename, "", "")
  return project_root_path
endfunction

function! RspecMe(use_line)
  let dir = CurrentProjectRoot()
  let system_call = "tmux send-keys -t .+ 'cd " . dir . " && bin/rspec " . TestFilename(a:use_line) . "' Enter"
  call system(system_call)
endfunction

function! TestFilename(use_line)
    let s:filename = @%
    if a:use_line == 1
        let s:filename = s:filename . ":" . line('.')
    endif
    if s:filename =~? 'spec/features'
        let s:filename = s:filename . ' --tag type:feature'
    endif
    return s:filename
endfunction

command! -bar RSpecFile call RspecMe(0)
command! -bar RSpecLine  call RspecMe(1)


