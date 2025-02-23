function prompt_long_pwd --description 'Print the current working directory with ~/ to represent $HOME'
        echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||'
end
