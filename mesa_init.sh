# useful functions for working with MESA

mkworkdir () {
    cp -r $MESA_DIR/star/work $1
}

chmesadir () {
    case $1 in
        git)
            export MESA_DIR=/home/jschwab/Software/mesa
            export MESA_PS1_ID="git"
            ;;
        git-svn)
            export MESA_DIR=/home/jschwab/Software/mesa-git-svn
            export MESA_PS1_ID="git-svn"
            ;;
        svn)
            export MESA_DIR=/home/jschwab/Software/mesa-svn
            export MESA_PS1_ID="svn"
            ;;
        r6794)
            export MESA_DIR=/home/jschwab/Software/mesa-r6794
            export MESA_PS1_ID="r6794"
            ;;
        r6596)
            export MESA_DIR=/home/jschwab/Software/mesa-r6596
            export MESA_PS1_ID="r6596"
            ;;
        *)
            echo "unknown MESA_DIR"
    esac
}

__mesa_ps1 () {
    if [ -n "$MESASDK_ACTIVE" ]; then
        printf -- "[%s:mesasdk] " $MESA_PS1_ID
    fi
}

export MESA_PS1_ID="default"
