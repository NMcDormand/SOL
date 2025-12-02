client/Topic(href, list/href_list)
	..()
	var/action = href_list["action"]
	var/mob/Living/Player/M=usr
	switch(action)
		if ("ChangePanel")
			usr.PanelLoaded = text2num(href_list["LoadedP"])
			M.LoadStatPanel()
			winset(usr, "map1", "focus=true")
		if ("UseVerb")
			switch(href_list["VUsed"])
				if("Attack")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Bunshin/))
						var/obj/SkillCards/Bunshin/B=A
						B.BAttack()
				if("Analysis")
					var/mob/Living/Player/Admin/Helper/MM=M
					var/obj/A=locate(href_list["OClicked"])
					MM.Variable_Analysis(A)
				if("Close")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Clan/TaiSpec/Hachimon))
						var/obj/SkillCards/Clan/TaiSpec/Hachimon/B=A
						B.Close_Gates()
				if("Create")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
						var/obj/SkillCards/Clan/Kaguya/Bone_Weapons/B=A
						B.Create_Bone_Weapon()
				if("Delete")
					var/obj/A=locate(href_list["OClicked"])
					del A
					M.UpdateItems()
				if("Dispel")
					var/obj/SkillCards/Bunshin/A=locate(href_list["OClicked"])
					A.BDispel()
				if("Drop")
					var/obj/Item/A=locate(href_list["OClicked"])
					A.Drop()
				if("Drink")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Food/Edible))
						var/obj/Item/Food/Drinks/B=A
						B.Drink()
				if("Eat")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Food/Edible))
						var/obj/Item/Food/Edible/B=A
						B.Eat()
				if("Equip")
					var/obj/Item/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Wear/Clothes))
						var/obj/Item/Wear/Clothes/AB=A
						AB.Equip()
					else if(istype(A,/obj/Item/Wear/Weapons/Wield))
						var/obj/Item/Wear/Weapons/Wield/AB=A
						AB.Equip()
				if("Edit")
					var/mob/Living/Player/Admin/Admin/MM=M
					var/obj/A=locate(href_list["OClicked"])
					MM.Edit(A)
					spawn(5)winset(MM,"EditPage.Search","focus=true")
				if("Fill")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Smelting/PortaForge))
						var/obj/Item/Smelting/PortaForge/B=A
						B.Fill()
					else if(istype(A,/obj/Item/Wear/Clothes/Special/Gourd))
						var/obj/Item/Wear/Clothes/Special/Gourd/B=A
						B.Fill()
				if("Focus")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Usable/Leaf))
						var/obj/Item/Usable/Leaf/B=A
						B.Leaf_Focus()
				if("Fish")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Usable/FishingRod))
						var/obj/Item/Usable/FishingRod/B=A
						B.Fish()
					if(istype(A,/obj/Item/Usable/GarbageNet))
						var/obj/Item/Usable/GarbageNet/B=A
						B.Collect_Garbage()
				if("Follow")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Bunshin/))
						var/obj/SkillCards/Bunshin/B=A
						B.BFollow()
					else if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
						var/obj/SkillCards/Clan/Inuzuka/Pet/PetOut/B=A
						B.Follow()
				if("Forget")
					var/obj/SkillCards/Misc/Henge_no_Jutsu/A=locate(href_list["OClicked"])
					A.Henge_Forget()
				if("Inspect")
					var/obj/Item/A=locate(href_list["OClicked"])
					A.Inspect()
				if("Locate")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
						var/obj/SkillCards/Clan/Aburame/Bugs/B=A
						B.Locate_Bug()
				if("Options")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Bunshin))
						var/obj/SkillCards/Bunshin/B=A
						B.Bunshin_Options()
				if("Place")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
						var/obj/SkillCards/Clan/Aburame/Bugs/B=A
						B.Place_Bug()
				if("Pick Up")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetOut/B=A
							B.Pick_Up_Pet()
				if("Sic")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetOut/B=A
							B.Sic_Dog()
				if("Heel")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetOut/B=A
							B.Heel()
				if("Read")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Usable/BingoBook))
						var/obj/Item/Usable/BingoBook/B=A
						B.Check_Bingo()
					else if(istype(A,/obj/Item/Usable/GuideBook))
						var/obj/Item/Usable/GuideBook/B=A
						B.Read_Book()
					else if(istype(A,/obj/Item/Usable/Scroll))
						var/obj/Item/Usable/Scroll/B=A
						B.Read_Scroll()
					else if(istype(A,/obj/Item/Usable/Map))
						var/obj/Item/Usable/Map/B=A
						B.Check_Map()
				if("Release")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu))
						var/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu/B=A
						B.Kagemane_Release()
				if("Remember")
					var/obj/SkillCards/Misc/Henge_no_Jutsu/A=locate(href_list["OClicked"])
					A.Henge_Remember()
				if("Smelt")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Smelting/PortaForge))
						var/obj/Item/Smelting/PortaForge/B=A
						B.Smelt()
				if("Stats")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/HavePet/B=A
							B.Pet_Stats()
				if("Stop")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Bunshin/))
						M.Bunshin_Stop()
				if("Store Chakra")
					var/obj/SkillCards/Boosts/Seals/Genesis/A=locate(href_list["OClicked"])
					A.Store_Chakra()
				if("Summon")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/HavePet/B=A
							B.Summon_Pet()
				if("Switch")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/Throwing))
						var/obj/SkillCards/Throwing/B=A
						B.Switch_Type()
				if("Throw")
					var/obj/Item/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Wear/Weapons/Thrown))
						var/obj/Item/Wear/Weapons/Thrown/AB=A
						AB.Throw()
				if("Track")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetOut/Tracking/B=A
							B.Track_Scent()
					else if(istype(A,/obj/Item/Usable/CatCollar))
						var/obj/Item/Usable/CatCollar/B=A
						B.Check_Collar()
				if("UpdateItems")
					M.UpdateItems(href_list["Subject"])
				if("Upgrade")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards/))
						var/obj/SkillCards/B=A
						B.Upgrade_Jutsu()
				if("Use")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/SkillCards))
						if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							var/obj/SkillCards/Clan/Kaguya/Bone_Weapons/B=A
							B.Create_Bone_Weapon()
							return
						A.Click()
					else
						A.DblClick()
				if("Wrap")
					var/obj/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/))
						var/obj/Item/Wear/Weapons/Wield/Special/Mist/Samehada/B=A
						B.Wrap()
		if ("ReFocus")
			winset(usr,"map1","focus=true")
		if ("SendMsg")
			if(href_list["MsgTgt"] == "World")
				world << "[href_list["Msg"]]"
			if(href_list["MsgTgt"] == "usr")
				src << "[href_list["Msg"]]"
		if ("UpdateItems")
			M.UpdateItems()
		if ("ClickObject")
			var/obj/A=locate(href_list["OClicked"])
			if(istype(A,/obj/SkillCards))
				if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
					var/obj/SkillCards/Clan/Kaguya/Bone_Weapons/B=A
					B.Create_Bone_Weapon()
					return
				A.Click()
			else
				A.DblClick()


