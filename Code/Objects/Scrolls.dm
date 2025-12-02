/***********************************************************************************
**********************************[ Scrolls ]***************************************
************************************************************************************/
obj/Scrolls
	invisibility = 5
	verb
		Drop()
			loc=locate(usr.x,usr.y+1,usr.z)
			usr<<"You drop the [name]"
			OnSpeedRail=null; usr.SpeedRailSlotsUsed[ItemSlot]=0
			usr.UpdateInventory()
		Get()
			set src in oview(1)
			loc = usr
			usr<<"You pick up the [name]"
			usr.UpdateInventory()
	MeiMeiScroll
		name="MeiMei no Jutsu Scroll"
		icon='scrolls.dmi'
		icon_state="genscroll"
		price=1000
		ItemType="Scroll"
		verb
			Learn()
				var/obj/SkillCards/Genjutsu/MeiMei/J=locate() in usr.contents
				if(J) {usr<<"You already know Mei Mei no Jutsu."; return}
				if(usr.GenjutsuTrue>=800)
					switch(input("Learn Mei Mei No Jutsu?","Scroll")in list("Yes","No"))
						if("Yes")
							if(!(J in usr.contents))
								usr<<"<font size=2><b>You learned Mei Mei no Jutsu!</b></font>"
								new/obj/SkillCards/Genjutsu/MeiMei(usr)
								loc=null
								usr.UpdateInventory()
								del(src)
				else {usr<<"You need 800 Genjutsu to learn this."; return}
//__________________________________________________________________________________
	KageShurikenScroll
		name="Kage Shuriken no Jutsu Scroll"
		icon='scrolls.dmi'
		icon_state="ninscroll"
		price=500
		ItemType="Scroll"
		verb
			Learn()
				if(usr.JutsuList["KageShuri"])
					usr<<"You already know Kage Shuriken no Jutsu."; return
				if(usr.NinjutsuTrue>=4000&&usr.ThrowingSkill>20)
					switch(input("Learn Kage Shuriken No Jutsu?","Scroll")in list("Yes","No"))
						if("Yes")
							usr<<"<font size=2><b>You learned Kage Shuriken no Jutsu!.</b>"
							new/obj/SkillCards/Ninjutsu/ShurikenKageBunshin(usr)
							usr.JutsuList["KageShuri"]=1
							loc=null
							usr.UpdateInventory()
							del(src)
				else
					usr<<"You need 4000 Ninjutsu, 20 Throwing Skill to learn this.</font>"
//__________________________________________________________________________________
	ShurikenKageBunshinScroll
		name="Shuriken Kage Bunshin no Jutsu Scroll"
		icon='scrolls.dmi'
		icon_state="ninscroll"
		price=1000
		ItemType="Scroll"
		verb
			Learn()
				if(usr.JutsuList["ShurikenKB"])
					usr<<"You already know Shuriken Kage Bunshin no Jutsu."; return
				if(usr.NinjutsuTrue>=18000&&usr.ThrowingSkill>500)
					//300 uses
					switch(input("Learn Shuriken Kage Bunshin no Jutsu?","Scroll")in list("Yes","No"))
						if("Yes")
							usr<<"<font size=2><b>You learned Shuriken Kage Bunshin no Jutsu!.</b>"
							new/obj/SkillCards/Ninjutsu/ShurikenKageBunshin(usr)
							usr.JutsuList["ShurikenKageBunshin"]=1
							loc=null
							OnSpeedRail=null; usr.SpeedRailSlotsUsed[ItemSlot]=0
							usr.UpdateInventory()
							del(src)
				else
					usr<<"You need 18000 Ninjutsu, and 500 Throwing Skill to learn this.</font>"
//__________________________________________________________________________________
	KageBunshinScroll
		name="Kage Bunshin no Jutsu Scroll"
		icon='scrolls.dmi'
		icon_state="ninscroll"
		price=2000
		ItemType="Scroll"
		verb
			Learn()
				var/obj/SkillCards/Ninjutsu/KageBunshin/J=locate() in usr.contents
				if(J) {usr<<"You already know Kage Bunshin no Jutsu."; return}
				if(usr.MoveUses["Bunshin"] <= 2000)
					usr<<"You're not familiar enough with regular bunshins."
					return
				if(usr.NinjaRank!="Academy Student"&&usr.NinjaRank!="Genin" && usr.NinjutsuTrue>=9000)
					switch(input("Learn Kage Bunshin no Jutsu?","Scroll")in list("Yes","No"))
						if("Yes")
							if(!(J in usr.contents))
								usr<<"<font size=2><b>You learned Kage Bunshin no Jutsu!.</b>"
								new/obj/SkillCards/Ninjutsu/KageBunshin(usr)
								loc=null; usr.UpdateInventory()
								del(src)
				else usr<<"You must be Chuunin rank or higher and have 9000 Ninjutsu to learn this technique."

//__________________________________________________________________________________
	BunshinExplodeScroll
		name="Bunshin Daibakuha Scroll"
		desc="Scroll of Great Clone Explosion"
		icon='scrolls.dmi'
		icon_state="ninscroll"
		price=5000
		ItemType="Scroll"
		verb
			Learn()
				if(usr.JutsuList["Bunsplode"])
					usr<<"You already know Bunshin Daibakuha."; return
				else
					if(usr.Ninjutsu>=3500&&usr.NinjaRank!="Academy Student"&&usr.NinjaRank!="Genin"&&usr.NinjaRank!="Chuunin"&&usr.NinjaRank!="Special Jounin")
						//1000 uses
						usr<<"<b><font size=2>You've just learned <i>Bunshin Daibakuha</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/BunshinDaibakuha(usr)
						usr.JutsuList["Bunsplode"]=1
						loc=null
						OnSpeedRail=null; usr.SpeedRailSlotsUsed[ItemSlot]=0
						usr.UpdateInventory()
						del(src)
					else
						usr<<"You need 1000 Kage Bunshin uses, 4000 Ninjutsu, and be Anbu or higher."; return