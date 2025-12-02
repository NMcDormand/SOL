mob/var/tmp
	JutsuBrowse
	CurrentSkillSelection
	obj/HighlightedCard

obj/var
	cmdstring
	OnHotBar

mob/verb
	CloseJutsuWindow()
		set hidden=1
		if(!usr.client) return
		for(var/obj/SkillCards/s in usr) s.overlays=null
		winshow(usr,"JutsuWindow",0)
		usr.JutsuBrowse = null

	TechniquesAll()
		set hidden=1
		if(usr.TakingExam||!usr.client||!(usr.loggedin)) return
		for(var/obj/SkillCards/s in usr) s.overlays=null
		usr.JutsuBrowse="All"
		usr.RefreshJustuWindow()
		winshow(usr,"JutsuWindow",1)
		//winset(usr,null,"JutsuWindow.ALL.image=['HL_Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesNinjutsu()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Ninjutsu"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['HL_Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesTaijutsu()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Taijutsu"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['HL_Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesGenjutsu()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Genjutsu"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['HL_Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesClan()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Clan-Jutsu"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['HL_Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesPE()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Primary-Element"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['HL_Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesADV()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Advanced-Element"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['HL_Filter.png']; JutsuWindow.PRO.image=['Filter.png']'")

	TechniquesClass()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Class"
		usr.RefreshJustuWindow()
		//winset(usr,null,"JutsuWindow.ALL.image=['Filter.png']; JutsuWindow.NIN.image=['Filter.png']; JutsuWindow.GEN.image=['Filter.png']; JutsuWindow.TAI.image=['Filter.png']; JutsuWindow.KEK.image=['Filter.png']; JutsuWindow.PRI.image=['Filter.png']; JutsuWindow.SEC.image=['Filter.png']; JutsuWindow.PRO.image=['HL_Filter.png']'")

	TechniquesSRank()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="S-Rank"
		usr.RefreshJustuWindow()

	TechniquesOther()
		set hidden=1
		if(!usr.client) return
		usr.JutsuBrowse="Other"
		usr.RefreshJustuWindow()

obj/var
	list/slot = list()
	list/Description = list()

obj/SkillCards
	MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params)
		if(loc == usr)
			if(findtext("[src_control]","AllJutsu") || findtext("[src_control]","Hotbar") && findtext("[over_control]","AllJutsu") || findtext("[over_control]","Hotbar") && src_control!=over_control)
				if(!slot)
					slot = list()

				if(IsHotBar(over_control))
					if(IsHotBar(src_control))
						var/obj/PlaceHolder/bg=locate(/obj/PlaceHolder) in usr.contents
						usr << output(bg,src_control)
					else
						if(OnHotBar)
							return
					var/end="[over_control]"
					usr << output(src,over_control)	//place in new slot
					end = copytext(end,12)
					slot["HotBar"]=end
					overlays=null; OnHotBar=1

					//If theres something in the way...
					for(var/obj/SkillCards/o in usr.contents)
						if(o == src)
							continue

						if(!o.slot)
							slot=list()
							continue

						if(o.slot["HotBar"]==null) continue

						if(o.slot["HotBar"] == slot["HotBar"])
							o.slot["HotBar"]=null
							o.OnHotBar=0

				else //if putting in main window
					if(CanPlaceCard(src,usr) && IsHotBar(src_control))
						var/obj/PlaceHolder/bg=locate(/obj/PlaceHolder) in usr.contents
						usr << output(bg,src_control)
						OnHotBar=0
						slot["HotBar"]=null
				//usr.UpdateInventory()
		..()
proc
	IsHotBar(x,a=1,b=0)
		if(findtext(x,"HotBar")) return a
		else return b

	CanPlaceCard(obj/C,mob/U)
		if(U.JutsuBrowse=="All"||U.JutsuBrowse==C.Description["category"])
			return TRUE
		else return FALSE

obj/proc
	LoseSlots()
		slot["all"]=null
		slot["ninjutsu"]=null
		slot["taijutsu"]=null
		slot["genjutsu"]=null

