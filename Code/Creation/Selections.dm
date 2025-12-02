mob/var/tmp
	VillageCount=1
	ClanCount=1
	SpecialtyCount=1

mob/proc/getRebirthCount()
	var/firstletter=copytext(usr.ckey, 1, 2)
	var/savefile/F = new("Saves/[firstletter]/[usr.ckey]/resets.sav")
	//F.cd = "/rebirths"
	var/x
	F["rebirthAmount"]>>x
	if(x<1) x=0
	return x
mob/proc
	RandomizeCreate()
		set hidden = 1
		usr.VillageCount = rand(1,9)
		switch(usr.VillageCount)
			if(1) usr.ShowCloud()
			if(2) usr.ShowLeaf()
			if(3) usr.ShowGrass()
			if(4) usr.ShowMist()
			if(5) usr.ShowRain()
			if(6) usr.ShowRock()
			if(7) usr.ShowSand()
			if(8) usr.ShowSound()
			if(9) usr.ShowWaterfall()
		DisabledClan
		usr.ClanCount = rand(1,15)
		switch(usr.ClanCount)
			if(1) {if(!Clan_Aburame_Enabled) {goto DisabledClan} usr.ShowAburame()}
			if(2) {if(!Clan_Akimichi_Enabled) {goto DisabledClan} usr.ShowAkimichi()}
			if(3) {if(!Clan_Clay_Enabled) {goto DisabledClan} usr.ShowClay()}
			if(4) {if(!Clan_Hyuuga_Enabled) {goto DisabledClan} usr.ShowHyuuga()}
			if(5) {if(!Clan_Inuzuka_Enabled) {goto DisabledClan} usr.ShowInuzuka()}
			if(6) {if(!Clan_Kaguya_Enabled) {goto DisabledClan} usr.ShowKaguya()}
			if(7) {if(!Clan_Nara_Enabled) {goto DisabledClan} usr.ShowNara()}
			if(8) {if(!Clan_Otsutsuki_Enabled) {goto DisabledClan} usr.ShowOtsutsuki()}
			if(9) {if(!Clan_Sand_Enabled) {goto DisabledClan} usr.ShowSandClan()}
			if(10) {if(!Clan_Sarutobi_Enabled) {goto DisabledClan} usr.ShowSarutobi()}
			if(11) {if(!Clan_Senju_Enabled) {goto DisabledClan} usr.ShowSenju()}
			if(12) {if(!Clan_TaiSpec_Enabled) {goto DisabledClan} usr.ShowLee()}
			if(13) {if(!Clan_Uzumaki_Enabled) {goto DisabledClan} usr.ShowUzumaki()}
			if(14) {if(!Clan_Uchiha_Enabled) {goto DisabledClan} usr.ShowUchiha()}
			if(15) {if(!Clan_Haku_Enabled) {goto DisabledClan} usr.ShowYuki()}

		usr.SpecialtyCount = rand(1,4)
		switch(usr.SpecialtyCount)
			if(1) usr.ShowAllRound()
			if(2) usr.ShowGenjutsu()
			if(3) usr.ShowNinjutsu()
			if(4) usr.ShowTaijutsu()
			if(5) usr.ShowGenNin()
			if(6) usr.ShowGenTai()
			if(7) usr.ShowNinTai()

