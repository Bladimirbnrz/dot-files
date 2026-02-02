# you can choose anyone of below to add Homebrew to your path
# {{{
# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"

# if test -d /home/linuxbrew/.linuxbrew
#     /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
# end

fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path /home/linuxbrew/.linuxbrew/sbin
# }}}

fish_add_path /home/barron/.cargo/bin/

set -x EDITOR nvim
set -x VISUAL nvim

set -gx TMUX_CONFIG_DIR "$HOME/.config/tmux"

set -gx COLORTERM truecolor
set -gx TERM xterm-256color
set -gx CROSSTERM_FORCE_TRUE_COLOR 1


if status is-interactive
  # Commands to run in interactive sessions can go here

  # <shift><space> to accept-autosuggestion
  function fish_user_key_bindings
    # you shouldn't use the first option if “enable_kitty_keyboard = true” cause you any problems.
    # bind shift-space accept-autosuggestion
    bind \cy accept-autosuggestion
  end

  set -g theme_display_date no
  set -g fish_prompt_pwd_dir_length 0
  set -g theme_nerd_fonts yes
  set -g theme_newline_cursor yes
  set -g theme_newline_prompt "  "
  # set -g theme_newline_prompt "><> "
  # set -g theme_color_scheme zenburn 
  set -g theme_color_scheme nord
  set -x VIRTUAL_ENV_DISABLE_PROMPT 1

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
  alias venvInstall='pip install --no-index --find-links=~/.py_packages/'
end

zoxide init fish | source

# if not set -q TMUX
# exec tmux
# end
