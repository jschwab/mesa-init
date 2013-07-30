# $Id: mesasdk_init.sh 187 2012-08-09 07:33:23Z townsend $

# Check that MESASDK_ROOT is set

if [[ -z "$MESASDK_ROOT" ]]; then
    echo "mesasdk_init.sh: you need to set the MESASDK_ROOT environment variable"
fi

# Check architecture

if [ `${MESASDK_ROOT}/bin/mesasdk_arch_check.pl` != 'Y' ]; then
    echo "mesasdk_init.sh: unsupported architecture"
fi

# Set paths

export PATH="${MESASDK_ROOT}/bin:${PATH}"
export MANPATH="${MESASDK_ROOT}/share/man:${MANPATH}"

export PGPLOT_DIR="${MESASDK_ROOT}/pgplot"
