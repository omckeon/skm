#!/bin/bash

APP_PATH=`echo $0 | awk '{split($0,patharr,"/"); idx=1; while(patharr[idx+1] != "") { if (patharr[idx] != "/") {printf("%s/", patharr[idx]); idx++ }} }'`
APP_PATH=`cd "$APP_PATH"; pwd`

SKM_PATH=`cd "$APP_PATH/../.."; pwd`

source "${SKM_PATH}/tools/set_sk_env_vars.sh"

if [ "$SK_OS" = "win64" ]; then
  : # All good - no op and continue
elif [ "$SK_OS" = "linux" ] ||  [ "$SK_OS" = "macos" ] || ( echo "${*}" | grep '\-\-no-os-detect' ); then
  echo "win64 install only available on Windows with MSYS2 MINGW64 shell"
  exit 1
else
    echo "Unable to detect operating system..."
    exit 1
fi

${APP_PATH}/install_deps.sh
if [ $? -ne 0 ]; then
  exit $?
fi

echo "Configuring SplashKit"
cd "${SKM_PATH}/source"
pwd
cmake -G "Unix Makefiles" .
if [ $? -ne 0 ]; then
  echo "Configuration failed"
  exit $?
fi

echo "Compiling SplashKit..."
make
if [ $? -ne 0 ]; then
  echo "Compilation failed"
  exit $?
fi

echo "Installing compiled SplashKit library..."
make install
if [ $? -ne 0 ]; then
  echo "Install failed"
  exit $?
fi

echo "SplashKit Installed"

"${SKM_PATH}/global/install/skm_global_install.sh"
