set -g theme_display_date no
set -g fish_prompt_pwd_dir_length 0
set -g theme_nerd_fonts yes
set -g theme_newline_cursor yes
set -g theme_newline_prompt "  "
# set -g theme_newline_prompt "><> "

# set -g theme_color_scheme zenburn 
set -g theme_color_scheme nord
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Cambiar la lectura de <shift><space> para aceptar sugerencias
function fish_user_key_bindings
  bind \e\[99~ accept-autosuggestion
end

alias ls='eza --icons --group-directories-first --color=always'
alias ok='okular'
alias cr='clear'
alias py='python3'
alias upy="/usr/bin/python3"
# alias v='nvim'
alias v='openNvim'
alias act='source venv/bin/activate.fish'
alias venvCreate='python3 -m venv venv'
alias dact='deactivate'
alias venvInstallBasics='pip install --no-index --find-links=~/py_packages/local_packages/'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#latex alias
alias latexFigs='cp -r ~/.latex_temps/temp2/figuras/ .'

alias r='openRanger'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Created by `pipx` on 2025-09-13 21:56:39
set PATH $PATH /home/barron/.local/bin

# Inicializar zoxide
zoxide init fish | source

# if not set -q TMUX
  # exec tmux
# end
