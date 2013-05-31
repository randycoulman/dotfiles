# Top-level .bashrc file.
# This file just runs all of the appropriately named scripts in .bashrc.d.
# Make any desired changes by modifying one of these scripts, or creating a
# new one.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

main()
{
    run_scripts ~/.bashrc.d
}

run_scripts()
{
    for script in $1/*
    do
        # skip non-executable snippets
        [ -x "$script" ] || continue

        . $script
    done
}

main
