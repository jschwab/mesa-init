# The enviroment managment portions of these scripts were inspired by
# the scripts shipped with the python virtualenv package

# Check that MESASDK_ROOT is set

if [[ -z "$MESASDK_ROOT" ]]; then
    echo "mesasdk_init.sh: you need to set the MESASDK_ROOT environment variable"
fi

# Check architecture

if [ `${MESASDK_ROOT}/bin/mesasdk_arch_check.pl` != 'Y' ]; then
    echo "mesasdk_init.sh: unsupported architecture"
fi

# Define a function to deactivate the SDK

deactivatemesasdk () {

    # reset old environment variables

    # reset the paths
    if [ -n "$_OLD_MESASDK_PATH" ] ; then
        PATH="$_OLD_MESASDK_PATH"
        export PATH
        unset _OLD_MESASDK_PATH
    fi

    if [ -n "$_OLD_MESASDK_MANPATH" ] ; then
        MANPATH="$_OLD_MESASDK_MANPATH"
        export MANPATH
        unset _OLD_MESASDK_MANPATH
    else
        if [ ! "$1" = "nondestructive" ] ; then
            unset MANPATH
        fi
    fi

    # force new paths to take effect
    hash -r 2>/dev/null

    # take care of PGPLOT
    if [ -n "$_OLD_MESASDK_PGPLOT_DIR" ] ; then
        PGPLOT_DIR="$_OLD_MESASDK_PGPLOT_DIR"
        export PGPLOT_DIR
        unset _OLD_MESASDK_PGPLOT_DIR
    fi

    # reset the command prompt
    if [ -n "$_OLD_MESASDK_PS1" ] ; then
        export PS1="$_OLD_MESASDK_PS1"
        unset _OLD_MESASDK_PS1
    fi

    # Self destruct!
    if [ ! "$1" = "nondestructive" ] ; then
        unset -f deactivatesdk
    fi
}

# make the script idempotent by calling deactivate nondestructively
deactivatemesasdk nondestructive

# Save old paths & set new paths

_OLD_MESASDK_PATH="$PATH"
export PATH="${MESASDK_ROOT}/bin:${PATH}"

if [ -n ${MANPATH} ]; then
    _OLD_MESASDK_MANPATH="$MANPATH"
fi
export MANPATH="${MESASDK_ROOT}/share/man:${MANPATH}"

# force new paths to take effect
hash -r 2>/dev/null

# take care of PGPLOT
_OLD_MESASDK_PGPLOT_DIR="$PGPLOT_DIR"
export PGPLOT_DIR="${MESASDK_ROOT}/pgplot"

# Alter the command prompt unless instructed not to
if [ -z "$MESASDK_DISABLE_PROMPT" ] ; then
    _OLD_MESASDK_PS1="$PS1"
    export PS1="[mesasdk] $PS1"
fi
