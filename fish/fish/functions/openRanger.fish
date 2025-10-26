function openRanger
    ranger --choosedir=$HOME/.rangerdir
    if test -f $HOME/.rangerdir
        cd (cat $HOME/.rangerdir)
    end
end
