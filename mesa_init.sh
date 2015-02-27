# useful functions for working with MESA

mkworkdir () {
    cp -r $MESA_DIR/star/work $1
}

/home/jschwab/Software/mesasdk-init/config2bash ${HOME}/.mesainitrc > ${HOME}/.mesainitrc.bash
source ${HOME}/.mesainitrc.bash

__mesa_ps1 () {
    if [ -n "$MESASDK_ACTIVE" ]; then
        printf -- "[%s:mesasdk] " $MESA_PS1_ID
    fi
}

export MESA_PS1_ID="default"
