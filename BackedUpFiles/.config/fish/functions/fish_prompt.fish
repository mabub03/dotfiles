function fish_prompt --description 'Custom Prompt'
    set -l last_status $status
    # prompt status only if it's not 0
    set -l stat
    #set -l lambda \u03BB

    if test $last_status -ne 0
        set stat (set_color red)"[$last_status]"(set_color normal)
    end

    echo
    #set_color $fish_color_cwd
    #echo (prompt_long_pwd)
    string join '' -- (set_color $fish_color_cwd) (prompt_long_pwd) (set_color normal) $stat
    echo -n (set_color $fish_color_cwd)\u03BB ""
    set_color normal
end
