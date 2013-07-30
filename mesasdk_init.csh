# $Id: mesasdk_init.csh 187 2012-08-09 07:33:23Z townsend $

# Check that MESASDK_ROOT is set

if ( ! ${?MESASDK_ROOT} ) then
    echo "mesasdk_init.csh: you need to set the MESASDK_ROOT environment variable"
endif

# Check architecture

if ( `${MESASDK_ROOT}/bin/mesasdk_arch_check.pl` != 'Y' ) then
    echo "mesasdk_init.csh: unsupported architecture"
endif

# Set paths

setenv PATH "${MESASDK_ROOT}/bin:${PATH}"
if ( ${?MANPATH} ) then
    setenv MANPATH "${MESASDK_ROOT}/share/man:${MANPATH}"
else
    setenv MANPATH "${MESASDK_ROOT}/share/man"
endif

setenv PGPLOT_DIR "${MESASDK_ROOT}/pgplot"
