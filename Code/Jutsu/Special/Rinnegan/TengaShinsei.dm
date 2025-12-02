obj/SkillCards/Clan/Rinnegan/TengaShinsei
	icon_state="card_TengaShinsei"
	cmdstring="TengaShinsei"
	CCost=20000
	Seals=0
	DM = 4
	Range = 2
	Cooldown=2000
	CooldownCur=2000
	UpgradeMax=0

	Description = list(
		"about"="Crush the land with and immense piece of mass from the sky"
		,"title"="Tenga Shinsei"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.HasRinnegan)
			U << "You do not have the power of the Rinnegan to use this technique"
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("TengaShinsei",(CooldownCur*U.cooldownmultiplier)+s)) return
		var/turf/T = U.loc
		if(U.Targeting)
			var/mob/M = U.Targeting
			T = M.loc
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		if(prob(U.ChakraControl))
			U.JutsuSeals(s); U.JutsuTai(c*0.1); U.JutsuNin(c*0.14); U.MoveUses[name]++
			U.JutsuUseChakra(c);
			U.JutsuMessage("Tenga Tensei")
			U.firing = 0
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.TengaiShinsei(T)
		else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob
	proc
		TengaiShinsei(turf/T = loc)
			new/Effect/Visual/TengaiShinsei(T,src)