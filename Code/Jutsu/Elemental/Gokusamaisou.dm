obj/Jutsu/Gokusamaisou
	icon='Gokusamaisou.dmi'
	Centre
		icon_state="3,3"
		New()
			spawn()
				var/obj/Jutsu/Gokusamaisou/A1/a1=new/obj/Jutsu/Gokusamaisou/A1(loc)
				var/obj/Jutsu/Gokusamaisou/A2/a2=new/obj/Jutsu/Gokusamaisou/A2(loc)
				var/obj/Jutsu/Gokusamaisou/A3/a3=new/obj/Jutsu/Gokusamaisou/A3(loc)
				var/obj/Jutsu/Gokusamaisou/A4/a4=new/obj/Jutsu/Gokusamaisou/A4(loc)
				var/obj/Jutsu/Gokusamaisou/A5/a5=new/obj/Jutsu/Gokusamaisou/A5(loc)
				var/obj/Jutsu/Gokusamaisou/B1/b1=new/obj/Jutsu/Gokusamaisou/B1(loc)
				var/obj/Jutsu/Gokusamaisou/B2/b2=new/obj/Jutsu/Gokusamaisou/B2(loc)
				var/obj/Jutsu/Gokusamaisou/B3/b3=new/obj/Jutsu/Gokusamaisou/B3(loc)
				var/obj/Jutsu/Gokusamaisou/B4/b4=new/obj/Jutsu/Gokusamaisou/B4(loc)
				var/obj/Jutsu/Gokusamaisou/B5/b5=new/obj/Jutsu/Gokusamaisou/B5(loc)
				var/obj/Jutsu/Gokusamaisou/C1/c1=new/obj/Jutsu/Gokusamaisou/C1(loc)
				var/obj/Jutsu/Gokusamaisou/C2/c2=new/obj/Jutsu/Gokusamaisou/C2(loc)
				var/obj/Jutsu/Gokusamaisou/C4/c4=new/obj/Jutsu/Gokusamaisou/C4(loc)
				var/obj/Jutsu/Gokusamaisou/C5/c5=new/obj/Jutsu/Gokusamaisou/C5(loc)
				var/obj/Jutsu/Gokusamaisou/D1/d1=new/obj/Jutsu/Gokusamaisou/D1(loc)
				var/obj/Jutsu/Gokusamaisou/D2/d2=new/obj/Jutsu/Gokusamaisou/D2(loc)
				var/obj/Jutsu/Gokusamaisou/D3/d3=new/obj/Jutsu/Gokusamaisou/D3(loc)
				var/obj/Jutsu/Gokusamaisou/D4/d4=new/obj/Jutsu/Gokusamaisou/D4(loc)
				var/obj/Jutsu/Gokusamaisou/D5/d5=new/obj/Jutsu/Gokusamaisou/D5(loc)
				var/obj/Jutsu/Gokusamaisou/E1/e1=new/obj/Jutsu/Gokusamaisou/E1(loc)
				var/obj/Jutsu/Gokusamaisou/E2/e2=new/obj/Jutsu/Gokusamaisou/E2(loc)
				var/obj/Jutsu/Gokusamaisou/E3/e3=new/obj/Jutsu/Gokusamaisou/E3(loc)
				var/obj/Jutsu/Gokusamaisou/E4/e4=new/obj/Jutsu/Gokusamaisou/E4(loc)
				var/obj/Jutsu/Gokusamaisou/E5/e5=new/obj/Jutsu/Gokusamaisou/E5(loc)
				var/x1=x-2; var/x2=x-1; var/x4=x+1; var/x5=x+2
				var/y1=y-2; var/y2=y-1; var/y4=y+1; var/y5=y+2
				a1.x=x1; b1.x=x1; c1.x=x1; d1.x=x1; e1.x=x1
				a2.x=x2; b2.x=x2; c2.x=x2; d2.x=x2; e2.x=x2
				a3.x=x; b3.x=x; d3.x=x; e3.x=x
				a4.x=x4; b4.x=x4; c4.x=x4; d4.x=x4; e4.x=x4
				a5.x=x5; b5.x=x5; c5.x=x5; d5.x=x5; e5.x=x5

				a1.y=y1; a2.y=y1; a3.y=y1; a4.y=y1; a5.y=y1
				b1.y=y2; b2.y=y2; b3.y=y2; b4.y=y2; b5.y=y2
				c1.y=y; c2.y=y; c4.y=y; c5.y=y
				d1.y=y4; d2.y=y4; d3.y=y4; d4.y=y4; d5.y=y4
				e1.y=y5; e2.y=y5; e3.y=y5; e4.y=y5; e5.y=y5

				TailList+=a1; TailList+=a2; TailList+=a3; TailList+=a4; TailList+=a5
				TailList+=b1; TailList+=b2; TailList+=b3; TailList+=b4; TailList+=b5
				TailList+=c1; TailList+=c2; TailList+=c4; TailList+=c5
				TailList+=d1; TailList+=d2; TailList+=d3; TailList+=d4; TailList+=d5
				TailList+=e1; TailList+=e2; TailList+=e3; TailList+=e4; TailList+=e5
		Del()
			for(var/obj/o in TailList) del(o)
			..()

	A1
		icon_state="1,1"
	A2
		icon_state="2,1"
	A3
		icon_state="3,1"
	A4
		icon_state="4,1"
	A5
		icon_state="5,1"
	B1
		icon_state="1,2"
	B2
		icon_state="2,2"
	B3
		icon_state="3,2"
	B4
		icon_state="4,2"
	B5
		icon_state="5,2"
	C1
		icon_state="1,3"
	C2
		icon_state="2,3"
	C4
		icon_state="4,3"
	C5
		icon_state="5,3"
	D1
		icon_state="1,4"
	D2
		icon_state="2,4"
	D3
		icon_state="3,4"
	D4
		icon_state="4,4"
	D5
		icon_state="5,4"
	E1
		icon_state="1,5"
	E2
		icon_state="2,5"
	E3
		icon_state="3,5"
	E4
		icon_state="4,5"
	E5
		icon_state="5,5"