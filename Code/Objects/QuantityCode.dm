

proc/ItemQuantity(obj/m,QTY)
	if(!m) return
	var/l=length(QTY)	//QTY is the quantity of the items
	var/dx=0
	switch(l)	//this is how i decide the starting point
		if(1) dx=27		//if the length is 1 number then push it further right
		if(2) dx=18
		if(3) dx=9		//otherwise have it start out closer left
	for(var/a=1;a<=l;a++)//a<=l, l is the number of digits
		var/dx2=dx
		dx+=9	//each number spaced 9 apart
		spawn(0)
			var/obj/j=new/obj
			var/icon/s=new(m.icon)
			j.icon='Quantity.dmi'	//the icon with the numbers 0-9
			for(var/a2=0;a2<=2;a2++)//This will give the effect of the numbers moving upward
				j.icon_state="[copytext(QTY,a,a+1)]"//Sets the icon_states to the appropiate state
				j.pixel_x=dx2	//move 'j' to the right position
				s.Blend(j.icon,ICON_OVERLAY)
			return (s)