mob/logging/verb
	.RandomMe()
		if(name == "player")
			CRname()
		if(gender!="male" && gender!="female")
			CRgender()
		if(!basename)
			CRskin()
		if(!IrisColour)
			CReyes()
		if(!CurrentHair)
			CRhair()
		RandomizeCreate()
	VillageLeft()
		set hidden=1
		usr.VillageCount--
		if(usr.VillageCount<1) usr.VillageCount=9
		switch(usr.VillageCount)
			if(1) usr.ShowCloud()
			if(2) usr.ShowLeaf()
			if(3) usr.ShowGrass()
			if(4) usr.ShowMist()
			if(5) usr.ShowRain()
			if(6) usr.ShowRock()
			if(7) usr.ShowSand()
			if(8) usr.ShowSound()
			if(9) usr.ShowWaterfall()

	VillageRight()
		set hidden=1
		usr.VillageCount++
		if(usr.VillageCount>9) usr.VillageCount=1
		switch(usr.VillageCount)
			if(1) usr.ShowCloud()
			if(2) usr.ShowLeaf()
			if(3) usr.ShowGrass()
			if(4) usr.ShowMist()
			if(5) usr.ShowRain()
			if(6) usr.ShowRock()
			if(7) usr.ShowSand()
			if(8) usr.ShowSound()
			if(9) usr.ShowWaterfall()

	ClanLeft()
		set hidden=1
		DisabledClan
		usr.ClanCount--
		if(usr.ClanCount<1) usr.ClanCount=15
		switch(usr.ClanCount)
			if(1) {if(!Clan_Aburame_Enabled) {goto DisabledClan} usr.ShowAburame()}
			if(2) {if(!Clan_Akimichi_Enabled) {goto DisabledClan} usr.ShowAkimichi()}
			if(3) {if(!Clan_Clay_Enabled) {goto DisabledClan} usr.ShowClay()}
			if(4) {if(!Clan_Hyuuga_Enabled) {goto DisabledClan} usr.ShowHyuuga()}
			if(5) {if(!Clan_Inuzuka_Enabled) {goto DisabledClan} usr.ShowInuzuka()}
			if(6) {if(!Clan_Kaguya_Enabled) {goto DisabledClan} usr.ShowKaguya()}
			if(7) {if(!Clan_Nara_Enabled) {goto DisabledClan} usr.ShowNara()}
			if(8) {if(!Clan_Otsutsuki_Enabled) {goto DisabledClan} usr.ShowOtsutsuki()}
			if(9) {if(!Clan_Sand_Enabled) {goto DisabledClan} usr.ShowSandClan()}
			if(10) {if(!Clan_Sarutobi_Enabled) {goto DisabledClan} usr.ShowSarutobi()}
			if(11) {if(!Clan_Senju_Enabled) {goto DisabledClan} usr.ShowSenju()}
			if(12) {if(!Clan_TaiSpec_Enabled) {goto DisabledClan} usr.ShowLee()}
			if(13) {if(!Clan_Uzumaki_Enabled) {goto DisabledClan} usr.ShowUzumaki()}
			if(14) {if(!Clan_Uchiha_Enabled) {goto DisabledClan} usr.ShowUchiha()}
			if(15) {if(!Clan_Haku_Enabled) {goto DisabledClan} usr.ShowYuki()}

	ClanRight()
		set hidden=1
		DisabledClan
		usr.ClanCount++
		if(usr.ClanCount>15) usr.ClanCount=1
		switch(usr.ClanCount)
			if(1) {if(!Clan_Aburame_Enabled) {goto DisabledClan} usr.ShowAburame()}
			if(2) {if(!Clan_Akimichi_Enabled) {goto DisabledClan} usr.ShowAkimichi()}
			if(3) {if(!Clan_Clay_Enabled) {goto DisabledClan} usr.ShowClay()}
			if(4) {if(!Clan_Hyuuga_Enabled) {goto DisabledClan} usr.ShowHyuuga()}
			if(5) {if(!Clan_Inuzuka_Enabled) {goto DisabledClan} usr.ShowInuzuka()}
			if(6) {if(!Clan_Kaguya_Enabled) {goto DisabledClan} usr.ShowKaguya()}
			if(7) {if(!Clan_Nara_Enabled) {goto DisabledClan} usr.ShowNara()}
			if(8) {if(!Clan_Otsutsuki_Enabled) {goto DisabledClan} usr.ShowOtsutsuki()}
			if(9) {if(!Clan_Sand_Enabled) {goto DisabledClan} usr.ShowSandClan()}
			if(10) {if(!Clan_Sarutobi_Enabled) {goto DisabledClan} usr.ShowSarutobi()}
			if(11) {if(!Clan_Senju_Enabled) {goto DisabledClan} usr.ShowSenju()}
			if(12) {if(!Clan_TaiSpec_Enabled) {goto DisabledClan} usr.ShowLee()}
			if(13) {if(!Clan_Uzumaki_Enabled) {goto DisabledClan} usr.ShowUzumaki()}
			if(14) {if(!Clan_Uchiha_Enabled) {goto DisabledClan} usr.ShowUchiha()}
			if(15) {if(!Clan_Haku_Enabled) {goto DisabledClan} usr.ShowYuki()}

	SpecialtyLeft()
		set hidden=1
		usr.SpecialtyCount--
		if(usr.SpecialtyCount<1) usr.SpecialtyCount=7
		switch(usr.SpecialtyCount)
			if(1) usr.ShowAllRound()
			if(2) usr.ShowGenjutsu()
			if(3) usr.ShowNinjutsu()
			if(4) usr.ShowTaijutsu()
			if(5) usr.ShowGenNin()
			if(6) usr.ShowGenTai()
			if(7) usr.ShowNinTai()

	SpecialtyRight()
		set hidden=1
		usr.SpecialtyCount++
		if(usr.SpecialtyCount>7) usr.SpecialtyCount=1
		switch(usr.SpecialtyCount)
			if(1) usr.ShowAllRound()
			if(2) usr.ShowGenjutsu()
			if(3) usr.ShowNinjutsu()
			if(4) usr.ShowTaijutsu()
			if(5) usr.ShowGenNin()
			if(6) usr.ShowGenTai()
			if(7) usr.ShowNinTai()