mob/Living//Player
	proc
		UpdateStatPanel(A,B,C)
			set background=1
			set waitfor=0
			if(PanelLoaded==1||PanelLoaded==0)
				src << output(list2params(list(A,B,C)),"Stat-Panel1:UpdateStat")
				/*if(A=="DgHealth"||A=="DgStamina"||A=="DgTaijutsu")
					world<<"[A] [B]"*/

		UpdateAll(A)
			set background=1
			set waitfor=0
			if(A=="Basic"||!A)
				UpdateStatPanel("Name1",name)
				if(Alias)
					UpdateStatPanel("Alias",Alias)
				UpdateStatPanel("Clan",Clan)
				UpdateStatPanel("Village",Village)
				UpdateStatPanel("Rank",Rank)
				UpdateStatPanel("Yen",Yen)
				UpdateStatPanel("Profession",Profession)
				UpdateStatPanel("ZWord",ZWord)
				UpdateStatPanel("Level",Level.Current)
			if(A=="Primary"||!A)
				UpdateStatPanel("Health",round(Health.Current),round(Health.Max))
				UpdateStatPanel("Stamina",round(Stamina.Current),round(Stamina.Max))
				UpdateStatPanel("Chakra",round(Chakra.Current),round(Chakra.Max))
				UpdateStatPanel("SandCollected",round(SandCollected),round(SandMax))
				UpdateStatPanel("InSharingan",round(InSharingan))
				UpdateStatPanel("InGate",round(InGate),round(CanGate))
				UpdateStatPanel("BugCount",round(BugCount))
				UpdateStatPanel("Taijutsu",Taijutsu.Current)
				UpdateStatPanel("Ninjutsu",Ninjutsu.Current)
				UpdateStatPanel("Genjutsu",Genjutsu.Current)
			if(A=="Secondary"||!A)
				UpdateStatPanel("Chakra Control",ChakraControl.Current)
				UpdateStatPanel("Seal Speed",SealSpeed.Current)
				UpdateStatPanel("Speed",Speed.Current)
				UpdateStatPanel("Crafting Skill",Crafting.Current)
				UpdateStatPanel("Mining Skill",Mining.Current)
				UpdateStatPanel("First Aid Skill",FirstAid.Current)
				UpdateStatPanel("Fishing Skill",Fishing.Current)
				UpdateStatPanel("Knife",Knife.Current)
				UpdateStatPanel("Sword",Sword.Current)
				UpdateStatPanel("Long",Pole.Current)
				UpdateStatPanel("Fan",Fan.Current)
				UpdateStatPanel("Shuriken",Shuriken.Current)
				UpdateStatPanel("Senbon",Senbon.Current)
				UpdateStatPanel("Unarmed",Unarmed.Current)
			if(A=="Elements"||!A)
				UpdateStatPanel("Earth",EarthElement.Current)
				UpdateStatPanel("Fire",FireElement.Current)
				UpdateStatPanel("Lightning",LightningElement.Current)
				UpdateStatPanel("Water",WaterElement.Current)
				UpdateStatPanel("Wind",WindElement.Current)
				//Advanced Elements
				UpdateStatPanel("Lava",LavaElement.Current)
				UpdateStatPanel("Explosion",ExplosionElement.Current)
				UpdateStatPanel("Wood",WoodElement.Current)
				UpdateStatPanel("Magnet",MagnetElement.Current)
				UpdateStatPanel("Blaze",BlazeElement.Current)
				UpdateStatPanel("Boil",BoilElement.Current)
				UpdateStatPanel("Scorch",ScorchElement.Current)
				UpdateStatPanel("Storm",StormElement.Current)
				UpdateStatPanel("Swift",SwiftElement.Current)
				UpdateStatPanel("Gale",GaleElement.Current)

				UpdateStatPanel("Ice",IceElement.Current)
				UpdateStatPanel("Sand",SandElement.Current)

				UpdateStatPanel("Particle",ParticleElement.Current)
				UpdateStatPanel("Yin",YinElement.Current)
				UpdateStatPanel("Yang",YangElement.Current)
				//UpdateStatPanel("YinYang",YinYangElement.Current)
				UpdateStatPanel("Nature",NatureElement.Current)
			if(A=="Missions"||!A)
				UpdateStatPanel("Smissions",Missions["S"])
				UpdateStatPanel("Amissions",Missions["A"])
				UpdateStatPanel("Bmissions",Missions["B"])
				UpdateStatPanel("Cmissions",Missions["C"])
				UpdateStatPanel("Dmissions",Missions["D"])
			if(Clan!="Inuzuka")
				src << output(list2params(list(Clan)),"Stat-Panel1:UnHide")
			else
				var/obj/SkillCards/Clan/Inuzuka/Pet/Pet=locate(/obj/SkillCards/Clan/Inuzuka/Pet/) in contents
				if(Pet.HasPet)
					src << output(list2params(list("Dog")),"Stat-Panel1:UnHide")
					if(!DogOut)
						UpdateStatPanel("DgHealth",round(Pet.PetHealth.Current),Pet.PetHealth.Max)
						UpdateStatPanel("DgStamina",round(Pet.PetStamina.Current),Pet.PetStamina.Max)
						UpdateStatPanel("DgTaijutsu",Pet.PetTaijutsu.Current)
					else
						var/mob/Living/Animals/Dog/Dg
						for(var/mob/Living/Animals/Dog in world)
							if(Owner==src)
								Dg=Dog
								break
						UpdateStatPanel("DgHealth",round(Dg.Health.Current),round(Dg.Health.Max))
						UpdateStatPanel("DgStamina",round(Dg.Stamina.Current),round(Dg.Stamina.Max))
						UpdateStatPanel("DgTaijutsu",Dg.Taijutsu.Current)

			src << output(list2params(list(Profession)),"Stat-Panel1:UnHide")
		LoadStatPanel(var/type)
			set background=1
			set waitfor=0
			var/mob/Living/Player/M=src
			if(PanelLoaded == 0)
			/*	M << browse_rsc('TabBar.png', "TabBar.png")
				M << browse_rsc('TabBGS.png', "TabBGS.png")
				M << browse_rsc('TabBGU.png', "TabBGU.png")
				M << browse_rsc('BarC.png', "BarC.png")
				M << browse_rsc('BarO.png', "Baro.png")*/
				for(var/obj/A in usr.contents)
					usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
				var/PanelHTML
				var/i="\[i]"
				if(!type||type=="Tabs")
					PanelHTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[Name1]'s Tabs</title></head><style type="text/css">
						html	{overflow:hidden;}
						body	{background:#070707;;width:100%;Height:30px;margin:0px;padding:0px;overflow:hidden;}
						#ContT	{background:url(http://mysting.net/Nom/TabBar.png);height:30px;width:351px;text-align:center;}
						span	{position:relative;top:4px;}
						button	{border:0px;display:inline-block;*display: inline;zoom:1;height:30px;width:54px;margin:0px 2px;font-weight:Bold;padding:0px;}
						.Tab	{background:url(http://mysting.net/Nom/TabBGU.png);color:#999;}
						.TabS	{background:url(http://mysting.net/Nom/TabBGS.png);color:#fff;}
					</style><script type="text/javascript">
						function SwiTab(el,TabN){
							ConT = document.getElementById("ContT");
							var Tabs = ContT.getElementsByTagName('button');
							for (i = 0; i < Tabs.length; i++) {
								if(el.id == Tabs[i].id){
									Tabs[i].className = "TabS";
									window.location='byond://?src=\ref[src]&action=ChangePanel&LoadedP='+TabN;}
								else{
									Tabs[i].className = "Tab";}
								}
							}
						function ReFocus(el){
							window.focus()
							window.location='byond://?src=\ref[src]&action=ReFocus';
						}
						function TabHide(){var GldE = document.getElementById("Guild");var Gld = "[M.Guild1]";var AdmnE =  document.getElementById("Admin");var Admn =  "[M.GM]";if (Gld == ""){GldE.style.display = "none";}if (Admn < 2){AdmnE.style.display = "none";}}
					</script>
					<body oncontextmenu="ReFocus();return false;" onclick="ReFocus()" onload="TabHide()">
						<div id="ContT">
							<button class="TabS"id="Stats" onclick="SwiTab(this,1)"><span>Stats</span></button>
							<button class="Tab" id="Items" onclick="SwiTab(this,2)"><Span>Items</Span></button>
							<button class="Tab" id="Jutsu" onclick="SwiTab(this,3)"><Span>Jutsu</Span></button>
							<button class="Tab" id="Verbs" onclick="SwiTab(this,4)"><Span>Verbs</Span></button>
							<button class="Tab" id="Guild" onclick="SwiTab(this,5)"><Span>[M.GuildTag]</Span></button>
							<button class="Tab" id="Admin" onclick="SwiTab(this,6)"><Span>Admin</Span></button>
						</div>
					</body>
					</html>"}
					M << browse(PanelHTML,"window=TabBar")
					winset(src,"TabBar","is-visible=true")
				if(!type||type=="Stats")
					var/GClan = Clan
					var/Dog = "Dog"
					if(Clan=="Inuzuka")
						var/obj/SkillCards/Clan/Inuzuka/Pet/Pet=locate(/obj/SkillCards/Clan/Inuzuka/Pet/) in M.contents
						if(Pet.HasPet)
							GClan = "Dog"
							Dog=Pet.JName
					PanelHTML={"
					<html>
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
							<title>Stats</title>
						</head>
						<style type="text/css">
							body		{overflow-x:hidden;font-family:Arial;background:#070707;color:#BBB;font-size:10pt;scrollbar-base-color:#151515;scrollbar-highlight-color:#070707;scrollbar-arrow-color:#151515;scrollbar-face-color:#151515;scrollbar-shadow-color:#070707;width:100%;margin:0px;}
							button		{border:0px;background:url(http://mysting.net/Nom/BarBg.png);position:relative;height:28px;width:100%;margin:0px;padding:0px;}
							button img	{position:absolute;right:-8px;width:28px;height:28px;}
							button span	{position:absolute;left:20px;top:7px;color:#BBB;font-weight:Bold;}
							.BarL		{background:url(http://mysting.net/Nom/BarL.png);position:absolute;left:0px;}
							.BarRC		{background:url(http://mysting.net/Nom/BarCB2.png);}
							.BarRO		{background:url(http://mysting.net/Nom/BarOB2.png);}
							.StE		{position: relative;text-align: center;width: 90%;margin: 5px auto;}
							.StE div	{text-align:right;float:left;width:70px;margin:0px 0px 0px 5px;}
							.StEs		{position: relative;text-align: center;width: 100%;margin:5px auto;}
							.StEs div	{text-align: right;float:left;width: 120px;margin:0px 0px 0px 5px;}
							.StEb		{position: relative;text-align: center;width: 100%;margin:5px 10px;}
							.StEb div	{text-align: right;float:left;width: 50px;margin:0px 0px 0px 5px;}
							.Desc		{background: #000;position:absolute;top:-35px;height: 20px;padding: 5px 7px;}
							.ContA		{vertical-align:top;margin:0px auto;display:inline-block;*display:inline;zoom:1;*float:none;Width:325px;font-weight:bold;}
							.ContC		{Width:100%;}
							#Health		{Color:#dd4040;}
							#Stamina	{Color:#40dd40;}
							#Chakra		{Color:#4040ee;}
						</style>
						<script type="text/javascript">
							function showC(el){
								var inner = el.nextSibling.nextSibling;
								var ButR = el.lastChild;
								if (inner.style.display == "none"){
									inner.style.display = "";
									ButR.className = "BarRO";
								}
								else{
									inner.style.display = "none";
									ButR.className = "BarRC";
								}
							}
							function DispDesc(el){
								//var inner = el.nextSibling;
								//if (inner.style.display == "none"){inner.style.display = "";}
								//else{inner.style.display = "none";}
							}
							function UpdateStat(A,B,C,D){
								if (D == null){D  = "" }
								if (A == "Mining Skill"){A = "Mining Skill" }
								if (A == "Crafting Skill"){A = "Crafting Skill" }
								if (A == "Fishing Skill"){A = "Fishing Skill" }
								if (A == "Sword Skill"){A = "Sword" }
								if (A == "Knife Skill"){A = "Knife" }
								if (A == "Chakra Control"){A = "Chakra Control" }
								if (A == "Seal Speed"){A = "Seal Speed" }
								if (A == "First Aid"){A = "First Aid Skill" }
								if (A == "Unarmed Skill"){A = "Unarmed"  }
								if (A == "Shuriken Skill"){A = "Shuriken" }
								if (A == "Senbon Skill"){A = "Senbon" }

								var StatE = document.getElementById(A);
								if (A == "Health" || A == "Stamina" || A == "Chakra"|| A=="SandCollected"||A=="InGate"||A=="DgHealth"||A=="DgStamina"){StatE.innerHTML = (B) + " / " + (C)}
								//else if (A=="ZWord"||A=="Name"||A=="Rank"||A=="Yen"||A=="Alias"||A=="Village"||A=="Clan"||A=="Smissions"||A=="Amissions"||A=="Bmissions"||A=="Cmissions"||A=="Dmissions"){StatE.innerHTML = (B)}
								else{StatE.innerHTML = (B);}
							}
							function UnHide(Clan){
								if(Clan == null){
									var GClan = "[GClan]";
									var AProf = "[Profession]";
									if(GClan == "Aburame"){document.getElementById("UBugCount").style.display = "" }
									if(GClan == "Uchiha"){document.getElementById("USharingan").style.display = "" }
									if(GClan == "Dog"){document.getElementById("DogStats").style.display = "" }
									if(AProf=="Sand"){document.getElementById("USandCollected").style.display="" }
								}
								else{
									if(Clan == "Sand"){document.getElementById("USandCollected").style.display="" }
									if(Clan == "Aburame"){document.getElementById("UBugCount").style.display = "" }
									if(Clan == "Sharingan"){document.getElementById("USharingan").style.display = "" }
									if(Clan == "Dog"){document.getElementById("DogStats").style.display = "" }
								}
								var ContE= document.getElementById("ElementsI");
								var ContEL = ContE.getElementsByTagName('div');
								var EleNum = 0;
								for (i = 0; i < ContEL.length; i++) {
									if(parseInt(ContE.getElementsByTagName('div')[i].lastChild.innerHTML) > 0){
										ContE.getElementsByTagName('div')[i].style.display = "";
										EleNum++
										}
									i++ }
								if(EleNum > 0){document.getElementById("EleCatBut").style.display = "";}
							}
							function ReFocus(A){
								window.location='byond://?action=ReFocus';
							}
						</script>
						<body onload="UnHide()" oncontextmenu="ReFocus()" onclick="ReFocus()">
							<div class="ContA" id="Page1">
								<div class="ContC" id="BasicInfo"><button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Basic Info</span><img class="BarRO"></button>
									<div class="ContP">
										<div class="StEb"id="UName"><span id="Name1">[Name1]</span> <span id="Clan">[Clan]</span><span id="Alias">[Alias]</span></div>
										<div class="StEb"id="URank"><span id="Rank">[Rank]</span> of the <span id="Village">[Village]</span></div>
										<div class="StE" id="ULevel"><div >Level:</div><p class="Desc" style="display:none;">Description Here</p><span id="Level">[Level.Current]</span></div>
										<div class="StE" id="UYen"><div >Yen:</div><p class="Desc" style="display:none;">Description Here</p><span id="Yen">[Yen]</span></div>
										<div class="StE" id="UProfession"><div >Profession:</div><p class="Desc" style="display:none;">Description Here</p><span id="Profession">[Profession]</span></div>
										<div class="StE" id="UZWord"><div >Location:</div><p class="Desc" style="display:none;">Description Here</p><span id="ZWord">[ZWord]</span></div>
									</div>
								</div>
								<div class="ContC" id="PrimaryStats"><button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Primary Stats</span><img class="BarRO"></button>
									<div class="ContP" style="display:;">
										<div class="StE" id="UHealth"><div >Health:</div><p class="Desc" style="display:none;">Description Here</p><span id="Health">[round(Health.Current)] / [round(Health.Max,1)]</span></div>
										<div class="StE" id="UStamina"><div >Stamina:</div><p class="Desc" style="display:none;">Description Here</p><span id="Stamina">[round(Stamina.Current)] / [round(Stamina.Max,1)]</span></div>
										<div class="StE" id="UChakra"><div >Chakra:</div><p class="Desc" style="display:none;">Description Here</p><span id="Chakra">[round(Chakra.Current)] / [round(Chakra.Max,1)]</span></div>
										<div class="StE" id="UBugCount" style="display:none;"><div >Bugs:</div><p class="Desc" style="display:none;">Description Here</p><span id="BugCount">[BugCount]</span></div>
										<div class="StE" id="USandCollected" style="display:none;"><div >Sand:</div><p class="Desc" style="display:none;">Description Here</p><span id="SandCollected">[SandCollected] / [SandMax]</span></div>
										<div class="StE" id="USharingan" style="display:none;"><div >Sharingan:</div><p class="Desc" style="display:none;">Description Here</p><span id="InSharingan">[InSharingan]</span></div>
										<div class="StE" id="UHachimon" style="display:none;"><div >Gates:</div><p class="Desc" style="display:none;">Description Here</p><span id="InGate">[InGate] / [CanGate]</span></div>
										<br>
										<div class="StE" id="UTaijutsu"><div >Taijutsu:</div><p class="Desc" style="display:none;">Description Here</p><span id="Taijutsu">[Taijutsu.Current]</span></div>
										<div class="StE" id="UNinjutsu"><div >Ninjutsu:</div><p class="Desc" style="display:none;">Description Here</p><span id="Ninjutsu">[Ninjutsu.Current]</span></div>
										<div class="StE" id="UGenjutsu"><div >Genjutsu:</div><p class="Desc" style="display:none;">Description Here</p><span id="Genjutsu">[Genjutsu.Current]</span></div>
									</div>
								</div>
								<div class="ContC" id="Elements"><button class="ButC" id="EleCatBut"style="display:none;" onclick="showC(this);"><img class="BarL"><span class="CatName">Elements</span><img class="BarRC"></button>
									<div class="ContP" id="ElementsI" style="display:none;">
										<div class="StE" style="display:none;" id="UEarth"><div >Earth:</div><p class="Desc" style="display:none;">Description Here</p><span id="Earth">[EarthElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UFire"><div >Fire:</div><p class="Desc" style="display:none;">Description Here</p><span id="Fire">[FireElement.Current]</span></div>
										<div class="StE" style="display:none;" id="ULightning"><div >Lightning:</div><p class="Desc" style="display:none;">Description Here</p><span id="Lightning">[LightningElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UWater"><div >Water:</div><p class="Desc" style="display:none;">Description Here</p><span id="Water">[WaterElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UWind"><div >Wind:</div><p class="Desc" style="display:none;">Description Here</p><span id="Wind">[WindElement.Current]</span></div>
										<div class="StE" style="display:none;" id="ULava"><div >Lava:</div><p class="Desc" style="display:none;">Description Here</p><span id="Lava">[LavaElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UExplosion"><div >Explosion:</div><p class="Desc" style="display:none;">Description Here</p><span id="Explosion">[ExplosionElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UWood"><div >Wood:</div><p class="Desc" style="display:none;">Description Here</p><span id="Wood">[WoodElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UMagnet"><div >Magnet:</div><p class="Desc" style="display:none;">Description Here</p><span id="Magnet">[MagnetElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UBlaze"><div >Blaze:</div><p class="Desc" style="display:none;">Description Here</p><span id="Blaze">[BlazeElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UBoil"><div >Boil:</div><p class="Desc" style="display:none;">Description Here</p><span id="Boil">[BoilElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UScorch"><div >Scorch:</div><p class="Desc" style="display:none;">Description Here</p><span id="Scorch">[ScorchElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UStorm"><div >Storm:</div><p class="Desc" style="display:none;">Description Here</p><span id="Storm">[StormElement.Current]</span></div>
										<div class="StE" style="display:none;" id="USwift"><div >Swift:</div><p class="Desc" style="display:none;">Description Here</p><span id="Swift">[SwiftElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UGale"><div >Gale:</div><p class="Desc" style="display:none;">Description Here</p><span id="Gale">[GaleElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UIce"><div >Ice:</div><p class="Desc" style="display:none;">Description Here</p><span id="Ice">[IceElement.Current]</span></div>
										<div class="StE" style="display:none;" id="USand"><div >Sand:</div><p class="Desc" style="display:none;">Description Here</p><span id="Sand">[SandElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UParticle"><div >Particle:</div><p class="Desc" style="display:none;">Description Here</p><span id="Particle">[ParticleElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UYin"><div >Yin:</div><p class="Desc" style="display:none;">Description Here</p><span id="Yin">[YinElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UYang"><div >Yang:</div><p class="Desc" style="display:none;">Description Here</p><span id="Yang">[YangElement.Current]</span></div>
										<div class="StE" style="display:none;" id="UNature"><div >Nature:</div><p class="Desc" style="display:none;">Description Here</p><span id="Nature">[NatureElement.Current]</span></div>
									</div>
								</div>
							</div>
							<div class="ContA" id="Page2">
								<div class="ContC" id="SecondaryStats"><button class="ButC" onclick="showC(this)" ><img class="BarL"><span class="CatName">Secondary Stats</span><img class="BarRC"></button>
									<div class="ContP" style="display:none;">
										<div class="StEs" id="UChakra-Control"><div >Chakra Control:</div><p class="Desc" style="display:none;">Description Here</p><span id="Chakra Control">[ChakraControl.Current]</span>%</div>
										<div class="StEs" id="USealSpeed"><div >Seal Speed:</div><p class="Desc" style="display:none;">Description Here</p><span id="Seal Speed">[SealSpeed.Current]</span></div>
										<div class="StEs" id="UReflexes"><div >Reflexes:</div><p class="Desc" style="display:none;">Description Here</p><span id="Reflexes">[Reflexes.Current]</span></div>
										<div class="StEs" id="USpeed"><div >Speed:</div><p class="Desc" style="display:none;">Description Here</p><span id="Speed">[Speed.Current]</span></div>
										<br>
										<div class="StEs" id="UCrafting"><div >Crafting:</div><p class="Desc" style="display:none;">Description Here</p><span id="Crafting Skill">[Crafting.Current]</span></div>
										<div class="StEs" id="UMining"><div >Mining:</div><p class="Desc" style="display:none;">Description Here</p><span id="Mining Skill">[Mining.Current]</span></div>
										<div class="StEs" id="UFirstAid"><div >First Aid:</div><p class="Desc" style="display:none;">Description Here</p><span id="First Aid Skill">[FirstAid.Current]</span></div>
										<div class="StEs" id="UFishing"><div >Fishing:</div><p class="Desc" style="display:none;">Description Here</p><span id="Fishing Skill">[Fishing.Current]</span></div>
										<br>
										<div class="StEs" id="UKnife"><div >Knife:</div><p class="Desc" style="display:none;">Description Here</p><span id="Knife">[Knife.Current]</span></div>
										<div class="StEs" id="USword"><div >Sword:</div><p class="Desc" style="display:none;">Description Here</p><span id="Sword">[Sword.Current]</span></div>
										<div class="StEs" id="ULong"><div >Long:</div><p class="Desc" style="display:none;">Description Here</p><span id="Long">[Pole.Current]</span></div>
										<div class="StEs" id="UFan"><div >Fan:</div><p class="Desc" style="display:none;">Description Here</p><span id="Fan">[Fan.Current]</span></div>
										<div class="StEs" id="UShuriken"><div >Shuriken:</div><p class="Desc" style="display:none;">Description Here</p><span id="Shuriken">[Shuriken.Current]</span></div>
										<div class="StEs" id="USenbon"><div >Senbon:</div><p class="Desc" style="display:none;">Description Here</p><span id="Senbon">[Senbon.Current]</span></div>
										<div class="StEs" id="UUnarmed"><div >Unarmed:</div><p class="Desc" style="display:none;">Description Here</p><span id="Unarmed">[Unarmed.Current]</span></div>
									</div>
								</div>
								<div class="ContC" id="DogStats" style="display:none;"><button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">[Dog] Stats</span><img class="BarRC"></button>
									<div class="ContP" style="display:none;">
										<div class="StE" id="DHealth"><div >Health:</div><p class="Desc" style="display:none;">Description Here</p><span id="DgHealth"></span></div>
										<div class="StE" id="DStamina"><div >Stamina:</div><p class="Desc" style="display:none;">Description Here</p><span id="DgStamina"></span></div>
										<br>
										<div class="StE" id="DTaijutsu"><div >Taijutsu:</div><p class="Desc" style="display:none;">Description Here</p><span id="DgTaijutsu"></span></div>
									</div>
								</div>
								<div class="ContC" id="Missions"><button class="ButC" onclick="showC(this)" ><img class="BarL"><span class="CatName">Missions</span><img class="BarRC"></button>
									<div class="ContP" style="display:none;">
										<div class="StE" id="UMSrank"><div >S:</div><p class="Desc" style="display:none;">Description Here</p><span id="Smissions">[Missions["S"]]</span></div>
										<div class="StE" id="UMArank"><div >A:</div><p class="Desc" style="display:none;">Description Here</p><span id="Amissions">[Missions["A"]]</span></div>
										<div class="StE" id="UMBrank"><div >B:</div><p class="Desc" style="display:none;">Description Here</p><span id="Bmissions">[Missions["B"]]</span></div>
										<div class="StE" id="UMCrank"><div >C:</div><p class="Desc" style="display:none;">Description Here</p><span id="Cmissions">[Missions["C"]]</span></div>
										<div class="StE" id="UMDrank"><div >D:</div><p class="Desc" style="display:none;">Description Here</p><span id="Dmissions">[Missions["D"]]</span></div>
									</div>
								</div>
							</div>
						</body>
					</html>
					"}
					M << browse(PanelHTML,"Window=Stat-Panel1;")
					if(Clan=="Inuzuka")
						var/obj/SkillCards/Clan/Inuzuka/Pet/Pet=locate(/obj/SkillCards/Clan/Inuzuka/Pet/) in contents
						if(Pet.HasPet)
							spawn(1)
								M.UpdateStatPanel("DgHealth",round(Pet.PetHealth.Current),Pet.PetHealth.Max)
								M.UpdateStatPanel("DgStamina",round(Pet.PetStamina.Current),Pet.PetStamina.Max)
								M.UpdateStatPanel("DgTaijutsu",Pet.PetTaijutsu.Current)
					winset(src,"Stat-Panel1","is-visible=true")
				if(!type||type=="Items")
					var
						General
						Weapons
						Clothing
						Food
						Material
						C1=0;C2=0;C3=0;C4=0;C5=0
						B1=1000;B2=1000;B3=1000;B4=1000;B5=1000
						Verbs1= \
							{"<button class="Verb" onclick="UseVerb(this)">Drop</button>
							<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
						Verbs2
					if(M.GM>=1)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
						if(M.GM>=4)
							Verbs1 += \
								{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
								<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
					for(var/obj/Item/A in usr.contents)
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						if(istype(A,/obj/Item/Wear/Weapons))
							C2++
							if(C2==4)
								B2--
								C2=0
							if(istype(A,/obj/Item/Wear/Weapons/Wield))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
								if(istype(A,/obj/Item/Wear/Weapons/Wield/Special/Mist/Samehada))
									Verbs2 += \
										{"<button class="Verb" onclick="UseVerb(this)">Wrap</button>"}
							if(istype(A,/obj/Item/Wear/Weapons/Thrown))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Throw</button>"}
							Verbs2 +=Verbs1
							Weapons += \
								{"<div class="Item" style="z-index:[B2];" ObjRef="\ref[A]" ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(istype(A,/obj/Item/Wear/Clothes))
							C3++
							if(C3==4)
								B3--
								C3=0
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
							if(istype(A,/obj/Item/Wear/Clothes/Special/Gourd))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Fill</button>"}
							Verbs2 +=Verbs1
							Clothing += \
								{"<div class="Item" style="z-index:[B3];" ObjRef="\ref[A]"ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(istype(A,/obj/Item/Food))
							C4++
							if(C4==4)
								B4--
								C4=0
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
							Verbs2 +=Verbs1
							Food += \
								{"<div class="Item" style="z-index:[B4];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(istype(A,/obj/Item/Materials))
							C5++
							if(C5==4)
								B5--
								C5=0
							Verbs2 +=Verbs1
							Material += \
								{"<div class="Item" style="z-index:[B5];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else
							C1++
							if(C1==4)
								B1--
								C1=0
							if(istype(A,/obj/Item/Smelting/PortaForge))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Smelt</button>
									<button class="Verb" onclick="UseVerb(this)">Fill</button>"}
							if(istype(A,/obj/Item/Usable/Leaf))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Focus</button>"}
							else if(istype(A,/obj/Item/Usable/BingoBook)||istype(A,/obj/Item/Usable/Map)||istype(A,/obj/Item/Usable/GuideBook)||istype(A,/obj/Item/Usable/Scroll))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Read</button>"}
							else if(istype(A,/obj/Item/Usable/GarbageNet)||istype(A,/obj/Item/Usable/FishingRod))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Fish</button>"}
							else if(istype(A,/obj/Item/Food/Edible))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Eat</button>"}
							else if(istype(A,/obj/Item/Food/Drinks))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Drinks</button>"}
							Verbs2 +=Verbs1
							General += \
								{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}

					PanelHTML={"
					<html>
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
							<title>Items</title>
						</head>
						<script type="text/javascript">
							function showC(el){
								var inner = el.nextSibling.nextSibling;
								var ButR = el.lastChild;
								if (inner.style.display == "none")
									{inner.style.display = "";
									ButR.className = "BarRO";}
								else
									{inner.style.display = "none";
									ButR.className = "BarRC";}
							}
							function ClearVerbs(){
								var ContEL = document.getElementsByTagName('div');
								for (i = 0; i < ContEL.length; i++) {
									var Blur=document.getElementsByTagName('div')[i]
									if(Blur.className=="ObjVerbs"){Blur.style.display = "none" }
								}
							}
							function ClickObject(el)
								{window.location='byond://?src=\ref[src]&action=ClickObject&OClicked='+el.ObjRef;}
							function DispVerb(el){
								var inner = el.lastChild;
								if (inner.style.display == "none"){
									ClearVerbs(el);
									inner.style.display = "";}
								else{inner.style.display = "none";}
							}
							function UseVerb(el){
								var elem = el.parentNode.parentNode;var JustDoIt=1
								if(el.innerHTML== "Drop")
									{if(elem.ObjEquipped>0){var DropMsg = "You need to unequip it first!";window.location='byond://?src=\ref[src]&action=SendMsg&Msg='+DropMsg+'&MsgTgt=usr';return;}
									}
								window.location='byond://?src=\ref[src]&action=UseVerb&VUsed='+el.innerHTML+'&OClicked='+elem.ObjRef;}
							function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
							function UpdateItems(ObjType,Obj){
								var Blah = document.getElementById(ObjType);
								if(Obj){
									Blah.innerHTML=null
									Blah.innerHTML=Obj
								}
							}
							function UpdatePanel(){window.location='byond://?action=UpdateItems&&Subject=Jutsu';}
						</script>
						<style type="text/css">
							body		{overflow-x:hidden;font-family:Arial;background:#070707;color:#BBB;font-size:10pt;scrollbar-base-color:#151515;scrollbar-highlight-color:#070707;scrollbar-arrow-color:#151515;scrollbar-face-color:#151515;scrollbar-shadow-color:#070707;width:100%;margin:0px;}
							.ContC		{z-index:004;position:relative;vertical-align:top;margin:0px auto;display:inline-block;*display:inline;zoom:1;*float:none;Width:325px;}
							.ButO		{position:relative;background:url(http://mysting.net/Nom/BarBg.png);border:0px;height:28px;width:100%;margin:0px;padding:0px;}
							.ButO img	{position:absolute;right:-8px;width:28px;height:28px;}
							.ButO span	{position:absolute;left:20px;top:7px;color:#BBB;font-weight:Bold;}
							.BarL 		{position:absolute;background:url(http://mysting.net/Nom/BarL.png);left:0px;}
							.BarRC		{position:relative;background:url(http://mysting.net/Nom/BarCB2.png);}
							.BarRO		{position:relative;background:url(http://mysting.net/Nom/BarOB2.png);}
							.ContO		{position:relative;}
							.Item		{position:relative;display:inline-block;*display:inline;zoom:1;background: url(http://mysting.net/Nom/Items.png);width:70px;height:70px;margin:5px;text-align:center;}
							.Item img	{position:absolute;bottom:8px;left:19px;}
							.OName		{position:relative;top:4px;font-size:7pt;width:60px;font-weight:Bold;}
							.ObjVerbs	{position:absolute;filter:alpha(opacity=80);background: #070707;top:-5px;right:-5px;width:60px;height:80px;padding:3px;}
							.Verb		{position:relative;color:#BBB;background:#070707;padding:0px;margin:0px auto;border:0px;height:16px;font-size:8pt;width:100%;}
							#C1			{z-index:005;position:relative;}
							#C2			{z-index:004;position:relative;}
							#C3			{z-index:003;position:relative;}
							#C4			{z-index:002;position:relative;}
							#C5			{z-index:001;position:relative;}
							#Refresh	{z-index:002;position:relative;left:320px;background:url(http://mysting.net/Nom/Refresh.png);height:16px;width:16px;border:0px;}
						</style>
						<body oncontextmenu="ReFocus();return false;" onclick="ReFocus()">
							<div class="ContB">
								<div class="ContC" id="C1">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">General</span><img class="BarRO"></button>
									<div id="General">
										[General]
									</div>
								</div>
								<div class="ContC" id="C2">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Weapons</span><img class="BarRO"></button>
									<div id="Weapons">
										[Weapons]
									</div>
								</div>
								<div class="ContC" id="C3">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Clothing</span><img class="BarRO"></button>
									<div id="Clothing">
										[Clothing]
									</div>
								</div>
								<div class="ContC" id="C4">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Food</span><img class="BarRO"></button>
									<div id="Food">
										[Food]
									</div>
								</div>
								<div class="ContC" id="C5">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Material</span><img class="BarRO"></button>
									<div id="Material">
										[Material]
									</div>
								</div>
							</div>
							<button id="Refresh" onclick="UpdatePanel()"></button>
						</body>
					</html>"}
					M << browse(PanelHTML,"Window=Item-Panel;")
				if(!type||type=="Jutsu")
					var
						Clan
						Ninjutsu
						Genjutsu
						Taijutsu
						C1=0;C2=0;C3=0;C4=0
						B1=1000;B2=1000;B3=1000;B4=1000
						Verbs1= \
							{"<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
						Verbs2
					if(M.GM>=1)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
						if(M.GM>=4)
							Verbs1 += \
								{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
								<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
					for(var/obj/SkillCards/A in contents)
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.name].png")
						if(!istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
						if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Upgrade</button>"}
						if(istype(A,/obj/SkillCards/Bunshin))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Dispel</button>
								<button class="Verb" onclick="UseVerb(this)">Attack</button>
								<button class="Verb" onclick="UseVerb(this)">Follow</button>
								<button class="Verb" onclick="UseVerb(this)">Stop</button>
								<button class="Verb" onclick="UseVerb(this)">Options</button>"}
						if(istype(A,/obj/SkillCards/Throwing)&&A.Mastery>=5)
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Switch</button>"}
						if(istype(A,/obj/SkillCards/Clan))
							C1++
							if(C1==4)
								B1--
								C1=0
							if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Locate</button>
									<button class="Verb" onclick="UseVerb(this)">Place</button>"}
							if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
								var/obj/SkillCards/Clan/Inuzuka/Pet/PetSkill=A
								if(PetSkill.HasPet&&M.DogOut)
									Verbs2+= \
										{"<button class="Verb" onclick="UseVerb(this)">Pick Up</button>
										<button class="Verb" onclick="UseVerb(this)">Sic</button>
										<button class="Verb" onclick="UseVerb(this)">Heel</button>
										<button class="Verb" onclick="UseVerb(this)">Follow</button>
										<button class="Verb" onclick="UseVerb(this)">Learn Scent</button>"}
									if(PetSkill.Tracking)
										Verbs2+= \
											{"<button class="Verb" onclick="UseVerb(this)">Track</button>"}
								else if(PetSkill.HasPet)
									Verbs2+= \
										{"<button class="Verb" onclick="UseVerb(this)">Stats</button>
										<button class="Verb" onclick="UseVerb(this)">Summon</button>"}
								/*else
									Verbs2+= \
										{"<button class="Verb" onclick="UseVerb(this)">Tame</button>"}*/

							if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
								Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Create</button>"}
							if(istype(A,/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Release</button>"}
							if(istype(A,/obj/SkillCards/Clan/TaiSpec/Hachimon))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Close</button>"}
							Verbs2 +=Verbs1
							Clan += \
								{"<div class="Jutsu" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(A.Type=="Ninjutsu")
							C2++
							if(C2==4)
								B2--
								C2=0
							if(istype(A,/obj/SkillCards/Misc/Henge_no_Jutsu))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Remember</button>
									<button class="Verb" onclick="UseVerb(this)">Forget</button>"}
							Verbs2 +=Verbs1
							Ninjutsu += \
								{"<div class="Jutsu" style="z-index:[B2];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(A.Type=="Genjutsu")
							C3++
							if(C3==4)
								B3--
								C3=0
							Verbs2 +=Verbs1
							Genjutsu += \
								{"<div class="Jutsu" style="z-index:[B3];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
						else if(A.Type=="Taijutsu")
							C4++
							if(C4==4)
								B4--
								C4=0
							Verbs2 +=Verbs1
							Taijutsu += \
								{"<div class="Jutsu" style="z-index:[B4];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}

					PanelHTML={"
					<html>
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
							<title>Items</title>
						</head>
						<script type="text/javascript">
							function showC(el){
								var inner = el.nextSibling.nextSibling;
								var ButR = el.lastChild;
								if (inner.style.display == "none")
									{inner.style.display = "";
									ButR.className = "BarRO";}
								else
									{inner.style.display = "none";
									ButR.className = "BarRC";}
							}
							function ClearVerbs(el){
								var ContEL = document.getElementsByTagName('div');
								for (i = 0; i < ContEL.length; i++) {
									var Blur=document.getElementsByTagName('div')[i]
									if(Blur.className=="ObjVerbs"){Blur.style.display = "none" }
								}
							}
							function ClickObject(el){window.location='byond://?src=\ref[src]&action=ClickObject&OClicked='+el.ObjRef;}
							function DispVerb(el){
								var inner = el.lastChild;
								if (inner.style.display == "none"){
									ClearVerbs(el);
									inner.style.display = "";}
								else{inner.style.display = "none";}
							}
							function UseVerb(el){
								var elem = el.parentNode.parentNode;var JustDoIt=1
								if(el.innerHTML== "Drop"){
									if(elem.ObjEquipped>0){var DropMsg = "You need to unequip it first!";window.location='byond://?src=\ref[src]&action=SendMsg&Msg='+DropMsg+'&MsgTgt=usr';return;}
								}
								window.location='byond://?src=\ref[src]&action=UseVerb&VUsed='+el.innerHTML+'&OClicked='+elem.ObjRef;
							}

							function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
							function UpdateItems(ObjType,Obj){
								var Blah = document.getElementById(ObjType);
								if(Obj){
									Blah.innerHTML=null
									Blah.innerHTML=Obj
								}
							}
							function UpdatePanel(){window.location='byond://?action=UpdateItems&&Subject=Jutsu';}
						</script>
						<style type="text/css">
							body		{overflow-x:hidden;font-family:Arial;background:#070707;color:#BBB;font-size:10pt;scrollbar-base-color:#151515;scrollbar-highlight-color:#070707;scrollbar-arrow-color:#151515;scrollbar-face-color:#151515;scrollbar-shadow-color:#070707;width:100%;margin:0px;}
							.ContC		{position:relative;vertical-align:top;margin:0px auto;display:inline-block;*display:inline;zoom:1;*float:none;Width:325px;}
							.ButO		{position:relative;background:url(http://mysting.net/Nom/BarBg.png);border:0px;height:28px;width:100%;margin:0px;padding:0px;}
							.ButO img	{position:absolute;right:-8px;width:28px;height:28px;}
							.ButO span	{position:absolute;left:20px;top:7px;color:#BBB;font-weight:Bold;}
							.BarL 		{position:absolute;background:url(http://mysting.net/Nom/BarL.png);left:0px;}
							.BarRC		{position:relative;background:url(http://mysting.net/Nom/BarCB2.png);}
							.BarRO		{position:relative;background:url(http://mysting.net/Nom/BarOB2.png);}
							.ContO		{position:relative;}
							.Jutsu		{position:relative;display:inline-block;*display:inline;zoom:1;background: url(http://mysting.net/Nom/Items.png);width:70px;height:70px;margin:5px;text-align:center;}
							.Jutsu img	{position:absolute;bottom:8px;left:19px;}
							.OName		{position:relative;top:4px;font-size:7pt;width:60px;font-weight:Bold;}
							.ObjVerbs	{position:absolute;filter:alpha(opacity=80);background: #070707;top:-5px;right:-5px;width:80px;height:80px;padding:3px;}
							.Verb		{position:relative;color:#BBB;background:#070707;padding:0px;margin:0px auto;border:0px;height:16px;font-size:8pt;width:100%;}
							#C1			{z-index:004;}
							#C2			{z-index:003;}
							#C3			{z-index:002;}
							#C4			{z-index:001;}
							.ContB		{z-index:001;position:relative;}
							#Refresh	{z-index:002;position:relative;left:320px;background:url(http://mysting.net/Nom/Refresh.png);height:16px;width:16px;border:0px;}
						</style>
						<body oncontextmenu="ReFocus();return false;" onclick="ReFocus();">
							<div class="ContB">
								<div class="ContC" id="C1">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Clan</span><img class="BarRO"></button>
									<div id="Clan">
										[Clan]
									</div>
								</div>
								<div class="ContC" id="C2">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Ninjutsu</span><img class="BarRO"></button>
									<div id="Ninjutsu">
										[Ninjutsu]
									</div>
								</div>
								<div class="ContC" id="C3">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Genjutsu</span><img class="BarRO"></button>
									<div id="Genjutsu">
										[Genjutsu]
									</div>
								</div>
								<div class="ContC" id="C4">
									<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Taijutsu</span><img class="BarRO"></button>
									<div id="Taijutsu">
										[Taijutsu]
									</div>
								</div>
							</div>
							<button id="Refresh" onclick="UpdatePanel()"></button>
						</body>
					</html>"}
					M << browse(PanelHTML,"Window=Jutsu-Panel;")
				PanelLoaded=1
			if(PanelLoaded == 1)
				winset(M,"TabsChild","is-visible=false")
				winset(M,"Jutsu-Panel","is-visible=false")
				winset(M,"Item-Panel","is-visible=false")
				UpdateAll()
			else if(PanelLoaded == 2)
				winset(M,"TabsChild","is-visible=false")
				winset(M,"Jutsu-Panel","is-visible=false")
				winset(M,"Item-Panel","is-visible=true")
				UpdateItems("Items")
			else if(PanelLoaded == 3)
				winset(M,"TabsChild","is-visible=false")
				winset(M,"Jutsu-Panel","is-visible=true")
				winset(M,"Item-Panel","is-visible=false")
				UpdateItems("Jutsu")
			else if(PanelLoaded == 4)
				winset(M,"TabsChild","left=TabVerbsPane")
				winset(M,"TabsChild","is-visible=true")
			else if(PanelLoaded == 5)
				winset(M,"TabsChild","left=TabGuildPane")
				winset(M,"TabsChild","is-visible=true")
			else if(PanelLoaded == 6)
				winset(M,"TabsChild","left=TabAdminPane")
				winset(M,"TabsChild","is-visible=true")

			/*Not Html Inventory
			winset(M,"Jutsu-Panel","is-visible=false")
			winset(M,"Item-Panel","is-visible=false")
			if(PanelLoaded == 1)
				winset(M,"TabsChild","is-visible=false")
			if(PanelLoaded == 2)
				winset(M,"TabsChild","left=TabItemsPane")
				winset(M,"TabsChild","is-visible=true")
			if(PanelLoaded == 3)
				winset(M,"TabsChild","left=TabJutsuPane")
				winset(M,"TabsChild","is-visible=true")
			if(PanelLoaded == 4)
				winset(M,"TabsChild","left=TabVerbsPane")
				winset(M,"TabsChild","is-visible=true")
			if(PanelLoaded == 5)
				winset(M,"TabsChild","left=TabGuildPane")
				winset(M,"TabsChild","is-visible=true")
			if(PanelLoaded == 6)
				winset(M,"TabsChild","left=TabAdminPane")
				winset(M,"TabsChild","is-visible=true")*/
mob//Living/Player
	proc
		UpdateItems(B,C)
			set background=1
			set waitfor=0
			var
				mob/Living/Player/M=src
				Subject
				Verbs1
				Verbs2
				C1=0
				B1=1000
			if(B=="Items"||!B)
				Verbs1+= \
						{"<button class="Verb" onclick="UseVerb(this)">Drop</button>
						<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
				if(M.GM>=1)
					Verbs1 += \
						{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
					if(M.GM>=4)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
							<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
				if(!C||C=="Weapons")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Wear/Weapons/A in usr.contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						if(istype(A,/obj/Item/Wear/Weapons/Wield))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
							if(istype(A,/obj/Item/Wear/Weapons/Wield/Special/Mist/Samehada))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Wrap</button>"}
						if(istype(A,/obj/Item/Wear/Weapons/Thrown))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Throw</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Weapons",Subject)),"Item-Panel:UpdateItems")
				if(!C||C=="Clothing")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Wear/Clothes/A in usr.contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
						if(istype(A,/obj/Item/Wear/Clothes/Special/Gourd))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Fill</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Clothing",Subject)),"Item-Panel:UpdateItems")
				if(!C||C=="Food")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Food/A in usr.contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Food",Subject)),"Item-Panel:UpdateItems")
				if(!C||C=="Material")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Materials/A in usr.contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Material",Subject)),"Item-Panel:UpdateItems")
				if(!C||C=="General")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/A in usr.contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						if(!istype(A,/obj/Item/Wear)&&!istype(A,/obj/Item/Food)&&!istype(A,/obj/Item/Materials))
							usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
							Verbs2=null
							if(istype(A,/obj/Item/Smelting/PortaForge))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Smelt</button>
									<button class="Verb" onclick="UseVerb(this)">Fill</button>"}
							if(istype(A,/obj/Item/Usable/Leaf))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Focus</button>"}
							if(istype(A,/obj/Item/Usable/CatCollar))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Track</button>"}
							else if(istype(A,/obj/Item/Usable/BingoBook)||istype(A,/obj/Item/Usable/Map)||istype(A,/obj/Item/Usable/GuideBook)||istype(A,/obj/Item/Usable/BingoBook))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Read</button>"}
							else if(istype(A,/obj/Item/Usable/GarbageNet)||istype(A,/obj/Item/Usable/FishingRod))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Fish</button>"}
							else if(istype(A,/obj/Item/Food/Edible))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Eat</button>"}
							else if(istype(A,/obj/Item/Food/Drinks))
								Verbs2 += \
									{"<button class="Verb" onclick="UseVerb(this)">Drinks</button>"}
							Verbs2 +=Verbs1
							Subject += \
								{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("General",Subject)),"Item-Panel:UpdateItems")
			if(B=="Jutsu"||!B)
				Verbs1= \
					{"<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
				if(M.GM>=1)
					Verbs1 += \
						{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
					if(M.GM>=4)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
							<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
				if(!C||C=="Clan")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/SkillCards/Clan/A in usr.contents)
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.name].png")
						Verbs2=null
						if(!istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
						if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Upgrade</button>"}
						if(istype(A,/obj/SkillCards/Bunshin))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Dispel</button>
								<button class="Verb" onclick="UseVerb(this)">Follow</button>
								<button class="Verb" onclick="UseVerb(this)">Options</button>"}
						C1++
						if(C1==4)
							B1--
							C1=0
						if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Locate</button>
								<button class="Verb" onclick="UseVerb(this)">Place</button>"}
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetSkill=A
							if(PetSkill.HasPet&&M.DogOut)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Pick Up</button>
									<button class="Verb" onclick="UseVerb(this)">Sic</button>
									<button class="Verb" onclick="UseVerb(this)">Heel</button>
									<button class="Verb" onclick="UseVerb(this)">Follow</button>
									<button class="Verb" onclick="UseVerb(this)">Track</button>"}
							else if(PetSkill.HasPet)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Stats</button>
									<button class="Verb" onclick="UseVerb(this)">Summon</button>"}
							/*else
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Tame</button>"}*/
						if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Create</button>"}
						if(istype(A,/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Release</button>"}
						if(istype(A,/obj/SkillCards/Clan/TaiSpec/Hachimon))
							Verbs2+= \
								{"<button class="Verb" onclick="UseVerb(this)">Close</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Jutsu" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Clan",Subject)),"Jutsu-Panel:UpdateItems")
				if(!C||C=="Ninjutsu")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/SkillCards/A in usr.contents)
						if(A.Type=="Ninjutsu"&&!istype(A,/obj/SkillCards/Clan))
							usr << browse_rsc(icon(A.icon, A.icon_state), "[A.name].png")
							Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
							if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Upgrade</button>"}
							if(istype(A,/obj/SkillCards/Bunshin))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Dispel</button>
								<button class="Verb" onclick="UseVerb(this)">Attack</button>
								<button class="Verb" onclick="UseVerb(this)">Follow</button>
								<button class="Verb" onclick="UseVerb(this)">Stop</button>
									<button class="Verb" onclick="UseVerb(this)">Options</button>"}
							if(istype(A,/obj/SkillCards/Throwing)&&A.Mastery>=5)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Switch</button>"}
							C1++
							if(C1==4)
								B1--
								C1=0
							if(istype(A,/obj/SkillCards/Misc/Henge_no_Jutsu))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Remember</button>
									<button class="Verb" onclick="UseVerb(this)">Forget</button>"}
							Verbs2 +=Verbs1
							Subject += \
								{"<div class="Jutsu" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Ninjutsu",Subject)),"Jutsu-Panel:UpdateItems")
				if(!C||C=="Genjutsu")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/SkillCards/A in usr.contents)
						if(A.Type=="Genjutsu"&&!istype(A,/obj/SkillCards/Clan))
							usr << browse_rsc(icon(A.icon, A.icon_state), "[A.name].png")
							Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
							if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Upgrade</button>"}
							if(istype(A,/obj/SkillCards/Bunshin))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Dispel</button>
									<button class="Verb" onclick="UseVerb(this)">Follow</button>
									<button class="Verb" onclick="UseVerb(this)">Options</button>"}
							C1++
							if(C1==4)
								B1--
								C1=0
							Verbs2 +=Verbs1
							Subject += \
								{"<div class="Jutsu" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Genjutsu",Subject)),"Jutsu-Panel:UpdateItems")
				if(!C||C=="Taijutsu")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/SkillCards/A in usr.contents)
						if(A.Type=="Taijutsu"&&!istype(A,/obj/SkillCards/Clan))
							usr << browse_rsc(icon(A.icon, A.icon_state), "[A.name].png")
							Verbs2= \
									{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
							if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Upgrade</button>"}
							if(istype(A,/obj/SkillCards/Bunshin))
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Dispel</button>
									<button class="Verb" onclick="UseVerb(this)">Follow</button>
									<button class="Verb" onclick="UseVerb(this)">Options</button>"}
							C1++
							if(C1==4)
								B1--
								C1=0
							Verbs2 +=Verbs1
							Subject += \
								{"<div class="Jutsu" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.name].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					if(Subject)
						src << output(list2params(list("Taijutsu",Subject)),"Jutsu-Panel:UpdateItems")

			/*for(var/obj/Item/A in usr.contents)
				usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
				Verbs=null
				if(M.GM>=4)
					Verbs += \
					{"<button class="Verb" id="VEdit" ObjReference="\ref[A]" onclick="UseVerb(this)">Edit</button>"}
				Verbs += \
				{"<button class="Verb" id="VInspect" ObjReference="\ref[A]" onclick="UseVerb(this)">Inspect</button>
				<button class="Verb" id="VDrop" ObjReference="\ref[A]" onclick="UseVerb(this)">Drop</button>"}
				if(istype(A,/obj/Item/Wear/Weapons))
					if(istype(A,/obj/Item/Wear/Weapons/Wield))
						Verbs += \
						{"<button class="Verb" ObjReference="\ref[A]" onclick="UseVerb(this)">Equip</button>"}
					Weapons += \
					{"<div class="Item" ObjRef="\ref[A]" Total="[A.Total]" ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs]</div></div>"}
				else if(istype(A,/obj/Item/Wear/Clothes))
					Verbs += \
					{"<button class="Verb" ObjReference="\ref[A]" onclick="UseVerb(this)">Equip</button>"}
					Clothing += \
					{"<div class="Item" ObjRef="\ref[A]" Total="[A.Total]" ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs]</div></div>"}
				else if(istype(A,/obj/Item/Food))
					Food += \
					{"<div class="Item" ObjRef="\ref[A]" Total="[A.Total]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs]</div></div>"}
				else if(istype(A,/obj/Item/Materials))
					Material += \
					{"<div class="Item" ObjRef="\ref[A]" Total="[A.Total]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs]</div></div>"}
				else
					General += \
					{"<div class="Item" ObjRef="\ref[A]" Total="[A.Total]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs]</div></div>"}
			*/