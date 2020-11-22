#!/usr/bin/env bash
#Modified script from https://github.com/Mayccoll/Gogh

mkdir -p "$HOME/.jirkafm/my-env"
cd "$HOME/.jirkafm/my-env"
if [ ! -d 'gogh' ] ; then
		git clone https://github.com/Mayccoll/Gogh.git gogh
fi
cd gogh/themes

# List of terminals
TERMINALS='mate-terminal tilix'

# List of color themes
THEMES='gruvbox-dark clone-of-ubuntu paraiso-dark'

# Default theme
DEFAULT_THEME='gruvbox-dark'

function setThemeInDconf
{
	profile_id=$(dconf dump "$profiles_path" | 
			egrep '\[[0-9A-Za-z\-]+\]|visible-name=' |  
			grep -B1 "${profile_name}" | 
			grep -o '\[.*\]' | 
			sed 's/[][]//g')
	dconf write "$default_profile_key" \"$profile_id\"
}

function setDefaultTheme {
	profile_name=$(grep 'PROFILE_NAME' ./"$theme.sh" | cut -d'"' -f 2)

	case $term in
		mate-terminal)
			profiles_path='/org/mate/terminal/profiles/'
			default_profile_key='/org/mate/terminal/global/default-profile'
			setThemeInDconf
			;;
		tilix)
			profiles_path='/com/gexperts/Tilix/profiles/'
			default_profile_key='/com/gexperts/Tilix/profiles/default'
			setThemeInDconf
			;;
		*)
			echo "Unsupported terminal: $term"
	esac
}

# Install color themes for each terminal
for term in $TERMINALS; 
do 
	export TERMINAL=$term
	for theme in $THEMES;
	do
		./"$theme.sh"
		if [ $theme = $DEFAULT_THEME ]; then
			setDefaultTheme
		fi
	done
done

