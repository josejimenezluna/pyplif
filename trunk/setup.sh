#!/bin/bash

# A script to copy the pyplif to hidden folder inside
# HOME folder then add a 'command-line shortcut'
# to PyPLIF inside that hidden folder.
if [ $1 > 0 ]  ; then
    if  [ $1 = 'uninstall' ]; then
        if [ -e $HOME/.pyplif ]; then
            rm -r $HOME/.pyplif
            gawk '$0 !~/alias pyplif/ { print $0 }' $HOME/.bashrc > .bashrc.tmp
            cat .bashrc.tmp > $HOME/.bashrc
            rm .bashrc.tmp
            echo "PyPLIF has been successfully uninstalled"
        else
            echo "PyPLIF never been installed before"
        fi
    elif [ $1 = 'force' ]; then
        if [ -e $HOME/.pyplif ]; then
            rm -r $HOME/.pyplif
        else
            echo "alias pyplif='$HOME/.pyplif/pyplif.py'" >> $HOME/.bashrc
        fi
        cp -r pyplif $HOME/.pyplif
        chmod +x $HOME/.pyplif/pyplif.py
        echo "PyPLIF successfully installed"
    else
        echo "Wrong Argument"
    fi
else  
    if  `cat $HOME/.bashrc | grep 'pyplif'`; then
        echo "PyPLIF is already installed"
        exit
    else
        if [ -e $HOME/.pyplif ]; then
            rm -r $HOME/.pyplif
        fi
        cp -r pyplif $HOME/.pyplif
        chmod +x $HOME/.pyplif/pyplif.py
        echo "alias pyplif='$HOME/.pyplif/pyplif.py'" >> $HOME/.bashrc
        echo "PyPLIF successfully installed"
    fi
fi
