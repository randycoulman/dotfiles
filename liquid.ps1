
######################################
# LIQUID PROMPT CUSTOM TEMPLATE FILE #
######################################

# Available features:
# LP_BATT battery
# LP_LOAD load
# LP_JOBS screen sessions/running jobs/suspended jobs
# LP_USER user
# LP_HOST hostname
# LP_PERM a colon ":"
# LP_PWD current working directory
# LP_VENV Python virtual environment
# LP_PROXY HTTP proxy
# LP_VCS the content of the current repository
# LP_ERR last error code
# LP_MARK prompt mark
# LP_TIME current time
# LP_RUNTIME runtime of last command
# LP_MARK_PREFIX user-defined prompt mark prefix (helpful if you want 2-line prompts)
# LP_PS1_PREFIX user-defined general-purpose prefix (default set a generic prompt as the window title)
# LP_PS1_POSTFIX user-defined general-purpose postfix
# LP_BRACKET_OPEN open bracket
# LP_BRACKET_CLOSE close bracket

# Remember that most features come with their corresponding colors,
# see the README.

LP_PS1="${LP_PS1_PREFIX}${LP_USER}${LP_HOST}${LP_PWD}\n"
LP_PS1="${LP_PS1}${LP_ERR}"
LP_PS1="${LP_PS1}${LP_BRACKET_OPEN}${LP_VCS}${LP_BRACKET_CLOSE}"
LP_PS1="${LP_PS1}${LP_MARK_PREFIX}${LP_MARK_DEFAULT} "

export LP_PS1

# vim: set et sts=4 sw=4 tw=120 ft=sh:
