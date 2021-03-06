#!/bin/bash


##Variables
#Grub
grub_folder="/boot/grub/"
grub_file_name="grub.cfg"
grub_tmp=$grub_folder"grub.tmp"
grub_file=$grub_folder$grub_file_name

#Themes
Themes_folder="/boot/grub/themes/"
Themes_var="$Themes_folder\$Theme/"

#Theme_files
font_style_file_name="font32.pf2"
theme_conf_file_name="theme.txt"
##################################################################################
################################FUNCTIONS#########################################
##################################################################################

check_if_rdy()
{
ready=$(cat $grub_file | grep -q ^Theme= && echo true || echo false)
if [[ "$ready" == "false" ]];then
	printf "\nThe file $grub_file is not ready\nWould you like me to fix it?\n(Y)es, (N)o\n"
	read fix
	if [[ "$fix" == "Y" || "$fix" == "y" || "$fix" == "Yes" || "$fix" == "yes" ]];then
		printf "\nfixing file"
		fix_file
		check_if_rdy
	elif [[ "$fix" == "N" || "$fix" == "n" || "$fix" == "No" || "$fix" == "no" ]]; then
		echo "Exiting ..."
	else
		printf "Didn't recognize the input or it wasnt a desired one\naborting...\n"
	fi
else
	ask_theme
fi
##END
}

fix_file()
{
printf "..."
echo "Theme=" > $grub_tmp && cat $grub_file >> grub_tmp ##create_tmp_file
fix_loadfont
}

fix_loadfont()
{
printf "..."
loadfont_filter="$(cat $grub_tmp | grep ^loadfont)"
echo "sed -i 's*$loadfont_filter*loadfont (\$root)"$Themes_var$font_style_file_name"*g' $grub_tmp" | bash /dev/stdin
#echo "tryed to fix 'loadfont'"
printf "..."
fix_set_theme
}


fix_set_theme()
{
printf "..."
set_theme_filter="$(cat $grub_tmp | grep '^set theme')"
echo "sed -i 's*$set_theme_filter*set theme=(\$root)"$Themes_var$theme_conf_file_name"*g' $grub_tmp" | bash /dev/stdin
#echo "tryed to fix 'set home'"
save_changes
}

save_changes()
{
printf "..."
cp $grub_tmp $grub_file && rm $grub_tmp #saves_changes (maybe it overwrites your grub without touch it... gl!)
}

check_random()
{
if [[ "$1" == "-r" || "$1" == "-R" ]]; then
	printf "Magic's done! You selected: "
	silent='>/dev/null'
	random=true
elif [[ "$1" == "-s" || "$1" == "-S" ]]; then
	silent='>/dev/null'
	fullsilent='>/dev/null'
	random=true
fi
check_if_rdy
}

get_theme()
{
Theme_selected="$(ls -l1 /boot/grub/themes/ | tr ' ' ':' | cut -f 10 -d ':' | nl | awk '$1'==$N | cut -f 2)"
echo "printf '\nYou selected $Theme_selected as a Grub theme\n'" $silent | bash /dev/stdin
if [[ "$random" == "true" ]]; then
	echo "printf '$Theme_selected\n' $fullsilent" | bash /dev/stdin
fi
replace
}


list_themes()
{
echo "printf '\nlisting Themes aviable\n'" $silent | bash /dev/stdin
echo "ls -l1 $Themes_folder | tr ' ' ':' | cut -f 10 -d ':' | nl" $silent | bash /dev/stdin && echo "printf '\n'" $silent | bash /dev/stdin
#get_max_number
max="$(ls -l1 $Themes_folder | tr ' ' ':' | cut -f 10 -d ':' | nl | sort -r | head -n 1 | cut -f 1)"
}


#Search for a lane that starts with "Theme=", stores it, then uses it to find it and replace it for a new line with the updated grub

filter()
{
filter_theme=$(cat $grub_file | grep ^Theme= )
#echo $filter_theme #Debugg
}


ask_theme() #meansasknumber
{
echo "printf \"\nplease select one theme from the list, or insert 0 to exit\n$silent\" $silent" | bash /dev/stdin
list_themes

if [[ "$random" == "true" ]];then
	N="$(echo shuf -i \"1-$max\" -n 1 | bash /dev/stdin)"
else
	read N
fi

while  [[ $N -lt 0 || $N -gt $max ]]; do
	if [ $N -lt 0 ]; then
		echo "you must select a number equal or higher than 0!"
	else
		echo "you must select a number in the range showed up!"
	fi
	read N
	echo ""
	echo "please select one theme from the list, or insert 0 to exit"
	list_themes
done

if [ $N -ne 0 ] ; then
	get_theme
else
	echo "Thanks for using this program!"
fi
}

#CHANGE "Theme" variable in grub.conf
replace()
{
filter
echo "sed -i 's/$filter_theme/Theme=$Theme_selected/g' $grub_file" | bash /dev/stdin
}


########
#MAIN#####
############

check_random "$1" ##start here

#cat $grub_file | grep ^Theme= #Debugg, filter grub.conf to display the variable line, so the value can be checked.

##End
