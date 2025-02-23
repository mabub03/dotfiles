function ls --description "remap ls to eza with icons"
    if not type -q eza
        command ls --color=auto $argv; and return
    end

    eza --icons $argv
end
