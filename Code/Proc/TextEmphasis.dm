/*
//Change any of these to specify the symbol, and comment out the line to remove
// that form of emphasis.
#define EMPHASISE_ITALICS   "/"
#define EMPHASISE_UNDERLINE "_"
#define EMPHASISE_BOLD      "+"


//You don't have to modify anything below this point.


proc/emphasise(string as text)
	var/pos = 0
	var/pos2 = 0
	var/minpos = 0

#ifdef EMPHASISE_ITALICS
    //Italicise
	pos = findtext(string,EMPHASISE_ITALICS)
	while(pos)
		pos2 = findtext(string,EMPHASISE_ITALICS,pos+1)
		minpos = pos2 + 4
		if(pos2)
			string = copytext(string,1,pos) + "<i>" + copytext(string,pos+1,pos2) + "</i>" + \
				copytext(string,pos2+1)
			pos = findtext(string,EMPHASISE_ITALICS,minpos)
		else
			break
#endif

#ifdef EMPHASISE_BOLD
    //Bold
	pos = findtext(string,EMPHASISE_BOLD)
	while(pos)
		pos2 = findtext(string,EMPHASISE_BOLD,pos+1)
		minpos = pos2 + 4
		if(pos2)
			string = copytext(string,1,pos) + "<b>" + copytext(string,pos+1,pos2) + "</b>" + \
				copytext(string,pos2+1)
			pos = findtext(string,EMPHASISE_BOLD,minpos)
		else
			break
#endif

#ifdef EMPHASISE_UNDERLINE
    //Underline
	pos = findtext(string,EMPHASISE_UNDERLINE)
	while(pos)
		pos2 = findtext(string,EMPHASISE_UNDERLINE,pos+1)
		minpos = pos2 + 4
		if(pos2)
			string = copytext(string,1,pos) + "<u>" + copytext(string,pos+1,pos2) + "</u>" + \
				copytext(string,pos2+1)
			pos = findtext(string,EMPHASISE_UNDERLINE)
		else
			minpos = 0
			break
#endif

	return string

*/


proc/mumble(string)
	var/new_string = ""

	var/stringlen = length(string)
	var/current_pos = 1
	var/new_pos = current_pos + rand(2,9)

	while(new_pos < stringlen && current_pos < stringlen)
		var/segment = copytext(string, current_pos, new_pos)
		//TODO: STRIP LEADING AND TRAILING PUNCTUATION AND SPACES FROM SEGMENT

		new_string += segment + "... " //show that text has been omitted
		current_pos = new_pos + rand(2,9) //randomly jump the next segment to a new point
		new_pos = current_pos + rand(2,9)
	if(current_pos < stringlen) new_string += copytext(string, current_pos)

	return new_string