obj/PlaceHolder
	icon='SC_Background.dmi'

mob/verb/HotBarSetting()
	switch(alert("What would you like to do?","Hot Bar","Reset Hotbar","Empty Hotbar","Cancel"))
		if("Reset Hotbar")
			ResetHotBar()
		if("Empty Hotbar")
			EmptyHotBar()
		else
			return

mob/proc
	EmptyHotBar()
		var/obj/PlaceHolder/bg=locate(/obj/PlaceHolder) in contents
		for(var/obj/SkillCards/AB in contents)
			if(AB.OnHotBar)
				src << output(bg,"HotBarPane.[AB.slot["HotBar"]]")
				AB.slot["HotBar"]=null
				AB.OnHotBar=0

	ResetHotBar()
		for(var/i=1 to 13)
			var/obj/SkillCards/AB
			switch(i)
				if(1)
					AB = locate(/obj/SkillCards/Genjutsu/Starter/Bunshin) in src
				if(2)
					AB = locate(/obj/SkillCards/Starter/Bunshin_Attack) in src
				if(3)
					AB = locate(/obj/SkillCards/Ninjutsu/Starter/Henge) in src
				if(4)
					AB = locate(/obj/SkillCards/Ninjutsu/Starter/Kawarimi) in src
				if(5)
					AB = locate(/obj/SkillCards/Taijutsu/Starter/Finish) in src
				if(6)
					AB = locate(/obj/SkillCards/Taijutsu/Starter/Kick) in src
				if(7)
					AB = locate(/obj/SkillCards/Taijutsu/Starter/Punch) in src
				if(8)
					AB = locate(/obj/SkillCards/Starter/Fish) in src
				if(9)
					AB = locate(/obj/SkillCards/Starter/Craft) in src
				if(10)
					AB = locate(/obj/SkillCards/Starter/Meditate) in src
				if(11)
					AB = locate(/obj/SkillCards/Starter/Rest) in src
				if(12)
					AB = locate(/obj/SkillCards/ClimbTree) in src
				if(13)
					AB = locate(/obj/SkillCards/ActionButton) in src

			if(AB)
				src << output(AB,"HotBarPane.[i]")//place in new slot
				AB.slot["HotBar"]="[i]"
				AB.overlays=null;
				AB.OnHotBar=1

	PlaceHotbarCards()
		set waitfor = 0
		if(!client) return
		PreLoadHotBar()
		sleep(5)
		for(var/obj/SkillCards/O in src)
			if(O.OnHotBar)
				var/l=O.slot["HotBar"]
				var/s="HotBarPane.[l]"
				src << output(O,"[s]")

	PreLoadHotBar()
		var/obj/PlaceHolder/bg=locate(/obj/PlaceHolder) in contents
		for(var/i=1, i<=13, i++)
			var/slot="HotBarPane.[i]"
			src<<output(bg,slot)

	RefreshJustuWindow()
		if(!client) return
		var/items=1
		var
			s
			i
			//skip=list()
		for(i=1, i<=227, i++)
			s="AllJutsu.[i]"
			src << output(null,"[s]")
			//clears tiles
		if(JutsuBrowse == "All")
			for(var/obj/SkillCards/O in usr)
				if(!O.JutsuType)
					usr << "This technique doesnt have a Jutsu type saved, please advice a GM [O.type]"
				//if(O.OnHotBar) continue
				/*
				items++
				if(!O.slot) O.slot=new()
				if(!O.slot[JutsuBrowse])
					O.slot[JutsuBrowse]=1

				if(!O.slot[JutsuBrowse])
					if(!(items in skip))
						O.slot[JutsuBrowse]=items
					else
						for(var/z in skip)
							while(z==items) items++
				else
					for(var/z in skip)
						O.slot[JutsuBrowse]=text2num(O.slot[JutsuBrowse])
						while(z==O.slot[JutsuBrowse])
							O.slot[JutsuBrowse]++
				var/a=O.slot[JutsuBrowse]
				if(istext(a)) a=text2num(a)
				skip+=a
				var/l=O.slot[JutsuBrowse]
				if(isnum(l)) l=num2text(l)
				s="AllJutsu.[l]"*/
				src << output(O,"AllJutsu.[items]")
				items++
		else
			for(var/obj/SkillCards/O in usr)
				if(JutsuBrowse==O.JutsuType)
					//if(O.OnHotBar) continue
					src << output(O,"AllJutsu.[items]")
					items++
					/*items++
					if(!O.slot) O.slot=new()
					if(O.slot[JutsuBrowse]==null)
						O.slot[JutsuBrowse]=1
					if(!O.slot[JutsuBrowse])
						if(!(items in skip))
							O.slot[JutsuBrowse]=items
						else
							for(var/z in skip)
								while(z==items) items++
					else
						for(var/z in skip)
							O.slot[JutsuBrowse]=text2num(O.slot[JutsuBrowse])
							while(z==O.slot[JutsuBrowse])
								O.slot[JutsuBrowse]++
					var/a=O.slot[JutsuBrowse]
					if(istext(a)) a=text2num(a)
					skip+=a
					var/l=O.slot[JutsuBrowse]
					if(isnum(l)) l=num2text(l)
					s="AllJutsu.[l]"
					src << output(O,"[s]")*/

