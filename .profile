if [ -f .alias ]
then
	. .alias
fi

if [ -f .gitalias ]
then
	. .gitalias
fi
set -o vi
