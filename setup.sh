#!/bin/bash -e

NUGETROOT=$HOME/.nuget
PREFIX=$1/usr/local
COMPLETIONBASEDIR=$PREFIX/etc
COMPLETIONSDIR=$COMPLETIONBASEDIR/bash_completion.d
COMPLETIONSCRIPT=$COMPLETIONSDIR/nuget-bash-completion

BASH_COMPLETION_INSTALLED_LOG_MODIFIER="";

log_info(){
	echo "INFO: $1"
}

log_error(){
	echo "ERROR: $1"
}

check_for_homebrew() {
	log_info "Checking for the existence of Homebrew..."
	hash brew 2>&- || {
		log_error "Homebrew is required. Please visit http://mxcl.github.io/homebrew/ for installation instructions.";
		exit 0;
	}
	log_info "Homebrew found."
}

install_bash_completion() {
	log_info "Checking for existence of bash-completion."
	brew install bash-completion 2>&1- || {
		BASH_COMPLETION_INSTALLED_LOG_MODIFIER="was previously";
	}
	log_info "bash-completion $BASH_COMPLETION_INSTALLED_LOG_MODIFIER installed";
}

symlink_and_source(){
	log_info "Symlinking nuget-bash-completion.sh."
	ln -sf "`pwd`/lib/nuget/nuget-bash-completion.sh" "$COMPLETIONSCRIPT" 2>&- || {
		log_info "`pwd`/lib/nuget/nuget-bash-completion.sh previously symlinked to $COMPLETIONSCRIPT";
	}
	log_info "Sourcing $COMPLETIONSCRIPT."
	. $COMPLETIONSCRIPT
}

append_bash_profile() {
	if ! grep $COMPLETIONSCRIPT $HOME/.bash_profile 1> /dev/null
		then
			log_info "Appending completion script inclusion to $HOME/.bash_profile"
			get_completion_script_bash_profile_text >> $HOME/.bash_profile
		else 
			log_info "Completion script already added to $HOME/.bash_profile"
	fi
}

get_completion_script_bash_profile_text(){
cat <<EOF
if [ -f $COMPLETIONSCRIPT ]; then
        $COMPLETIONSCRIPT
fi
EOF
}

check_for_homebrew
install_bash_completion
symlink_and_source
append_bash_profile
