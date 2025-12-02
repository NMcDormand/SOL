obj/Item/Profession
	Scythe
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
	Fan
		name="Fan"
		trueName="Fan"
		icon='Fan.dmi'
		icon_state="inventory"
		price=0
		tradeable=0
		Unbreakable=1
		atkspeed=5
		wielding="Fan"
		Durability=9999999
		MaxDurability=9999999
		layer = WEAPON_LAYER

obj/SkillCards/Profession
	icon_state="card_Kakuremino"
	cmdstring="Kakuremino"
	JutsuType = "Profession"
	Cooldown = 800
	CCost=400
	Seals=8

	Description= list(
		"about"="Cloak of Invisibility Technique"
		,"title"="Kakuremino no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
		,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")
	Assassin
		Kakuremino
		Meisaigakure
		MuonSatsujin
	Fan
		Daikamaitachi
		Kamaitachi
		Ookamaitachi
		TatsuOoshigoto
	H2H
		Oukashou
		TsuutenKyaku
	Jashin
		DamageSelf
		Shijihyouketsu
	Medical
		ChakranoMesu
		RanshinShou
		Shousen
		SliceTendons
	Sensory
		SenseArea
	Sword
		Mikazuki
	Clay
		ShiFo
		Katsu
		KibakuJirai
		KibakuNendo
		KyukyokuGeijutsu
	Sand
		SabakuSoso
		SunaYoroi
		SabakuKyou
		SunaBunshin
		SunaShuriken


Map/Furnace
	icon = 'PortaForge.dmi'
	icon_state = "Furnace"
	density  = 1
	layer = MOB_LAYER+1
	Action(mob/user)
		if(get_dist(user,src)>2) return
		var/msg = "<b>Smelting</b><br>Using the correct Materials you can heat and melt Mineral Ores to create a refined Ingot."
		msg +="<br>For <b>Single Mineral Metals</b> you need a minimum of 4 pieces of Ore <br>for <b>Multiple Mineral Metals</b> you will need a minimum of 4 pieces of the primary Ore and 2 pieces of the secondary (Example, Bronze needs 4 Copper Ore and 2 Tin Ore"
		msg += "<br>Each type of Ingot requires Coal to create Heat. A different amount Coal is necessary to burn the Ore enough to melt and create the Ingot"
		msg += "<br><br>To initiate use your \"Smelt\" Card or Verb within range of a Furnace, or Have over 2000 Fire Elemental, or have the Scorch Elemental"
		user << msg

obj/SkillCards/Starter/Smelt
	icon_state="card_Smelt"
	JutsuType = "Other"
	cmdstring="Smelt"
	CCost=50

	Description = list(
		"about"="Heat Ore and mix in to Ingots for crafting, This is done using Coal and a Mineral Ore. You need enough fire or be near a furnace to complete"
		,"title"="Smelt"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
//		,"pic"='Craft.png'
		)
	Activate(mob/U)
		if(U.firing||U.frozen||U.GMfrozen||U.fishing||U.waterprisoned||U.Coffin||U.dead||U.attacking||U.throwing) return
		if(U.Chakra<50) {U<<"Not enough chakra"; return}
		var/DOIT = 0
		if(usr.FireElemental > 2000 || U.ScorchElemental)
			DOIT = 1
		else
			var/Map/Furnace/FU = locate() in oview(5,U)
			if(FU && FU.loc.loc == U.loc.loc)
				DOIT = 1
		if(DOIT)
			U.firing=1
			//U.SmeltMe()
		else
			U << "You need to be near a Furnace or have over 2000 Fire Element to Smelt"
		spawn(8)U.firing=0

obj/Item/Material/Ingot
	Copper
	Tin
	Bronze
	Iron
	Steel
	Platinum
	Mithril
	Obsidian