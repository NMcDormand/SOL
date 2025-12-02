/*
mob/player
	Stat()
		statpanel("Stats")
		stat("[usr.name]","[ZCoord] ([x],[y])")
		if(usr.Clan=="Inuzuka")
			var/mob/Hittable/Responsive/Animal/Pet/Dog/P=locate(/mob/Hittable/Responsive/Animal/Pet/Dog) in usr.contents
			if(P) stat("K-9:",P)
		stat("")
		stat("Stamina:","[num2text(round(usr.Stamina,1),9)]/[num2text(round(usr.StaminaMax,1),9)]")
		stat("Chakra:","[num2text(round(usr.Chakra,1),7)]/[num2text(round(usr.ChakraMax,1),7)]")
		stat("Wounds:","[round(Wounds)]")
		stat("Chakra Control:","[ChakraControl]%")
		stat("Seal Speed:","[SS/10] second(s)")
		stat("Taijutsu:","[round(Taijutsu)]")
		stat("Ninjutsu:","[round(Ninjutsu)]")
		stat("Genjutsu:","[round(Genjutsu)]")
		stat("Speed:","[abs(usr.setspeed-4)]/3")
		stat("Reflexes:","[abs((usr.Reflex-200))]")
		if(usr.Clan=="Taijutsu Specialist")
			stat("Gates Opened:","[usr.Gate]")
		if(usr.Clan=="Aburame")
			stat("Bugs:","[num2text(round(Konchuuamount,1),9)]")
		stat("")
		var/mob/Hittable/Responsive/Animal/Pet/D=usr.Familiar
		if(D)
			stat("[D]'s Stamina:","[num2text(round(D.Stamina,1),9)]/[num2text(round(D.StaminaMax,1),9)]")
			stat("[D]'s Wounds:","[round(D.Wounds)]")
			stat("[D]'s Taijutsu:","[round(D.Taijutsu)]")
			stat("")
		if(usr.PE=="Fire")
			stat("Primary Element - Fire:","[round(usr.FireElemental)]")
		if(usr.PE=="Water")
			stat("Primary Element - Water:","[round(usr.WaterElemental)]")
		if(usr.PE=="Earth")
			stat("Primary Element - Earth:","[round(usr.EarthElemental)]")
		if(usr.PE=="Wind")
			stat("Primary Element - Wind:","[round(usr.WindElemental)]")
		if(usr.PE=="Lightning")
			stat("Primary Element - Lightning:","[round(usr.LightningElemental)]")
		if(usr.SE=="Fire")
			stat("Secondary Element - Fire:","[round(usr.FireElemental)]")
		if(usr.SE=="Water")
			stat("Secondary Element - Water:","[round(usr.WaterElemental)]")
		if(usr.SE=="Earth")
			stat("Secondary Element - Earth:","[round(usr.EarthElemental)]")
		if(usr.SE=="Wind")
			stat("Secondary Element - Wind:","[round(usr.WindElemental)]")
		if(usr.SE=="Lightning")
			stat("Secondary Element - Lightning:","[round(LightningElemental)]")
		stat("")
		stat("Unarmed Skill:","[H2HSkill]")
		stat("Knife Skill:","[KnifeSkill]")
		stat("Sword Skill:","[SwordSkill]")
		stat("Throwing Skill:","[ThrowingSkill]")
		stat("Fishing Skill:","[FishingSkill]")
		stat("Crafting Skill:","[CraftingSkill]")
		stat("First Aid Skill:","[FirstAidSkill]")
		if(usr.HasSeal=="Genesis Seal")
			stat("")
			stat("Chakra Stored:","[num2text(round(StoredChakra,1),9)]")
		if(usr.Class["Sand-Nin"])
			stat("")
			stat("Sand Collected:","[num2text(round(SandCollected,1),9)]")
*/

var/list/COMPUTERIDS=list()
proc/IsGuestKey(key)
	if(findtextEx(key, "Guest-", 1, 7) != 1)  return 0
	var/i,ch,len=length(key)
	for(i=7, i<=len, ++i)
		ch = text2ascii(key, i)
		if(ch < 48 || ch > 57) return 0
	return 1

client
	New()
		/*if(IsGuestKey(key))
			src<<"<b>Guest keys have been disabled.</b>";
			sleep(20)
			del(src)*/
		RandomTip()
		..() // This has to be done first
		for(var/mob/player/M in world)
			if(M.key==key&&M.loggedin)
				src<<"Re-logged too soon."
				spawn(2)
				del(src)
		/*if(computer_id in COMPUTERIDS&&!(ckey in MasterGMList))
			COMPUTERIDS+=computer_id
			src<<"<font color=red>Connection refused: Too many connections from your computer.</font>"
			sleep(5)
			del(src)
		else COMPUTERIDS+=computer_id*/

		var/area/A = mob.loc
		while(A && !istype(A))
			A = A.loc

		if(A) A.Entered(mob)
		spawn(2)
			winshow(src,"Splash",1)

	Del()
		var/obj/self
		var/icon/s
		if(src)
			if(mob && ismob(mob.Targeting))
				mob.DeleteTarget()
			if(mob)
				self=new(mob)
			if(mob&&mob.icon)
				s=new(mob.icon)
			if(s)
				for(var/obj/x in mob)
					if(x && x.icon && x.worn)
						s.Blend(x.icon,ICON_OVERLAY)
			if(self) {self.name=null; self.icon=s}
			if(mob) mob.SelfImage=self
			del(self)
			spawn(10)
				COMPUTERIDS-=computer_id
		..()
		//.=..()

proc
	AboutSoL()
		alert({"Shinobi of Myth is a MMORPG based on the Ninja world.
Players start off as novice ninja and through training will steadily rise through
the ranks with the goal of being the strongest ninja in their chosen village, if not the world.
There are a vast array of statistics for players in SoM and almost all of them are trainable in their own right, therefore it is important that you give thought to any character you create; furthermore, time and effort can be saved with a wise training plan.
Having said that, SoM is not a complicated game and a new player can learn the
ropes in no time.  Tutorials and guides are also available on the SoM forum.
SoL was originally created by SaucepanMan AKA CuriousNeptune. As of 2016, a plague took over development of SoL.
After some careful medication SoL has recovered and evolved into SoM now lead by the players.
My sincere apoligies for not crediting all the pixel artists, but I cannot recall you all.
Please leave a message on the forums if you wish to rectify this."},"Shinobi of Myth")