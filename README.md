# vttr.vim

Run current spec inside adjacent tmux window.

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

By default there are no keyboard mappings. Map them like so:

```
noremap <C-m> :RSpecFile<CR>
noremap <C-n> :RSpecLine<CR>
```

