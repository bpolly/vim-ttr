if exists("g:loaded_vttr") || v:version < 700
  finish
endif
let g:loaded_vttr = 1

let g:rspec_command = get(g:, 'rspec_command', 'bundle exec rspec')
let g:clear_screen_before_test_run = get(g:, 'clear_screen_before_test_run', 0)
"---------------------------------------------------------
" RSpec Test Runner
"---------------------------------------------------------
function! ExitScrollMode()
    call system("tmux send-keys -t .+ Escape Escape")
endfunction

function! ClearScreen()
    call system("tmux send-keys -t .+ 'clear' Enter")
endfunction

function! CurrentProjectRoot()
  let localfilename = @% " spec/models/drug_spec.rb
  let fullfilename = expand('%:p') " /users/bpolly/dev/apps/hubservices/spec/models/drug_spec.rb
  let project_root_path = substitute(fullfilename, localfilename, "", "")
  return project_root_path
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

function! RspecMe(use_line)
  let dir = CurrentProjectRoot()
  let system_call = "tmux send-keys -t .+ 'cd " . dir . " && " . g:rspec_command . " " . TestFilename(a:use_line) . "' Enter"
  call ExitScrollMode()
  if g:clear_screen_before_test_run
      call ClearScreen()
  endif
  call system(system_call)
endfunction

command! -bar RSpecFile call RspecMe(0)
command! -bar RSpecLine  call RspecMe(1)


