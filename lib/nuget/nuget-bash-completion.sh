# Bash completion script for invoke-operation
#
# To use, run the following:
#   source `pwd`/nuget_bash_completion.sh

#default nuget actions
actions="
 delete 
 install 
 list 
 pack 
 publish 
 push 
 setApiKey
 sources
 spec
 update
 help
"
#action parameters that apply to all nuget actions
allActions="
 -h 
 -Help 
 ?
"
#action parameters that apply to the delete action
deleteActions="
 -Source 
 -NoPrompt 
 -ApiKey
 ${allActions}
"
#action parameters that apply to the install action
installActions="
 -Source 
 -OutputDirectory 
 -Version 
 -ExcludeVersion 
 -Prerelease 
 ${allActions}
"
#action parameters that apply to the list action
listActions="
 -Source 
 -Verbose 
 -AllVersions 
 -Prerelease
 ${allActions}
"
#action parameters that apply to the pack action
packActions="
 -OutputDirectory    
 -BasePath           
 -Verbose            
 -Version            
 -Exclude          
 -Symbols            
 -Tool               
 -Build              
 -NoDefaultExcludes  
 -NoPackageAnalysis  
 -Properties       
 ${allActions}
"
#action parameters that apply to the publish action
publishActions="
 -Source
 ${allActions}
"
#action parameters that apply to the push action
pushActions="
 -CreateOnly 
 -Source     
 -ApiKey     
 ${allActions}
"
#action parameters that apply to the setApiKey action
setApiKeyActions="
 -Source
 ${allActions}
"
#action parameters that apply to the sources action
sourcesActions="
 -Name
 -Source
 ${allActions}
"
#action parameters that apply to the spec action
specActions="
 -AssemblyPath 
 -Force
 ${allActions}
"
#action parameters that apply to the update action
updateActions="
 -Source       
 -Id         
 -RepositoryPath 
 -Safe           
 -Self           
 -Verbose        
 -Prerelease    
 ${allActions}
"
#action parameters that apply to the help action
helpActions="
 -All 
 -Markdown
 ${allActions}
"
#directories where nuget packages can be found and used for auto completion when invoking the update action
nugetPackageDirectories="
./packages
${HOME}/.nuget/packages
"

_invoke_nuget_completion()
{
    local cur="${COMP_WORDS[COMP_CWORD]}"

    # Subcommand list
    [[ ${COMP_CWORD} -eq 1 ]] && {
        COMPREPLY=( $(compgen -W "${actions} ${allActions}" -- ${cur}) )
        return
    }

    # Find the previous non-switch word
    local prev_index=$((COMP_CWORD - 1))
    local prev="${COMP_WORDS[prev_index]}"
    while [[ $prev == -* ]]; do
        prev_index=$((--prev_index))
        prev="${COMP_WORDS[prev_index]}"
    done

    case "$prev" in
    # base commands for nuget
	help)
        # handle standard actions when preceded by help
		local opts=$(
			for o in ${actions[*]}; do
				[[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
			done
		)
        	COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
		return
	;;
        delete)
                local opts=$(
                        for o in ${deleteActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return
        ;;
	install)
                local opts=$(
                        for o in ${installActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return
	;;
	list)
                local opts=$(
                        for o in ${listActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return
	;;
        pack)
                local opts=$(
                        for o in ${packActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return	
	;;
        publish)
                local opts=$(
                        for o in ${publishActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        pack)
                local opts=$(
                        for o in ${packActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        push)
                local opts=$(
                        for o in ${pushActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        setApiKey)
                local opts=$(
                        for o in ${setApiKeyActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        sources)
                local opts=$(
                        for o in ${sourcesActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        spec)
                local opts=$(
                        for o in ${specActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
                return 
        ;;
        update)
		local packageNames=$(
			for dir in ${nugetPackageDirectories[*]}; do
				if test -d $dir; then 
					ls $dir | sed -e "s/\.dll//g"
 				fi
			done
		)
                local opts=$(
			for o in ${updateActions[*]}; do
                                [[ " ${COMP_WORDS[*]} " =~ " $o " ]] || echo "$o"
                        done
                )
                COMPREPLY=( $(compgen -W "${opts} ${packageNames}" -- ${cur}) )
                return 
        ;;

	*)
        	return
        ;;
    esac
}

complete -o bashdefault -o default -F _invoke_nuget_completion nuget  
