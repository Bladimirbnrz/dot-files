function fish_title_wez
    set -l command (status current-command)
    if test "$command" = "fish"
        echo (basename (pwd))
    else
        echo $command
    end
end
