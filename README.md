# vttr.vim

Run current spec inside adjacent tmux window.

### Demo

https://asciinema.org/a/87H9t5YcD243QtXSwK7n8xsSg/

## Installation

Install using your favorite package manager, or use Vim's built-in package
support:

##### Pathogen

```
cd ~/.vim/bundle
git clone git://github.com/bpolly/vim-ttr.git
```

##### VimPlug

Place this in your .vimrc:

```viml
Plug 'bpolly/vim-ttr'
```

Then run the following in Vim:

```
:source %
:PlugInstall
```

## Setup

```
" .vimrc

" Set this variable to 1 to clear the terminal contents before each test run.
let g:clear_screen_before_test_run = 1

" The default rspec command is `bundle exec rspec` but can be overwritten with this:
let g:rspec_command = `custom rspec command`

" Prefer bin/rspec if it is available:
let g:use_spring = 1

" cd into the app's base directory before running spec:
let g:vttr_change_directories = 1 

" By default there are no keyboard mappings. Map them like so:
noremap <Leader>f :RSpecFile<CR>
noremap <Leader>l :RSpecLine<CR>
noremap <Leader>x :RSpecFailures<CR>
```