mob/verb
	ResetMacros()
		m_cmd=list()
		m_rep=list()
		m_rel=list()
		m_alt=list()
		m_shf=list()
		m_ctrl=list()
		macs=list()
		alert("You have reset your ingame macros, to have this take affect you will now need to reconnect to the game")
	SetShortcutKey()
		set hidden=1
		if(usr.CurrentSkillSelection) usr.setSkill(usr.CurrentSkillSelection)
	DelShortcutKey2()
		set hidden=1
		if(usr.CurrentSkillSelection) usr.delSkill(usr.CurrentSkillSelection)
		//usr.client.removeMacro("[k]","[cmd]",1,0,0,0)

mob/proc/setSkill(cmd)
	var/x=input("Type in which key you would like to use for this skill","Set Shortcut Key") as text|null
	if(x)
		x=copytext(x,1,2)
		if(!usr.m_cmd) usr.m_cmd=new()
		if(!usr.m_rep) usr.m_rep=new()
		if(!usr.m_rel) usr.m_rel=new()
		if(!usr.m_alt) usr.m_alt=new()
		if(!usr.m_shf) usr.m_shf=new()
		if(!usr.m_ctrl) usr.m_ctrl=new()
		if(!usr.macs) usr.macs=new()
		usr.macs[x]=1
		usr.m_cmd[x]=cmd
		usr.m_cmd[x]=cmd
		usr.m_rep[x]=1
		usr.m_rel[x]=0
		usr.m_alt[x]=0
		usr.m_ctrl[x]=0
		usr.m_shf[x]=0
		usr.client.addMacro("[x]","[cmd]",1,0,0,0)
		return x

mob/proc/delSkill(cmd)
	var/x=input("What key do you want to remove this from?","Remove Shortcut Key") as text|null
	if(x)
		x=copytext(x,1,2)
		if(!usr.m_cmd) usr.m_cmd=new()
		if(!usr.m_rep) usr.m_rep=new()
		if(!usr.m_rel) usr.m_rel=new()
		if(!usr.m_alt) usr.m_alt=new()
		if(!usr.m_shf) usr.m_shf=new()
		if(!usr.m_ctrl) usr.m_ctrl=new()
		if(!usr.macs) usr.macs=new()
		usr.macs[x]=1
		usr.m_cmd[x]=cmd
		usr.m_cmd[x]=cmd
		usr.m_rep[x]=1
		usr.m_rel[x]=0
		usr.m_alt[x]=0
		usr.m_ctrl[x]=0
		usr.m_shf[x]=0
		usr.client.removeMacro("[x]","[cmd]",1,0,0,0)
		return x