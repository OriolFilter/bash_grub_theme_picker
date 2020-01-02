# bash_grub_theme_picker

## NOTES

	[Having to Improve code]


## HOW TO USE IT

	Run this with bash
	
	use "./theme_grub_swapper.sh"
	or
	use "bash theme_grub_swapper.sh"
	or
	use ". theme_grub_swapper.sh"

	In case you want to run in "silent/random mode" you must use as first argument "-r" or "-R", both arguments work in the same way (not full silence, but have minimal output)

	use "./theme_grub_swapper.sh -r"
	or
	use "bash theme_grub_swapper.sh -r"
	or
	use ". theme_grub_swapper.sh -r"


## IMPORTANT

	Each theme must contain a .pf2 file and a .conf file, by default the .pf2 file must be called "font32.pf2" and the .conf file must be called "theme.conf".
	To change the behavior you must change the variables "font_style_file_name=theme.pf2" to "font_style_file_name=ABC" where "ABC" must be replaced by your pf2 file, this also works to modify the "theme_conf" variable


### Generating a pf2 file from a ttf file

	In case you have a font file and want to transfer it to a pf2 use the command "grub-mkfont -o <output_name> -s [n] <font.ttf>" -o stands for output file (font.pf2) -s stans for size (32) <font.ttf> the font that you want to convert (fancy_font.ttf)

### README

	Grub theme picker script, feel free to share your opinion!

#### Thinks to do/improve over the time

	[Improve code (argument input)]

#### Errors to fix over the time

	[EMPTY]
