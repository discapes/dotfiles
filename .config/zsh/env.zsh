#!/usr/bin/env bash

export EDITOR=vim
export ANDROID_HOME=~/Android/Sdk
export ANDROID_SDK_ROOT="$ANDROID_HOME"
pa() { export PATH="$PATH:$1" }  
pa ~/.local/share/coursier/bin
pa ~/.cargo/bin
pa ~/.local/bin
pa ~/.deno/bin
pa ~/.jbang/bin
pa $ANDROID_HOME/emulator
pa $ANDROID_HOME/platform-tools
pa $ANDROID_HOME/cmdline-tools/latest/bin
