#!/bin/bash -e

NUGETROOT=$HOME/.nuget
PREFIX=$1/usr/local
COMPLETIONBASEDIR=$PREFIX/etc/
COMPLETIONSDIR=$COMPLETIONBASEDIR/bash-completion.d
COMPLETIONSCRIPT=$COMPLETIONBASEDIR/bash_completion

INSTALLWITHBREW=true
hash brew 2>&- || { 
  INSTALLWITHBREW=false;
  ISDEBIANBASED=true;
  if [ $ISDEBIANBASED ]; then
	BASHCOMPLETIONINSTALLED=$(dpkg-query -W -f='${Status} ${Version}\n' bash-completion | cut -d' ' -f2);
	echo $BASHCOMPLETIONINSTALLED;
  fi

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
