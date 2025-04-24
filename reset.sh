#!/bin/bash

# ----------------------------------------------------------------------------
# -- Description: 
#
#    Performing an environmental reset. Everytime I need to setup a new Linux OS 
#    I can run this script. 
#
# BACK UP FILES
#     Projects/
#     Theory/
#     Browser Bookmarks
#
# -- Details:
#    kcmshell5 kwalletconfig5: to disable kde wallet
# ----------------------------------------------------------------------------

function usage {
    printf "reset.sh [options ...]\n"
    printf "\t-a | --all      : set all options above\n"
    printf "\t-b | --basic    : basic tools\n"
    printf "\t-d | --doc      : documentation tools\n"
    printf "\t-e | --extra    : diverse tools\n"
    printf "\t-g | --gui      : GUI frameworks and related stuffs\n"
    printf "\t-l | --lang     : programming languages\n"
    printf "\t-m | --mbed     : embedded toolchain\n"
    printf "\t-n | --nvim     : neovim and toolchains\n"
    printf "\t-u | --upto     : update toolchains\n"
    printf "\t-s | --security : diverse security relevant tools\n"
}

if [ "$#" -lt "1" ]; then
    echo "Provide options to execute script..."
    usage;
    exit 1;
else
    source functions
    while [[ $# -gt 0 ]]
    do
        for arg in $1; do
            test "$arg" = "--all" || test "$arg" = "-a" && arg="bndglmes"
            for option in $(grep -o . <<< $arg); do
                case $option in
                    b) notify "TASK" "OPTION -b --basic: BASIC TOOLS"
                        install_core
                        ;;
                    n) notify "TASK" "OPTION -n --nvim: NEOVIM & TOOLCHAINS"
                        install_neovim || notify "ERROR" "COULD NOT INSTALL NEOVIM!"
                        ;;
                    u) notify "TASK" "OPTION -t --upto: UPDATE TOOLCHAINS"
                        echo "Update the Kitty terminal?"
                        select yn in "Yes" "No"; do
                            case $yn in
                                Yes ) install_kitty || notify "ERROR" "COULD NOT UPDATE KITTY!"
                                      break;;
                                No  ) break;;
                            esac
                        done
                        echo "Update Neovim to nightly?"
                        select yn in "Yes" "No"; do
                            case $yn in
                                Yes ) build_neovim || notify "ERROR" "COULD NOT UPDATE NEOVIM!"
                                      break;;
                                No  ) break;;
                            esac
                        done
                        echo "Update CCLS for C++?"
                        select yn in "Yes" "No"; do
                            case $yn in
                                Yes ) install_ccls || notify "ERROR" "COULD NOT UPDATE CODING TOOCHAINS!";
                                      break;;
                                No  ) break;;
                            esac
                        done
                        echo "Update CPPCHECK for C++?"
                        select yn in "Yes" "No"; do
                            case $yn in
                                Yes ) install_cppcheck || notify "ERROR" "COULD NOT UPDATE CODING TOOCHAINS!";
                                      break;;
                                No  ) break;;
                            esac
                        done
                        ;;
                    d) notify "TASK" "OPTION -d --doc: DOCUMENTATION TOOLS"
                        install_doctools
                        ;;
                    g) notify "TASK" "OPTION -g --gui: GUI FRAMEWORKS"
                        install_gui
                        ;;
                    l) notify "TASK" "OPTION -l --lang: PROGRAMMING LANGUAGES"
                        install_languages
                        ;;
                    m) notify "TASK" "OPTION -m --mbed: EMBEDDED TOOLCHAINS"
                        install_embedded
                        ;;
                    e) notify "TASK" "OPTION -e --extra: DIVERSE TOOLS"
                        install_others
                        ;;
                    s) notify "TASK" "OPTION -s --security: SECURITY RELEVANT TOOLS"
                        notify "WARNING" "Still not implemented - NOT DONE " "$@"
                        ;;
                esac
            done
        done
        shift 1; 
    done 
fi
