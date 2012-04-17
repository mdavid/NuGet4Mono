#!/bin/bash -e

function die()
{
    echo "${@}"
    exit 1
}

for i in $HOME/.nugetrc; do
  if [[ ( -e $i ) || ( -h $i ) ]]; then
    echo "${i} has been renamed to ${i}.old"
    mv "${i}" "${i}.old" || die "Could not move ${i} to ${i}.old"
  fi
done

# Clone NuGet4Mono into .nuget
git clone https://github.com/mdavid/NuGet4Mono.git $HOME/.nuget \
  || die "Could not clone the repository to ${HOME}/.nuget"

# Run setup.sh inside .nuget
cd $HOME/.nuget || die "Could not go into the ${HOME}/.nuget"
./setup.sh || die "Make failed."
