if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting
    set -U fish_prompt_pwd_dir_length 0
    
    alias sudo="sudo-rs"
    alias sudo_original="/usr/bin/sudo"

    set -gx COSMIC_DATA_CONTROL_ENABLED 1
    
    #TODO look into getting pure fish which is what cachy uses and other cachy extensions

    #set -gx __GL_SHADER_DISK_CACHE_SKIP_CLEANUP 1
end
