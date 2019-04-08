# The enviroment managment portions of these scripts were inspired by
# the scripts shipped with the python virtualenv package

# Check that MESASDK_ROOT is set

if [[ -z "$MESASDK_ROOT" ]]; then
    echo "mesasdk_init.sh: you need to set the MESASDK_ROOT environment variable"
    return 1
fi

# Check architecture

if [ ! -f "${MESASDK_ROOT}/etc/check_arch.done" ]; then
    echo "mesasdk_init.sh: checking architecture"
    if [ `${MESASDK_ROOT}/bin/mesasdk_arch_check` != 'Y' ]; then
    echo "mesasdk_init.sh: unsupported architecture"
	return 1
    fi
    touch "${MESASDK_ROOT}/etc/check_arch.done"
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

    #
    unset VALGRIND_LIB
    unset MESASDK_ACTIVE
    unset MESASDK_VERSION

    # Self destruct!
    if [ ! "$1" = "nondestructive" ] ; then
        unset -f deactivatemesasdk
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
export PGPLOT_DIR="${MESASDK_ROOT}/lib/pgplot"

# take care of valgrind
export VALGRIND_LIB="${MESASDK_ROOT}/lib/valgrind"

# indicate the SDK is active
export MESASDK_ACTIVE=t

# Set other environment variables
export MESASDK_VERSION=`${MESASDK_ROOT}/bin/mesasdk_version`
