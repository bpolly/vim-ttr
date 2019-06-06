if exists("g:loaded_vttr") || v:version < 700
  finish
endif
let g:loaded_vttr = 1

"---------------------------------------------------------
" Config Variables
"---------------------------------------------------------
let g:rspec_command = get(g:, 'rspec_command', 'bundle exec rspec')
let g:clear_screen_before_test_run = get(g:, 'clear_screen_before_test_run', 0)
let g:use_spring = get(g:, 'use_spring', 0)
let g:vttr_change_directories = get(g:, 'vttr_change_directories', 0)

"---------------------------------------------------------
" RSpec Test Runner
"---------------------------------------------------------
let s:project_root_path = ''
let s:spec_path = ''
let s:use_line = 0

function! ExitScrollMode()
    call system("tmux send-keys -t .+ Escape Escape")
endfunction

function! SetFilePaths()
    let fullfilename = expand('%:p')
    let matches = matchlist(fullfilename, '\(.*\)\/\(spec.*\)')
    if len(matches) < 3
        return 0
    endif
    let s:project_root_path = matches[1]
    let s:spec_path = matches[2]
    return 1
endfunction

function! ClearScreenIfNeeded()
    if g:clear_screen_before_test_run
        call system("tmux send-keys -t .+ 'clear' Enter")
    endif
endfunction

function! TestCommand()
    if g:use_spring && !empty(glob(s:project_root_path . '/bin/rspec'))
        return 'bin/rspec'
    else
        return g:rspec_command
    endif
endfunction

function! TestFilename()
    let filename = s:spec_path
    if s:use_line == 1
        let filename = filename . ":" . line('.')
    endif
    if s:only_failures == 1
        let filename = filename . ' --only-failures'
    endif
    if filename =~? 'spec/features'
        let filename = filename . ' --tag type:feature'
    endif
    return filename
endfunction

function! SendTestCommand()
    let system_call = "tmux send-keys -t .+ '"
    if g:vttr_change_directories == 1
      let system_call = system_call . "cd " . s:project_root_path . " && "
    endif
    let system_call = system_call . TestCommand() . " " . TestFilename() . "' Enter"
    call system(system_call)
endfunction

function! RspecMe(use_line, only_failures)
    let s:use_line = a:use_line
    let s:only_failures = a:only_failures
    if SetFilePaths() == 0 " if the selected file is not valid spec, exit
        echo 'Error: Could not find spec file'
        return
    endif
    call ExitScrollMode()
    call ClearScreenIfNeeded()
    call SendTestCommand()
endfunction

command! -bar RSpecFile call RspecMe(0,0)
command! -bar RSpecLine  call RspecMe(1,0)
command! -bar RSpecFailures call RspecMe(0,1)

