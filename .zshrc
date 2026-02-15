# =============================================================================
# ZSHRC - Jeffery's Shell Configuration (CachyOS/Arch)
# =============================================================================
# Philosophy: Keyboard-centric, fast, understandable
# Mirror of macOS config with Arch-native adaptations
# Mac version: github.com/ducksunderdoors/dotfiles
# Started: February 2026 (macOS) | Ported: February 2026 (CachyOS)
# =============================================================================

# -----------------------------------------------------------------------------
# PATH Configuration
# -----------------------------------------------------------------------------
# NOTE: No Homebrew on Linux — pacman/yay handle packages natively.
# Arch installs to /usr/bin which is already in PATH.

# Local bin for user scripts, pip --user installs, cargo, go, etc.
export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"

# -----------------------------------------------------------------------------
# History Configuration
# -----------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY       # Write immediately, not on shell exit

# -----------------------------------------------------------------------------
# Shell Options
# -----------------------------------------------------------------------------
setopt AUTO_CD
setopt CORRECT
setopt NO_CASE_GLOB
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS     # Allow # comments in live shell

# -----------------------------------------------------------------------------
# Key Bindings
# -----------------------------------------------------------------------------
bindkey -e                       # Emacs-style (Ctrl-A, Ctrl-E, etc.)

# Partial history search with arrow keys
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Ctrl-Backspace and Ctrl-Delete word deletion (Ghostty)
bindkey '^H'    backward-kill-word
bindkey '^[[3;5~' kill-word

# -----------------------------------------------------------------------------
# Completion System
# -----------------------------------------------------------------------------
autoload -Uz compinit && compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Colorize completions using LS_COLORS
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
# Menu selection (arrow keys to navigate)
zstyle ':completion:*' menu select

# -----------------------------------------------------------------------------
# Plugins (installed via pacman — the Arch way)
# -----------------------------------------------------------------------------
# sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting zsh-completions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------------------------------------------------------
# Aliases — Better Defaults
# -----------------------------------------------------------------------------
# These are identical across macOS and CachyOS (same binaries)

# eza (better ls)
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'

# bat (better cat)
alias cat='bat --paging=never'
alias catp='bat'

# Safety nets
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git shortcuts
alias g='git'
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'

# Shortcuts
alias top='btop'
alias vim='nvim'
alias vi='nvim'

# -----------------------------------------------------------------------------
# Arch/CachyOS-Specific Aliases
# -----------------------------------------------------------------------------
# Package management
alias pac='sudo pacman -S'          # Install package
alias pacs='pacman -Ss'             # Search repos
alias pacr='sudo pacman -Rns'       # Remove pkg + unused deps + config
alias pacu='sudo pacman -Syu'       # Full system upgrade (ALWAYS use this)
alias pacq='pacman -Qi'             # Query installed package info
alias pacl='pacman -Ql'             # List files owned by package
alias pacwho='pacman -Qo'           # Which package owns this file?

# AUR helper
alias yays='yay -Ss'
alias yayu='yay -Syu'

# Systemd
alias sc='sudo systemctl'
alias scu='systemctl --user'
alias jlog='journalctl -xe'
alias jboot='journalctl -b'

# Quick system info
alias mirrors='cat /etc/pacman.d/mirrorlist | head -20'
alias kernel='uname -r'

# -----------------------------------------------------------------------------
# Dotfiles Management (Bare Git Repo)
# -----------------------------------------------------------------------------
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lazydotfiles='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# -----------------------------------------------------------------------------
# Tool Initialization
# -----------------------------------------------------------------------------
# Starship prompt
eval "$(starship init zsh)"

# zoxide (smarter cd — use 'z' instead of 'cd')
eval "$(zoxide init zsh)"

# fzf keybindings and completion
# Ctrl-T: paste selected files
# Ctrl-R: search command history
# Alt-C: cd into selected directory
source <(fzf --zsh)

# -----------------------------------------------------------------------------
# FZF Configuration
# -----------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Preview files with bat in Ctrl-T
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
# Preview directories with eza in Alt-C
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --icons --color=always {}'"

# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------
export EDITOR='nvim'
export VISUAL='nvim'

# Colorized man pages via bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# XDG Base Directories (Arch convention — keeps ~ clean)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# -----------------------------------------------------------------------------
# Local Overrides
# -----------------------------------------------------------------------------
# Source local config if it exists (machine-specific settings, secrets, etc.)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# =============================================================================
# END ZSHRC
# =============================================================================
