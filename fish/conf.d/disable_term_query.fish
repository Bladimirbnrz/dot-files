# ~/.config/fish/conf.d/disable_query_term.fish
# If the variable no-query-term is not present, it is automatically declared. 

if not contains -- no-query-term $fish_features
    set -Ua fish_features no-query-term
end
