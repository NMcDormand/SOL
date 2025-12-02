obj/SkillCards/Class/Jashin/Shijihyouketsu
	icon_state="card_ConsumeBlood"
	cmdstring="Shijihyouketsu"
	JutsuType = "Class"
	Cooldown = 2800
	DM = 1
	Duration = 200

	Description=list(
		"about" = "Perform the rites of the Jashin cult and unlock your skeletal form.",
		,"title" = "Shijihyouketsu",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		if(!U.Class["Jashin"])
			U << "This technique is reserved for the glorious followers of the great Jashin"
			return
		if(GENERICATTACKCHECK(U)) return
		if(U.ThankedJashin) {U<<"You already have a ritual going at the moment!"; return}
		//Add a check to see if the user has already collected blood, otherwise let them know they have none.
		if(U.CooldownCheck("Shijihyouketsu",(CooldownCur*U.cooldownmultiplier),0)) return
		//if(!U.ThankedJashin) {U<<"You must give thanks to glorious Jashin before you can do this."; return}
		var/mob/m=input("Consume who's blood?","Shijihyouketsu") as null|anything in U.BloodAquired
		if(m)
			U.firing=1
			U.frozen=1
			//new/obj/JashinSymbol/(U.loc)
			createSymbol(U)
			U.ThankedJashin=1
			U<<"You consume [m]'s blood."
			U.CeremonialVictim=m
			U.firing=0
			U.icon='Base_Black.dmi'
			spawn(20) U.frozen=0
			spawn(Duration) {U.CeremonialVictim=null; U.ThankedJashin=0;U.CreationSkin()}
			..()
			//create symbol on floor
			//turn skeletal
			//give the masochist verb