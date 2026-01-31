# function openNvim 
#     if test (count $argv) -eq 0
#         command nvim .
#     else
#         command nvim $argv
#     end
# end

function openNvim
    if test (count $argv) -eq 1; and test -d $argv[1]
        set -x NVIM_OIL_PREVIEW 1
        command nvim $argv
    else if test (count $argv) -eq 0
        set -x NVIM_OIL_PREVIEW 1
        command nvim .
    else
        command nvim $argv
    end
end