mob/proc
	ShowCloud()
		winset(src,null,"Creation.VillageBio.image=['Bio_Cloud.png'];Creation.VillageAvatar.image=['Avatar_Cloud.png'];Creation.VillageTitle.image=['Title_Cloud.png']")
	ShowGrass()
		winset(src,null,"Creation.VillageBio.image=['Bio_Grass.png'];Creation.VillageAvatar.image=['Avatar_Grass.png'];Creation.VillageTitle.image=['Title_Grass.png']")
	ShowLeaf()
		winset(src,null,"Creation.VillageBio.image=['Bio_Leaf.png'];Creation.VillageAvatar.image=['Avatar_leaf.png'];Creation.VillageTitle.image=['Title_leaf.png']")
	ShowMist()
		winset(src,null,"Creation.VillageBio.image=['Bio_Mist.png'];Creation.VillageAvatar.image=['Avatar_mist.png'];Creation.VillageTitle.image=['Title_mist.png']")
	ShowRain()
		winset(src,null,"Creation.VillageBio.image=['Bio_Rain.png'];Creation.VillageAvatar.image=['Avatar_Rain.png'];Creation.VillageTitle.image=['Title_Rain.png']")
	ShowRock()
		winset(src,null,"Creation.VillageBio.image=['Bio_Rock.png'];Creation.VillageAvatar.image=['Avatar_Rock.png'];Creation.VillageTitle.image=['Title_Rock.png']")
	ShowSand()
		winset(src,null,"Creation.VillageBio.image=['Bio_Sand.png'];Creation.VillageAvatar.image=['Avatar_Sand.png'];Creation.VillageTitle.image=['Title_Sand.png']")
	ShowSound()
		winset(src,null,"Creation.VillageBio.image=['Bio_Sound.png'];Creation.VillageAvatar.image=['Avatar_Sound.png'];Creation.VillageTitle.image=['Title_Sound.png']")
	ShowWaterfall()
		winset(src,null,"Creation.VillageBio.image=['Bio_Waterfall.png'];Creation.VillageAvatar.image=['Avatar_Waterfall.png'];Creation.VillageTitle.image=['Title_Waterfall.png']")

	ShowUzumaki()
		winset(src,null,"Creation.ClanBio.image=['Bio_Uzumaki.png'];Creation.ClanAvatar.image=['Avatar_Uzumaki.png'];Creation.ClanTitle.image=['Title_Uzumaki.png']")
		var/list/WM = WorldMultis["Uzumaki"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowAburame()
		winset(src,null,"Creation.ClanBio.image=['Bio_Aburame.png'];Creation.ClanAvatar.image=['Avatar_Aburame.png'];Creation.ClanTitle.image=['Title_Aburame.png']")
		var/list/WM = WorldMultis["Aburame"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowAkimichi()
		winset(src,null,"Creation.ClanBio.image=['Bio_Akimichi.png'];Creation.ClanAvatar.image=['Avatar_Akimichi.png'];Creation.ClanTitle.image=['Title_Akimichi.png']")
		var/list/WM = WorldMultis["Akimichi"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowYuki()
		winset(src,null,"Creation.ClanBio.image=['Bio_Haku.png'];Creation.ClanAvatar.image=['Avatar_Haku.png'];Creation.ClanTitle.image=['Title_Yuki.png']")
		var/list/WM = WorldMultis["Yuki"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowHyuuga()
		winset(src,null,"Creation.ClanBio.image=['Bio_Hyuuga.png'];Creation.ClanAvatar.image=['Avatar_Hyuuga.png'];Creation.ClanTitle.image=['Title_Hyuuga.png']")
		var/list/WM = WorldMultis["Hyuuga"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowInuzuka()
		winset(src,null,"Creation.ClanBio.image=['Bio_Inuzuka.png'];Creation.ClanAvatar.image=['Avatar_Inuzuka.png'];Creation.ClanTitle.image=['Title_Inuzuka.png']")
		var/list/WM = WorldMultis["Inuzuka"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowKaguya()
		winset(src,null,"Creation.ClanBio.image=['Bio_Kaguya.png'];Creation.ClanAvatar.image=['Avatar_Kaguya.png'];Creation.ClanTitle.image=['Title_Kaguya.png']")
		var/list/WM = WorldMultis["Kaguya"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowNara()
		winset(src,null,"Creation.ClanBio.image=['Bio_Nara.png'];Creation.ClanAvatar.image=['Avatar_Nara.png'];Creation.ClanTitle.image=['Title_Nara.png']")
		var/list/WM = WorldMultis["Nara"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowUchiha()
		winset(src,null,"Creation.ClanBio.image=['Bio_Uchiha.png'];Creation.ClanAvatar.image=['Avatar_Uchiha.png'];Creation.ClanTitle.image=['Title_Uchiha.png']")
		var/list/WM = WorldMultis["Uchiha"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowLee()
		winset(src,null,"Creation.ClanBio.image=['Bio_Lee.png'];Creation.ClanAvatar.image=['Avatar_Lee.png'];Creation.ClanTitle.image=['Title_Lee.png']")
		var/list/WM = WorldMultis["Taijutsu Specialist"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowSandClan()
		winset(src,null,"Creation.ClanBio.image=['Bio_SandNin.png'];Creation.ClanAvatar.image=['Avatar_SandNin.png'];Creation.ClanTitle.image=['Title_SandNin.png']")
		var/list/WM = WorldMultis["Sand"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowClay()
		winset(src,null,"Creation.ClanBio.image=['Bio_Clay.png'];Creation.ClanAvatar.image=['Avatar_Clay.png'];Creation.ClanTitle.image=['Title_Clay.png']")
		var/list/WM = WorldMultis["Clay"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowSarutobi()
		winset(src,null,"Creation.ClanBio.image=['Bio_Sarutobi.png'];Creation.ClanAvatar.image=['Avatar_Sarutobi.png'];Creation.ClanTitle.image=['Title_Sarutobi.png']")
		var/list/WM = WorldMultis["Sarutobi"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowSenju()
		winset(src,null,"Creation.ClanBio.image=['Bio_Senju.png'];Creation.ClanAvatar.image=['Avatar_Senju.png'];Creation.ClanTitle.image=['Title_Senju.png']")
		var/list/WM = WorldMultis["Senju"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")
	ShowOtsutsuki()
		winset(src,null,"Creation.ClanBio.image=['Bio_Otsutsuki.png'];Creation.ClanAvatar.image=['Avatar_Otsutsuki.png'];Creation.ClanTitle.image=['Title_Otsutsuki.png']")
		var/list/WM = WorldMultis["Otsutsuki"]
		winset(src,null,"Creation.StamM.text=\"[10*WM["Stamina"]]\";Creation.ChakM.text=\"[10*WM["Chakra"]]\";Creation.TaiM.text=\"[10*WM["Taijutsu"]]\";Creation.NinM.text=\"[10*WM["Ninjutsu"]]\";Creation.GenM.text=\"[10*WM["Genjutsu"]]\";")

	ShowAllRound()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_AllRound.png'];Creation.SpecialtyAvatar.image=['Avatar_AllRound.png'];Creation.SpecialtyTitle.image=['Title_AllRound.png']")
	ShowGenjutsu()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_Genjutsu.png'];Creation.SpecialtyAvatar.image=['Avatar_Genjutsu.png'];Creation.SpecialtyTitle.image=['Title_Genjutsu.png']")
	ShowNinjutsu()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_Ninjutsu.png'];Creation.SpecialtyAvatar.image=['Avatar_Ninjutsu.png'];Creation.SpecialtyTitle.image=['Title_Ninjutsu.png']")
	ShowTaijutsu()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_Taijutsu.png'];Creation.SpecialtyAvatar.image=['Avatar_Taijutsu.png'];Creation.SpecialtyTitle.image=['Title_Taijutsu.png']")

	ShowGenTai()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_GenTai.png'];Creation.SpecialtyAvatar.image=['Avatar_GenTai.png'];Creation.SpecialtyTitle.image=['Title_GenTai.png']")

	ShowGenNin()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_GenNin.png'];Creation.SpecialtyAvatar.image=['Avatar_GenNin.png'];Creation.SpecialtyTitle.image=['Title_GenNin.png']")

	ShowNinTai()
		winset(src,null,"Creation.SpecialtyBio.image=['Bio_NinTai.png'];Creation.SpecialtyAvatar.image=['Avatar_NinTai.png'];Creation.SpecialtyTitle.image=['Title_NinTai.png']")


