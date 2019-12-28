# bash_grub_theme_picker

##NOTES
##Remember translate this to MD!
##

#############
##IMPORTANT###
###############
##Each theme must contain a .pf2 file and a .conf file
##by default the .pf2 file must be called "font32.pf2"
##and the .conf file must be called "theme.conf".
##To change the behavior you must change the variables
##"font_style_file_name=theme.pf2" to "font_style_file_name=ABC"
##where "ABC" must be replaced by your pf2 file,
##this also works to modify the "theme_conf" variable
##

###
###Generating a pf2 file from a ttf file
##in case you have a font file and want to transfer it to a pf2
##use the command "grub-mkfont -o <output_name> -s [n] <font.ttf>"
## -o stands for output file (font.pf2)
## -s stans for size (32)
## <font.ttf> the font that you want to convert (fancy_font.ttf)
########
###############

#####
###README
####
####add the atribute "-R" or "-r" to generate a random number in silence mode
####keep in mind that first gonna check if your grub.conf it's correct, if gurb.conf isn't correct,
####it will show the repair menú, so test it before you put it in a startup script
####Maybe it's better that if it's in "random/silence" mode it runs the fixer without ask


##Thinks to do/improve over the time


##Errors to fix over the time
