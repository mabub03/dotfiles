if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
    set -U fish_prompt_pwd_dir_length 0

    set -U fish_user_paths /home/toasty/.cargo/bin $fish_user_paths

    #source ~/.asdf/asdf.fish

    # set -g __fish_git_prompt_show_informative_status 1
    # set -g __fish_git_prompt_hide_untrackedfiles 1

    # set -g __fish_git_prompt_color_branch magenta bold
    # set -g __fish_git_prompt_showupstream "informative"
    # set -g __fish_git_prompt_char_upstream_ahead "↑"
    # set -g __fish_git_prompt_char_upstream_behind "↓"
    # set -g __fish_git_prompt_char_upstream_prefix ""

    # set -g __fish_git_prompt_char_stagedstate "●"
    # set -g __fish_git_prompt_char_dirtystate "✚"
    # set -g __fish_git_prompt_char_untrackedfiles "…"
    # set -g __fish_git_prompt_char_conflictedstate "✖"
    # set -g __fish_git_prompt_char_cleanstate "✔"

    # set -g __fish_git_prompt_color_dirtystate blue
    # set -g __fish_git_prompt_color_stagedstate yellow
    # set -g __fish_git_prompt_color_invalidstate red
    # set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    # set -g __fish_git_prompt_color_cleanstate green bold
end
