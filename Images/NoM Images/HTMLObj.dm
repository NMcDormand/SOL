mob/Living/Player
	proc
		HTMLITEMGEN(ObType,Send)
			set background=1
			var
				PLAYER(M) = src
				Tock = 1
				OTock = 1
				HTML
				Verbs1
				Verbs2

			if(ObType == "Item"||!ObType)
				var
					General
					Weapons
					Clothing
					Food
					Material
					IHTML
				Verbs1={"
					<button class="Verb1" onclick="UseVerb(this)">Drop</button>
					<button class="Verb2" onclick="UseVerb(this)">Inspect</button>"}
				if(M.GM>=1)
					Verbs1 += \
						{"<button class="Verb1" onclick="UseVerb(this)">Analysis</button>"}
					OTock=2
					if(M.GM>=4)
						Verbs1 += {"<button class="Verb1" onclick="UseVerb(this)">Edit</button>
							<button class="Verb2" onclick="UseVerb(this)">Delete</button>"}
						OTock=1
				for(var/obj/Item/A in usr.contents)
					usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
					Tock=OTock
					Verbs2=null
					if(istype(A,/obj/Item/Wear/Weapons))
						var/obj/Item/Wear/ITEM = A
						if(istype(A,/obj/Item/Wear/Weapons/Wield))
							Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Equip</button>"}
							Tock = Tock == 1 ? 2 : 1
							if(istype(A,/obj/Item/Wear/Weapons/Wield/Special/Mist/Samehada))
								Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Wrap</button>"}
								Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Wear/Weapons/Thrown))
							Verbs2 += {"<button class="Verb[Tock]" onclick="UseVerb(this)">Throw</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 +=Verbs1
						Weapons += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ObjEquipped="[ITEM.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs" >
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(istype(A,/obj/Item/Wear/Clothes))
						var/obj/Item/Wear/ITEM = A
						Verbs2 += {"<button class="Verb[Tock]" onclick="UseVerb(this)">Equip</button>"}
						Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Wear/Clothes/Special/Gourd))
							Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Fill</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 +=Verbs1
						Clothing += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ObjEquipped="[ITEM.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(istype(A,/obj/Item/Food))
						Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Use</button>"}
						Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Food/Edible))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Eat</button>"}
						else if(istype(A,/obj/Item/Food/Drinks))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Drinks</button>"}
						Verbs2 +=Verbs1
						Food += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(istype(A,/obj/Item/Materials))
						Verbs2 +=Verbs1
						Material += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else
						if(istype(A,/obj/Item/Smelting/PortaForge))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Smelt</button>
								<button class="Verb[Tock == 1 ? 2 : 1]" onclick="UseVerb(this)">Fill</button>"}
						if(istype(A,/obj/Item/Usable/Leaf))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Focus</button>"}
						else if(istype(A,/obj/Item/Usable/BingoBook)||istype(A,/obj/Item/Usable/Map)||istype(A,/obj/Item/Usable/GuideBook)||istype(A,/obj/Item/Usable/Scroll))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Read</button>"}
						else if(istype(A,/obj/Item/Usable/GarbageNet)||istype(A,/obj/Item/Usable/FishingRod))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Fish</button>"}
						Verbs2 +=Verbs1
						General += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
				IHTML={"
						<div class="StCont" id="GenItems">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">General</button>
							<div id="General" style="display:none;">
								[General]
							</div>
						</div>
						<div class="StCont" id="WeaItems">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Weapons</button>
							<div id="Weapons" style="display:none;">
								[Weapons]
							</div>
						</div>
						<div class="StCont" id="CloItems">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Clothing</button>
							<div style="display:none;">
								[Clothing]
							</div>
						</div>
						<div class="StCont" id="FooItems">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Food</button>
							<div id="Food" style="display:none;">
								[Food]
							</div>
						</div>
						<div class="StCont" id="MatItems">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Materials</button>
							<div id="Materials" style="display:none;">
								[Material]
							</div>
						</div>
					"}
				if(Send)
					M << output(list2params(list("TechPage",IHTML)),"Panel1:ForceITIn")
					M << output(list2params(list("TechPage",IHTML)),"Panel2:ForceITIn")
					M << output(list2params(list("TechPage",IHTML)),"Panel3:ForceITIn")
					M << output(list2params(list("TechPage",IHTML)),"Panel4:ForceITIn")
					return
				else
					HTML = {"
						<div class="GamePage" id="ItemPage" style="display:none;">
							[IHTML]
						</div>
					}
					"}
			//Jutsu
			if(ObType == "Jutsu"||!ObType)
				var
					Clanjutsu
					Ninjutsu
					Genjutsu
					Taijutsu
					ProfJutsu
					JHTML
				Tock = 1
				OTock = 1
				Verbs1 = {"<button class="Verb1" onclick="UseVerb(this)">Inspect</button>"}
				Verbs2 = ""
				if(M.GM>=1)
					Verbs1 += {"<button class="Verb2" onclick="UseVerb(this)">Analyse</button>"}
					OTock = 1
					if(M.GM>=4)
						Verbs1 += {"
							<button class="Verb2" onclick="UseVerb(this)">Edit</button>
							<button class="Verb1" onclick="UseVerb(this)">Delete</button>"}
						OTock = 2
				for(var/obj/SkillCards/A in contents)
					usr << browse_rsc(icon(A.icon, A.icon_state), "[A.EName].png")
					Tock = OTock
					if(!istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
						Verbs2= {"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
					if(A.Mastery>=2&&A.PsvLvl==1||A.Mastery>=5&&A.PsvLvl==2||A.Mastery>9&&A.PsvLvl==3)
						Verbs2+= \
							{"<button class="Verb[Tock]" onclick="UseVerb(this)">Upgrade</button>"}
						Tock = Tock == 1 ? 2 : 1
					if(istype(A,/obj/SkillCards/Bunshin))
						var/Tick = Tock == 1 ? 2 : 1
						Verbs2+= {"
							<button class="Verb[Tock]" onclick="UseVerb(this)">Dispel</button>
							<button class="Verb[Tick]" onclick="UseVerb(this)">Attack</button>
							<button class="Verb[Tock]" onclick="UseVerb(this)">Follow</button>
							<button class="Verb[Tick]" onclick="UseVerb(this)">Stop</button>
							<button class="Verb[Tock]" onclick="UseVerb(this)">Options</button>
						"}
						Tock=Tick
					if(istype(A,/obj/SkillCards/Throwing)&&A.Mastery>=5)
						Verbs2+= \
							{"<button class="Verb" onclick="UseVerb(this)">Switch</button>"}
						Tock = Tock == 1 ? 2 : 1
					if(istype(A,/obj/SkillCards/Clan))
						if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
							Verbs2+= \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Locate</button>
								<button class="Verb[Tock == 1 ? 2 : 1]" onclick="UseVerb(this)">Place</button>"}
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetSkill=A
							if(PetSkill.HasPet&&M.PetOut)
								var/Tick = Tock == 1 ? 2 : 1
								Verbs2+= {"
									<button class="Verb[Tock]" onclick="UseVerb(this)">Pick Up</button>
									<button class="Verb[Tick]" onclick="UseVerb(this)">Sic</button>
									<button class="Verb[Tock]" onclick="UseVerb(this)">Heel</button>
									<button class="Verb[Tick]" onclick="UseVerb(this)">Follow</button>
									<button class="Verb[Tock]" onclick="UseVerb(this)">Learn Scent</button>
									"}
								Tock=Tick
								if(PetSkill.Tracking)
									Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Track</button>"}
							else if(PetSkill.HasPet)
								Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Stats</button>
									<button class="Verb[Tock == 1 ? 2 : 1 ]" onclick="UseVerb(this)">Summon</button>"}
							/*else
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Tame</button>"}*/

						if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							Verbs2= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Create</button>"}
							Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu))
							Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Release</button>"}
							Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/SkillCards/Clan/TaiSpec/Hachimon))
							Verbs2+= \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Close</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 +=Verbs1
						Clanjutsu += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(istype(A,/obj/SkillCards/Profession))
						Verbs2 +=Verbs1
						ProfJutsu += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(A.Type=="Ninjutsu")
						if(istype(A,/obj/SkillCards/Misc/Henge_no_Jutsu))
							Verbs2+= \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Remember</button>
								<button class="Verb[Tock == 1 ? 2 : 1]" onclick="UseVerb(this)">Forget</button>"}
						Verbs2 +=Verbs1
						Ninjutsu += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(A.Type=="Genjutsu")
						Verbs2 +=Verbs1
						Genjutsu += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					else if(A.Type=="Taijutsu")
						Verbs2 +=Verbs1
						Taijutsu += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
				JHTML+={"
						<div class="StCont" id="GeneTechs">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Profession</button>
							<div id="Profession" style="display:none;">
								[ProfJutsu]
							</div>
						</div>
						<div class="StCont" id="NinTechs">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Ninjutsu</button>
							<div id="Ninjutsu" style="display:none;">
								[Ninjutsu]
							</div>
						</div>
						<div class="StCont" id="TaiTechs">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Taijutsu</button>
							<div id="Taijutsu" style="display:none;">
								[Taijutsu]
							</div>
						</div>
						<div class="StCont" id="GenTechs">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Genjutsu</button>
							<div id="Genjutsu" style="display:none;">
								[Genjutsu]
							</div>
						</div>
						<div class="StCont" id="ClanTechs">
							<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Clan Jutsu</button>
							<div id="Clan" style="display:none;">
								[Clanjutsu]
							</div>
						</div>
					"}
				if(Send)
					M << output(list2params(list("TechPage",JHTML)),"Panel1:ForceITIn")
					M << output(list2params(list("TechPage",JHTML)),"Panel2:ForceITIn")
					M << output(list2params(list("TechPage",JHTML)),"Panel3:ForceITIn")
					M << output(list2params(list("TechPage",JHTML)),"Panel4:ForceITIn")
					return
				else
					HTML += {"
					<div class="GamePage" id="TechPage" style="display:none;">
						[JHTML]
					</div>
					"}
				return HTML

		HTMLITEMUPDATE(B,C)
			set background=1
			set waitfor=0
			var
				HTML
				PLAYER(M)=src
				Verbs1
				Verbs2
				Tock = 1
				OTock = 1
			if(B=="Items")
				Verbs1= \
					{"<button class="Verb1" onclick="UseVerb(this)">Drop</button>
					<button class="Verb2" onclick="UseVerb(this)">Inspect</button>"}
				if(M.GM>=1)
					Verbs1 += \
						{"<button class="Verb1" onclick="UseVerb(this)">Analyse</button>"}
					OTock=2
					if(M.GM>=4)
						Verbs1 += {"<button class="Verb1" onclick="UseVerb(this)">Edit</button>
							<button class="Verb2" onclick="UseVerb(this)">Delete</button>"}
						OTock=1
				if(!C||C=="Weapons")
					for(var/obj/Item/Wear/Weapons/A in usr.contents)
						Tock=OTock
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = null
						var/obj/Item/Wear/ITEM = A
						if(istype(A,/obj/Item/Wear/Weapons/Wield))
							Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Equip</button>"}
							Tock = Tock == 1 ? 2 : 1
							if(istype(A,/obj/Item/Wear/Weapons/Wield/Special/Mist/Samehada))
								Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Wrap</button>"}
								Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Wear/Weapons/Thrown))
							Verbs2 += {"<button class="Verb[Tock]" onclick="UseVerb(this)">Throw</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 +=Verbs1
						HTML += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ObjEquipped="[ITEM.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs" >
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					if(HTML)
						M << output(list2params(list("Weapons",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Weapons",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Weapons",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Weapons",HTML)),"Panel4:UpdateItems")
				if(!C||C=="Clothing")
					HTML = null
					for(var/obj/Item/Wear/Clothes/A in usr.contents)
						Tock=OTock
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = null
						var/obj/Item/Wear/ITEM = A
						Verbs2 += {"<button class="Verb[Tock]" onclick="UseVerb(this)">Equip</button>"}
						Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Wear/Clothes/Special/Gourd))
							Verbs2 +={"<button class="Verb[Tock]" onclick="UseVerb(this)">Fill</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 += Verbs1
						HTML += {"
							<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ObjEquipped="[ITEM.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
								<div>
									<span class="OName">[A.name]</span>
									<img class="Image" src='[A.Name1].png'>
									<div class="OInfo">
										<span>Value: [A.Price]</span>
										<span>Material: [A.Material]</span>
									</div>
									<div class="OVerbs" >
										[Verbs2]
									</div>
								</div>
							</div>
						"}
					if(HTML)
						M << output(list2params(list("Clothing",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Clothing",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Clothing",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Clothing",HTML)),"Panel4:UpdateItems")
				if(!C||C=="Food")
					HTML = null
					for(var/obj/Item/Food/A in usr.contents)
						Tock=OTock
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = {"<button class="Verb[Tock]" onclick="UseVerb(this)">Use</button>"}
						Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/Item/Food/Edible))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Eat</button>"}
						else if(istype(A,/obj/Item/Food/Drinks))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Drinks</button>"}
						Verbs2 +=Verbs1
						HTML += {"
							<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
								<div>
									<span class="OName">[A.name]</span>
									<img class="Image" src='[A.Name1].png'>
									<div class="OInfo">
										<span>Value: [A.Price]</span>
										<span>Material: [A.Material]</span>
									</div>
									<div class="OVerbs" >
										[Verbs2]
									</div>
								</div>
							</div>
						"}
					if(HTML)
						M << output(list2params(list("Food",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Food",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Food",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Food",HTML)),"Panel4:UpdateItems")
				if(!C||C=="Material")
					HTML = null
					for(var/obj/Item/Materials/A in usr.contents)
						Tock=OTock
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 +=Verbs1
						HTML += {"
							<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
								<div>
									<span class="OName">[A.name]</span>
									<img class="Image" src='[A.Name1].png'>
									<div class="OInfo">
										<span>Value: [A.Price]</span>
										<span>Material: [A.Material]</span>
									</div>
									<div class="OVerbs" >
										[Verbs2]
									</div>
								</div>
							</div>
						"}
					if(HTML)
						M << output(list2params(list("Materials",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Materials",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Materials",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Materials",HTML)),"Panel4:UpdateItems")
				if(!C||C=="General")
					HTML = null
					for(var/obj/Item/A in usr.contents)
						Tock=OTock
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = null
						if(istype(A,/obj/Item/Smelting/PortaForge))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Smelt</button>
								<button class="Verb[Tock == 1 ? 2 : 1]" onclick="UseVerb(this)">Fill</button>"}
						else if(istype(A,/obj/Item/Usable/Leaf))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Focus</button>"}
						else if(istype(A,/obj/Item/Usable/BingoBook)||istype(A,/obj/Item/Usable/Map)||istype(A,/obj/Item/Usable/GuideBook)||istype(A,/obj/Item/Usable/Scroll))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Read</button>"}
						else if(istype(A,/obj/Item/Usable/GarbageNet)||istype(A,/obj/Item/Usable/FishingRod))
							Verbs2 += \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Fish</button>"}
						Verbs2 +=Verbs1
						HTML += {"
						<div class="OBJ"  id="OBJ[A.Name1]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.Name1].png'>
								<div class="OInfo">
									<span>Value: [A.Price]</span>
									<span>Material: [A.Material]</span>
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					if(HTML)
						M << output(list2params(list("General",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("General",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("General",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("General",HTML)),"Panel4:UpdateItems")

			if(B=="Jutsu"||!B)
				Tock = 1
				OTock = 1
				Verbs1 = {"<button class="Verb1" onclick="UseVerb(this)">Inspect</button>"}
				Verbs2 = ""
				if(M.GM>=1)
					Verbs1 += {"<button class="Verb2" onclick="UseVerb(this)">Analyse</button>"}
					OTock = 1
					if(M.GM>=4)
						Verbs1 += {"
							<button class="Verb2" onclick="UseVerb(this)">Edit</button>
							<button class="Verb1" onclick="UseVerb(this)">Delete</button>"}
						OTock = 2

				if(!C||C=="Clan")
					for(var/obj/SkillCards/Clan/A in contents)
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = null
						if(istype(A,/obj/SkillCards/Clan/Aburame/Bugs))
							Verbs2+= \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Locate</button>
								<button class="Verb[Tock == 1 ? 2 : 1]" onclick="UseVerb(this)">Place</button>"}
						if(istype(A,/obj/SkillCards/Clan/Inuzuka/Pet))
							var/obj/SkillCards/Clan/Inuzuka/Pet/PetSkill=A
							if(PetSkill.HasPet&&M.PetOut)
								var/Tick = Tock == 1 ? 2 : 1
								Verbs2+= {"
									<button class="Verb[Tock]" onclick="UseVerb(this)">Pick Up</button>
									<button class="Verb[Tick]" onclick="UseVerb(this)">Sic</button>
									<button class="Verb[Tock]" onclick="UseVerb(this)">Heel</button>
									<button class="Verb[Tick]" onclick="UseVerb(this)">Follow</button>
									<button class="Verb[Tock]" onclick="UseVerb(this)">Learn Scent</button>
									"}
								Tock=Tick
								if(PetSkill.Tracking)
									Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Track</button>"}
							else if(PetSkill.HasPet)
								Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Stats</button>
									<button class="Verb[Tock == 1 ? 2 : 1 ]" onclick="UseVerb(this)">Summon</button>"}
							/*else
								Verbs2+= \
									{"<button class="Verb" onclick="UseVerb(this)">Tame</button>"}*/

						if(istype(A,/obj/SkillCards/Clan/Kaguya/Bone_Weapons))
							Verbs2= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Create</button>"}
							Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/SkillCards/Clan/Nara/Kagemane_no_Jutsu))
							Verbs2+= {"<button class="Verb[Tock]" onclick="UseVerb(this)">Release</button>"}
							Tock = Tock == 1 ? 2 : 1
						if(istype(A,/obj/SkillCards/Clan/TaiSpec/Hachimon))
							Verbs2+= \
								{"<button class="Verb[Tock]" onclick="UseVerb(this)">Close</button>"}
							Tock = Tock == 1 ? 2 : 1
						Verbs2 +=Verbs1
						HTML += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					if(HTML)
						M << output(list2params(list("Clan",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Clan",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Clan",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Clan",HTML)),"Panel4:UpdateItems")
				if(!C||C=="Profession")
					for(var/obj/SkillCards/Clan/A in contents)
						M << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2 = null
						Verbs2 +=Verbs1
						HTML += {"
						<div class="OBJ"  id="OBJ[A.EName]" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="ContextME(this)">
							<div>
								<span class="OName">[A.name]</span>
								<img class="Image" src='[A.EName].png'>
								<div class="OInfo">
								</div>
								<div class="OVerbs">
									[Verbs2]
								</div>
							</div>
						</div>
						"}
					if(HTML)
						M << output(list2params(list("Profession",HTML)),"Panel1:UpdateItems")
						M << output(list2params(list("Profession",HTML)),"Panel2:UpdateItems")
						M << output(list2params(list("Profession",HTML)),"Panel3:UpdateItems")
						M << output(list2params(list("Profession",HTML)),"Panel4:UpdateItems")
				else
					M.HTMLITEMGEN("Jutsu",1)
/*<div class="OBJ"  ObjRef="\ref[A]" ondblclick="" oncontextmenu="ContextME(this)">
	<div>
		<span class="OName">Tech Name</span>
		<img class="Image" src='https://lh3.googleusercontent.com/CuJMNS31ba0wHi1rLJZhX_b7Xm6yMXYMOkBzpf7hKsftae-aTj0xvWgUiHuvX29_G6rrenWKbSLbNWXu4GeoXrc=s400'>
		<div class="OInfo">
			<span>This is a Technique</span>
			<span>This is a Technique</span>
		</div>
		<div class="OVerbs" style="display:;">
			<button class="Verb1">Use</button>
			<button class="Verb2">Eat</button>
		</div>
	</div>
</div>*/