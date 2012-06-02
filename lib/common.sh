source ~/.../lib/tracefuncs.sh
...filestart $0

source ~/.../lib/path-manip.sh

path-prepend ~/.../bin
path-prepend ~/bin

eval `... env`
...debug3 "Did eval `... env`"

export SHELLNAME=${SHELL##*/}

# Everything in ~/.sh and ~/.zsh (or ~/.bash)
for n in ~/.sh/* ~/.$SHELLNAME/*; do
    if [[ -d $n ]]; then
        ...debug2 "(Skipping $n because it's a directory)"
    else
        ...debug "Sourcing $n"
        source $n
    fi
done

# Then each dots-repo's .zshrc (or .bashrc)
for n in `echo $DOTDOTDOT_ORDER`; do
    local rc=$n/.${SHELLNAME}rc
    if [[ -e $rc ]]; then
        if grep 'source .*/\.\.\./lib/common.sh' $rc 2>&1 >/dev/null; then
            ...debug2 "(Wisely skipping $rc, to prevent a loop.)"
        else
            ...debug "Sourcing $rc"
            source $rc
        fi
    fi
done

sourceif() { if [ -f $1 ]; then . $1; fi }
...fileend $0
