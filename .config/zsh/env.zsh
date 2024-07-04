#!/usr/bin/env bash

export EDITOR=vim
# so dark mode is checked from gsettings
# except we got gtk portal working so not needed
#export ADW_DISABLE_PORTAL=1
export ANDROID_HOME=~/Android/Sdk
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
pa() { export PATH="$PATH:$1" }  
pa ~/.local/share/coursier/bin
pa ~/.cargo/bin
pa ~/.local/bin
pa ~/.deno/bin
pa ~/.jbang/bin
pa $ANDROID_HOME/emulator
pa $ANDROID_HOME/platform-tools
pa $ANDROID_HOME/cmdline-tools/latest/bin
