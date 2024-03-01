if true
    # configuration paths
    abbr --add zshconfig    "cd ~/.config/zsh/ && nvim ."
    abbr --add vimconfig    "cd ~/.config/nvim/ && nvim ."
    abbr --add tmuxconfig   "cd ~/.config/tmux/ && nvim ."
    abbr --add ohmyzsh      "nvim ~/.oh-my-zsh"
    abbr --add kittyconfig  "cd ~/.config/kitty/ && nvim ."

    # others
    abbr --add vim          "nvim"
    abbr --add zshsource    "source ~/.config/zsh/.zshrc"

    # connections [bluetooth, wifi]
    abbr --add headset      "bluetoothctl connect 30:53:C1:33:99:7B"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end
