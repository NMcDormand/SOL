mob/var
	//ThankedJashin
	tmp
		ThankedJashin
		BloodAquired=list()
		CeremonialVictim

mob/proc
	AquireBlood(mob/M)
		if(M in BloodAquired) return
		BloodAquired+=M
		sleep(600)
		if(M in BloodAquired)
			BloodAquired-=M

/*
mob/VerbHolder/Jutsu/Class/verb

	ThankJashin()
		set category="Taijutsu"
		set name="Thank Jashin"
		set desc="Perform the rites of the Jashin cult and unlock your skeletal form."
		if(GENERICATTACKCHECK(usr)||MoveCheck(U)) return
		if(!usr.ThankedJashin) {usr<<"You must give thanks to glorious Jashin before you can do this."; return}
		var/mob/m=input("Consume who's blood?","Shijihyouketsu") as null|anything in usr.BloodAquired
		if(m)
			usr.firing=1
			usr<<"You consume [m]'s blood."
			usr.CeremonialVictim=m
			//create symbol on floor
			//turn skeletal
			//give the masochist verb
*/

obj/JashinSymbol
	icon='JashinSymbol.dmi'
	icon_state="drawing1"
	New()
		//spawn(200) del(src)

proc/createSymbol(mob/player)
	//Set the symbol on the ground
	var/obj/JashinSymbol/Symbol = new/obj/JashinSymbol/(player.loc)

	//Return here each check
	tryAgain
	spawn(20)
		//Check to see if the player is still online & still inside the circle
		if(player && player.ThankedJashin && player.CeremonialVictim) {goto tryAgain}
		//Otherwise delete the symbol off the ground (ensures it isn't left around)
		else {del(Symbol)}

obj/Item/Class/Scythe
	name="Scythe"
	trueName="Scythe"
	icon='Hidansscythe.dmi'
	icon_state="inventory"
	price=0
	tradeable=0
	Unbreakable=1
	atkspeed=5
	wielding="Jashin Scythe"
	Durability=99999999
	MaxDurability=99999999
	layer = WEAPON_LAYER
	Click()
		if(src in usr.contents)
			if(OnSpeedRail) Equip_Remove()
			else usr.ItemStats(src)
	verb
		Equip_Remove()
			set name="Equip/Remove"
			usr.EquipRemove_Weapon(src,icon)