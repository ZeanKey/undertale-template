// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function lang_custom() {
	#macro LANG_PATH_BASE "./locale/"
	#macro LANG_PATH_STRING	"string/"
	#macro LANG_PATH_SPRITE "sprite.txt"
	#macro LANG_PATH_FONT "font.txt"
}

function lang_getString(filename,LANG,key)
{
	ini_open(LANG_PATH_BASE+LANG+"/"+LANG_PATH_STRING+filename);
	var result=ini_read_string("main",key,undefined);
	ini_close()
	
	return(result)
}