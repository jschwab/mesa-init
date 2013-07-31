# $Id: mesasdk_init.csh 187 2012-08-09 07:33:23Z townsend $

# The enviroment managment portions of these scripts were inspired by
# the scripts shipped with the python virtualenv package

# Check that MESASDK_ROOT is set

if ( ! ${?MESASDK_ROOT} ) then
    echo "mesasdk_init.csh: you need to set the MESASDK_ROOT environment variable"
endif

# Check architecture

if ( `${MESASDK_ROOT}/bin/mesasdk_arch_check.pl` != 'Y' ) then
    echo "mesasdk_init.csh: unsupported architecture"
endif

# Define an alias to deactivate the SDK
alias deactivatesdk 'test $?_OLD_MESASDK_PATH != 0 && setenv PATH "$_OLD_MESASDK_PATH" && unset _OLD_MESASDK_PATH; test $?_OLD_MESASDK_MANPATH != 0 && setenv MANPATH "$_OLD_MESASDK_MANPATH" && unset _OLD_MESASDK_MANPATH; test $?_OLD_MESASDK_MANPATH = 0 && test "\!:*" != "nondestructive" && unset MANPATH ; rehash; test $?_OLD_MESASDK_PGPLOT_DIR != 0 && set PGPLOT_DIR="$_OLD_MESASDK_PGPLOT_DIR" && unset _OLD_MESASDK_PGPLOT_DIR; test $?_OLD_MESASDK_PROMPT != 0 && set prompt="$_OLD_MESASDK_PROMPT" && unset _OLD_MESASDK_PROMPT; test "\!:*" != "nondestructive" && unalias deactivatesdk'

# make the script idempotent by calling deactivate nondestructively
deactivatesdk nondestructive

# Save old paths & set new paths

set _OLD_MESASDK_PATH="$PATH"
setenv PATH "${MESASDK_ROOT}/bin:${PATH}"

if ( ${?MANPATH} ) then
    set _OLD_MESASDK_MANPATH="$MANPATH"
    setenv MANPATH "${MESASDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MESASDK_ROOT}/share/man:"
endif

# force new paths to take effect
rehash

# take care of PGPLOT
set _OLD_MESASDK_PGPLOT_DIR="$PATH"
setenv PGPLOT_DIR "${MESASDK_ROOT}/pgplot"

# Alter the command prompt unless instructed not to
if ( ! ${?MESASDK_DISABLE_PROMPT} ) then
    set _OLD_MESASDK_PROMPT="$prompt"
    set prompt = "[mesasdk] $prompt"
endif
