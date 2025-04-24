# #!/bin/bash

# # Testing script for both Bash and Zsh settings

# # Test Bash-specific settings
# if [ -n "$BASH_VERSION" ]; then
#     echo "Testing Bash-specific settings:"

#     # Check history settings
#     echo "HISTCONTROL: $HISTCONTROL"
#     echo "HISTSIZE: $HISTSIZE"
#     echo "HISTFILESIZE: $HISTFILESIZE"

#     # Check if histappend is enabled
#     echo -n "histappend option is "
#     shopt histappend && echo "enabled" || echo "disabled"

#     # Check the prompt
#     echo "Prompt (PS1): $PS1"

# # Test Zsh-specific settings
# elif [ -n "$ZSH_VERSION" ]; then
#     echo "Testing Zsh-specific settings:"

#     # Check extended glob and history verify options
#     echo -n "EXTENDED_GLOB is "
#     [[ -o extendedglob ]] && echo "enabled" || echo "disabled"

#     echo -n "HIST_VERIFY is "
#     [[ -o histverify ]] && echo "enabled" || echo "disabled"

#     # Check the prompt
#     echo "Prompt (PS1): $PS1"

#     # Check if vcs_info is autoloaded (bit harder to test directly, checking function existence)
#     echo -n "vcs_info function is "
#     whence -f vcs_info && echo "defined" || echo "not defined"
# fi
