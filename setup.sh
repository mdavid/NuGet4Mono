#!/bin/bash -e

NUGETROOT=$HOME/.nuget
PREFIX=/usr/local
COMPLETIONBASEDIR=$PREFIX/etc/
COMPLETIONSDIR=$COMPLETIONBASEDIR/bash-completion.d
COMPLETIONSCRIPT=$COMPLETIONBASEDIR/bash_completion

INSTALLWITHBREW=true
hash brew 2>&- || { 
  INSTALLWITHBREW=false;
  git submodule update --init
  cd lib/module/bash-completion && aclocal && autoconf && automake && ./configure --prefix=/usr/local
  make install
}
if [ $INSTALLWITHBREW ]; then
  brew install bash-completion
fi

ln -s "`pwd`/lib/nuget/nuget-bash-completion.sh" "$COMPLETIONSDIR"

. $COMPLETIONSCRIPT

append_bash_profile() {
cat <<EOF
if [ -f $COMPLETIONSCRIPT ]; then
  $COMPLETIONSCRIPT
fi
EOF
}

append_bash_profile >> $USER/.bash_profile
