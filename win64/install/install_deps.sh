#!/bin/bash

pacman -S git mingw-w64-x86_64-toolchain mingw-w64-x86_64-SDL2 mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-SDL2_image mingw-w64-x86_64-SDL2_ttf mingw-w64-x86_64-SDL2_net mingw-w64-x86_64-cmake make mingw-w64-x86_64-SDL2_mixer mingw-w64-x86_64-SDL2_gfx mingw-w64-x86_64-civetweb
if [ $? -ne 0 ]; then
  echo "Failed to install dependencies"
  exit $?
fi