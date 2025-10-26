# Evita que respuestas OSC/DA de terminal se impriman en la línea de comandos
function __suppress_terminal_responses --on-event fish_prompt
    stty -icanon -echo 2>/dev/null
end

function __restore_terminal_settings --on-event fish_postexec
    stty icanon echo 2>/dev/null
end

