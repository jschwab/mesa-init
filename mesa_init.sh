# this gets the location of this file
DIR="$(dirname ${BASH_SOURCE[0]})"

# translate the config file into bash functions
${DIR}/config2bash ${HOME}/.mesa_init > ${HOME}/.mesa_init.bash

# add those functions to the enviroment
source ${HOME}/.mesa_init.bash

# this can be used to control the appearance of the prompt
__mesa_ps1 () {

    local ps1_id

    # MESA_PS1_ID set -> MESA_PS1_ID
    # MESA_PS1_ID unset, MESA_DIR set -> "default"
    # MESA_PS1_ID unset, MESA_DIR unset -> "unset"
    
    if [ -z "${MESA_PS1_ID}" ];
    then
        if [ -n "${MESA_DIR}" ];
        then
            ps1_id="default"
        else
            ps1_id="unset"
        fi
    else
        ps1_id=${MESA_PS1_ID}
    fi

    if [ -n "${MESASDK_ACTIVE}" ]; then
        printf -- "[%s:mesasdk] " ${ps1_id}
    fi
}

# you may want to look at
#   https://github.com/wmwolf/mesa_cli
# for way more cool stuff
mkworkdir () {
    cp -r $MESA_DIR/star/work $1
}

