function log_session() {
    if [ ! -d "$HOME/logs" ]
    then
        mkdir "$HOME/logs"
    fi

    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local log_file="$HOME/logs/terminal_$timestamp.log"

    echo "Recording terminal session to $log_file..."

    script "$log_file"

    echo "Terminal session recording finished."
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd log_session




##########################


function record_prompt() {
    if ! command -v asciinema &> /dev/null
    then
        echo "Asciinema is not installed. Please install it first: https://asciinema.org/docs/installation"
        return
    fi

    read -q "REPLY?Do you want to record this terminal session? [y/n] "
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        read -p "Enter a name for the recording (leave blank for random name): " name
        if [ -z "$name" ]
        then
            asciinema rec
        else
            asciinema rec -y "$name"
        fi
    fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd record_prompt
