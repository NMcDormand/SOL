var/rsc=list('Skin/GuideBook/Guide.css','Skin/GuideBook/Guide.js','Skin/Color Selection/js/colorpicker.js','Skin/Color Selection/js/eye.js','Skin/Color Selection/js/jquery.js','Skin/Color Selection/js/layout.js','Skin/Color Selection/js/utils.js','Skin/Color Selection/css/colorpicker.css',
'Skin/Color Selection/images/colorpicker_background.png','Skin/Color Selection/images/colorpicker_hex.png','Skin/Color Selection/images/colorpicker_hsb_b.png','Skin/Color Selection/images/colorpicker_hsb_h.png','Skin/Color Selection/images/colorpicker_hsb_s.png','Skin/Color Selection/images/colorpicker_indic.gif',
'Skin/Color Selection/images/colorpicker_overlay.png','Skin/Color Selection/images/colorpicker_rgb_b.png','Skin/Color Selection/images/colorpicker_rgb_g.png','Skin/Color Selection/images/colorpicker_rgb_r.png','Skin/Color Selection/images/colorpicker_select.gif','Skin/Color Selection/images/colorpicker_submit.png')
mob/Living/Player
	proc

		ChatSwap(A)
			winset(src,"Say","is-visible=true")
			winset(src,"Command","is-visible=true")
			winset(src,"GOOC","is-visible=true")
			winset(src,"VSay","is-visible=true")
			winset(src,"OOC","is-visible=true")
			winset(src,"ChatSay","is-visible=false")
			winset(src,"ChatV.Say","is-visible=false")
			winset(src,"ChatGOOC","is-visible=false")
			winset(src,"ChatOOC","is-visible=false")
			winset(src,"ChatCmd","is-visible=false")
			IsSay=0
			switch(A)
				if("Say")
					winset(src,"SayG","is-visible=true")
					winset(src,"Say","is-visible=false")
					winset(src,"ChatSay","is-visible=true")
					winset(src,"MainWindow.Input","command=OtherSayP2")
					src:IsSay=1
				if("GOOC")
					winset(src,"GOOCG","is-visible=true")
					winset(src,"GOOC","is-visible=false")
					winset(src,"ChatGOOC","is-visible=true")
					winset(src,"MainWindow.Input","command=GOOC")
				if("OOC")
					winset(src,"OOCG","is-visible=true")
					winset(src,"OOC","is-visible=false")
					winset(src,"ChatOOC","is-visible=true")
					winset(src,"MainWindow.Input","command=OOC")
				if("VSay")
					winset(src,"VSayG","is-visible=true")
					winset(src,"VSay","is-visible=false")
					winset(src,"ChatV.Say","is-visible=true")
					winset(src,"MainWindow.Input","command=Village-Say")
				if("Cmd")
					winset(src,"CommandG","is-visible=true")
					winset(src,"Command","is-visible=false")
					winset(src,"ChatCmd","is-visible=true")
					winset(src,"MainWindow.Input","command=")
			winset(src,"OOCOn","is-visible=false")
			winset(src,"OOCOff","is-visible=false")
			winset(src,"child1","is-visible=false")
			ChatMenu=0
			overlays-=image('SpeachBubble.dmi',src)
			src:hasBubble=0
	verb
		ApplySP()
			set hidden=1
			if(Health.TPoin>0)
				Health.PPoin+=Health.TPoin
				Health.Multi+=Health.TPoin*0.05
				SpsSpent["Health"]+=Health.TPoin
				SpsSpent["Total"]+=Health.TPoin
				Health.TPoin=0
			if(Stamina.TPoin>0)
				Stamina.PPoin+=Stamina.TPoin
				Stamina.Multi+=Stamina.TPoin*0.05
				SpsSpent["Stamina"]+=Stamina.TPoin
				SpsSpent["Total"]+=Stamina.TPoin
				Stamina.TPoin=0
			if(Chakra.TPoin>0)
				Chakra.PPoin+=Chakra.TPoin
				Chakra.Multi+=Chakra.TPoin*0.05
				SpsSpent["Chakra"]+=Chakra.TPoin
				SpsSpent["Total"]+=Chakra.TPoin
				Chakra.TPoin=0
			if(Taijutsu.TPoin>0)
				Taijutsu.PPoin+=Taijutsu.TPoin
				Taijutsu.Multi+=Taijutsu.TPoin*0.05
				SpsSpent["Taijutsu"]+=Taijutsu.TPoin
				SpsSpent["Total"]+=Taijutsu.TPoin
				Taijutsu.TPoin=0
			if(Ninjutsu.TPoin>0)
				Ninjutsu.PPoin+=Ninjutsu.TPoin
				Ninjutsu.Multi+=Ninjutsu.TPoin*0.05
				SpsSpent["Ninjutsu"]+=Ninjutsu.TPoin
				SpsSpent["Total"]+=Ninjutsu.TPoin
				Ninjutsu.TPoin=0
			if(Genjutsu.TPoin>0)
				Genjutsu.PPoin+=Genjutsu.TPoin
				Genjutsu.Multi+=Genjutsu.TPoin*0.05
				SpsSpent["Genjutsu"]+=Genjutsu.TPoin
				SpsSpent["Total"]+=Genjutsu.TPoin
				Genjutsu.TPoin=0
			winset(usr,"StatPoints","is-visible=false")
			CalcStat(usr,"All")
			UpdateStat(usr)
			UpdateAll("Primary")
		ExitSP()
			set hidden=1
			if(Health.TPoin>0)
				Level.PPoin+=Health.TPoin
				Health.TPoin=0
			if(Stamina.TPoin>0)
				Level.PPoin+=Stamina.TPoin
				Stamina.TPoin=0
			if(Chakra.TPoin>0)
				Level.PPoin+=Chakra.TPoin
				Chakra.TPoin=0
			if(Taijutsu.TPoin>0)
				Level.PPoin+=Taijutsu.TPoin
				Taijutsu.TPoin=0
			if(Ninjutsu.TPoin>0)
				Level.PPoin+=Ninjutsu.TPoin
				Ninjutsu.TPoin=0
			if(Genjutsu.TPoin>0)
				Level.PPoin+=Genjutsu.TPoin
				Genjutsu.TPoin=0
			winset(usr,"StatPoints","is-visible=false")
		StatDown(t as text)
			set hidden=1
			StattingUp++
			if(StattingUp>1)
				StattingUp--
				return
			if(StattingUp==1)
				if(Level.CPoin)
					Level.CPoin--
					//if(Level.PPoin<Level.TPoin)
					Level.PPoin++
				if(t=="Health")
					if(Health.TPoin>0)
						Health.TPoin--
				else if(t=="Stamina")
					if(Stamina.TPoin>0)
						Stamina.TPoin--
				else if(t=="Chakra")
					if(Chakra.TPoin>0)
						Chakra.TPoin--
				else if(t=="Taijutsu")
					if(Taijutsu.TPoin>0)
						Taijutsu.TPoin--
				else if(t=="Ninjutsu")
					if(Ninjutsu.TPoin>0)
						Ninjutsu.TPoin--
				else if(t=="Genjutsu")
					if(Genjutsu.TPoin>0)
						Genjutsu.TPoin--
			UpdateStat(usr)
			spawn(5)
				StattingUp=0
		StatUp(t as text)
			set hidden=1
			if(StattingUp)
				return
			if(Level.PPoin)
				StattingUp=1
				Level.PPoin--
				Level.CPoin++
				if(t=="Health")
					Health.TPoin++
				else if(t=="Stamina")
					Stamina.TPoin++
				else if(t=="Chakra")
					Chakra.TPoin++
				else if(t=="Taijutsu")
					Taijutsu.TPoin++
				else if(t=="Ninjutsu")
					Ninjutsu.TPoin++
				else if(t=="Genjutsu")
					Genjutsu.TPoin++
			UpdateStat(usr)
			spawn(3)
				StattingUp=0


		CExamNext(n as num)
			set hidden=1
			winset(usr,"CEP1","is-visible=false")
			winset(usr,"CEP2","is-visible=false")
			if(n==1)
				winset(usr,"CEP1","is-visible=true")
			else if(n==2)
				winset(usr,"CEP2","is-visible=true")

		GExamNext(n as num)
			set hidden=1
			winset(usr,"GEP1","is-visible=false")
			winset(usr,"GEP2","is-visible=false")
			winset(usr,"GEP3","is-visible=false")
			if(n==1)
				winset(usr,"GEP1","is-visible=true")
			else if(n==2)
				winset(usr,"GEP2","is-visible=true")
			else if(n==3)
				winset(usr,"GEP3","is-visible=true")

		Minimize()
			set hidden=1
			winset(src,"MainWindow","is-minimized=true")
		Maximize()
			set hidden=1
			winset(src,"MainWindow","is-maximized=true")
			winset(src,"RestoreA","is-visible=true")
			winset(src,"Maximize","is-visible=false")
		RestoreA()
			set hidden=1
			winset(src,"MainWindow","is-maximized=false")
			winset(src,"RestoreA","is-visible=false")
			winset(src,"Maximize","is-visible=true")

		OpenChat()
			set hidden=1
			if(ChatMenu==1)
				winset(src,"child1","is-visible=false")
				ChatMenu=0
				winset(src,"OOCOn","is-visible=false")
				winset(src,"OOCOff","is-visible=false")
				return
			else
				winset(src,"child1","is-visible=true")
				ChatMenu=1
				if(Hear==1)
					winset(src,"OOCOn","is-visible=true")
					return
				else
					winset(src,"OOCOff","is-visible=true")

		CloseBook()
			set hidden =1
			winshow(src,"Book",0)
			winset(src,"Book.Chakra","is-visible=false")
			src<<output(null,"Book.PageOne")
			src<<output(null,"Book.PageTwo")

		ToGOOC()
			set hidden = 1
			ChatSwap("GOOC")

		ToVSay()
			set hidden = 1
			ChatSwap("VSay")

		ToOOC()
			set hidden = 1
			ChatSwap("OOC")

		ToCommand()
			set hidden = 1
			ChatSwap("Cmd")

		OtherSayP1()
			set hidden =1
			ChatSwap("Say")
			TypingChecker()

//Character Creation
mob
	verb
		ZeroBar()
			set hidden=1
			for(var/z=1 to 100)
				winset(src,"H[z]","is-visible=false")
				winset(src,"S[z]","is-visible=false")
				winset(src,"C[z]","is-visible=false")
		ColorPick(T as text)
			set hidden=1
			if(Hairisup==1)
				return
			if(T=="HairBrowser")
				if(src:tmphairname==null)
					return
				Hairisup=1
			winset(src,"[T]Child","is-visible=true")
			for(var/v in rsc)
				src<<browse_rsc(v,"[v]")
			src<<browse('index.html',"window=[T]B")
			color1="#NAN"
			for(var/I=0 to 999999999)
				if(color1!="#NAN")
					break
				sleep(1)
			if(!findtext(color1,"#"))
				color1="#[color1]"
			if(T=="DyeBrowser")
				src:DyeColor(color1)
			else if(T=="EyeBrowser")
				src:EyeColor(color1)
			else if(T=="HairBrowser")
				src:HairColor(color1)
				Hairisup=0
			else if(T=="HairBrowser2")
				src:HairColor(color1)
			src<<browse(null,"window=[T]B")
			winset(src,"[T]Child","is-visible=false")
		DyeColor(hex as text)
			set hidden=1
			if(!findtext(hex,"#"))
				hex="#[hex]"
			if(src:Dying==null)
				return
			else
				Dying.tmpdyehex=hex
				Dying.Again=1
				UpdateChar()
				Dying.Again=0
				UpdateChar()
		SelectHair(N as text|null,G as num)
			set hidden=1
			var/A=null
			var/B=null
			if(icon!=null)
				if(src:hairhex!=null)
					A=src:hairhex
				if(src:tmphairhex!=null)
					A=src:tmphairhex
				if(src:hairname!=null)
					B=src:hairname
				if(src:tmphairname!=null)
					B=src:tmphairname
				if(A!=null)
					var/icon/I=icon(GetHair(B))
					I.Blend("[A]")
					overlays-=I
				else
					overlays-=icon(GetHair(B))
				src:tmphairname=N
				if(N==null)
					src:tmphairname=null
				else
					if(A!=null)
						if(G)
							HairColor(src:hairhex)
						else
							HairColor(A)
					else
						overlays+=icon(GetHair("[src:tmphairname]"))
				UpdateChar()

		EyeColor(hex as text)
			set hidden = 1
			if(!findtext(hex,"#"))
				hex="#[hex]"
			if(icon!=null)
				if(eyehex!=null)
					var/icon/I=new('eyes.dmi')
					I.Blend("[eyehex]")
					overlays-=I
				var/icon/I = new('eyes.dmi')
				I.Blend("[hex]")
				overlays+=I
				eyehex=hex
				UpdateChar()

		HairColor(hex as text)
			set hidden=1
			if(!findtext(hex,"#"))
				hex="#[hex]"
			if(src:hairname==null&&src:tmphairname==null)
				return
			var/A=null
			var/B=null
			if(src:hairname!=null)
				A=src:hairname
			if(src:tmphairname!=null)
				A=src:tmphairname
			if(src:hairhex!=null)
				B=src:hairhex
			if(src:tmphairhex!=null)
				B=src:tmphairhex
			var/icon/G=icon(GetHair("[A]"))
			if(G)
				if(B)
					var/icon/I=new(G)
					I.Blend("[B]")
					overlays-=I
				else
					overlays-=G
				var/icon/I = new(G)
				I.Blend("[hex]")
				overlays+=I
				src:tmphairhex=hex
			UpdateChar()
		ChangeDir(N as num)
			set hidden=1
			if(N==1)
				dir=NORTH
			else if(N==2)
				dir=SOUTH
			else if(N==3)
				dir=EAST
			else if(N==4)
				dir=WEST
			UpdateChar()
	Living/Player
		verb
			Barbery(T as text)
				set hidden=1
				if(T=="Accept")
					hairname=tmphairname
					hairhex=tmphairhex
					SelectHair(hairname,0)
					winset(usr,"Barber","is-visible=false")
				else
					SelectHair(hairname,1)
					winset(usr,"Barber","is-visible=false")
				if(hairname=="Deidara")
					overlays+='Deidara-Band.dmi'
				else if(hairname=="Kimimaro")
					overlays+='Kimimaro-Beads.dmi'
				/*else if(hairname=="Konan")
					overlays+='Konan-Bun.dmi'*/
				else if(hairname=="Shikamaru")
					overlays+='Shikamaru-Band.dmi'
				else if(hairname=="Temari")
					overlays+='Temari-Band.dmi'
				tmphairname=null
				tmphairhex=null
				currentpage=null
			Dye(T as text)
				set hidden=1
				if(T=="Cancel")
					winset(usr,"ClothesDye","is-visible=false")
					currentpage=null
					return
				if(usr.Dying!=null)
					usr.Dying.dyehex=usr.Dying.tmpdyehex
					var/obj/E=new Dying.type
					var/icon/CC=new(E.icon)
					CC.Blend("[Dying.dyehex]")
					if(Dying.Equipped)
						var/icon/C=new(Dying.icon)
						overlays-=C
					Dying.icon=CC
					if(Dying.Equipped)
						var/icon/G=new(Dying.icon)
						overlays+=G
			Settings(T as num)
				set hidden=1
				switch(T)
					if(1)
						if(FiltCurse)
							winset(src,"button69","is-checked=true")
						else
							winset(src,"button70","is-checked=true")
						if(FiltRace)
							winset(src,"button71","is-checked=true")
						else
							winset(src,"button72","is-checked=true")
						if(FiltSex)
							winset(src,"button73","is-checked=true")
						else
							winset(src,"button74","is-checked=true")
						if(PM)
							winset(src,"button75","is-checked=true")
						else
							winset(src,"button76","is-checked=true")
						if(Hear)
							winset(src,"button77","is-checked=true")
						else
							winset(src,"button78","is-checked=true")
						if(AtName)
							winset(src,"button79","is-checked=true")
						else
							winset(src,"button80","is-checked=true")
						if(ARequest)
							winset(src,"button81","is-checked=true")
						else
							winset(src,"button82","is-checked=true")
						if(GRequest)
							winset(src,"button83","is-checked=true")
						else
							winset(src,"button84","is-checked=true")
						if(JutsuLang=="English")
							winset(src,"button85","is-checked=true")
						else
							winset(src,"button86","is-checked=true")
						if(RunDrain)
							winset(src,"button87","is-checked=true")
						else
							winset(src,"button88","is-checked=true")
						winset(src,"Settings","is-visible=true")
					if(2)
						winset(src,"Settings","is-visible=false")
					if(3)
						winset(src,"Settings","is-visible=false")
						var/a=params2list(winget(src,"button69;button70;button71;button72;button73;button74;button75;button76;button77;button78;button79;button80;button81;button82;button83;button84;button85;button86;button87;button88","is-checked"))
						if(a["button69.is-checked"]=="true")
							if(!FiltCurse)
								FiltCurse=1
								src<<"[AINAME]: Filtering out cursing"
						if(a["button70.is-checked"]=="true")
							if(FiltCurse)
								FiltCurse=0
								src<<"[AINAME]: No longer filtering out cursing"
						if(a["button71.is-checked"]=="true")
							if(!FiltRace)
								FiltRace=1
								src<<"[AINAME]: Filtering out racist content"
						if(a["button72.is-checked"]=="true")
							if(FiltRace)
								FiltRace=0
								src<<"[AINAME]: No longer filtering out racist content"
						if(a["button73.is-checked"]=="true")
							if(!FiltSex)
								FiltSex=1
								src<<"[AINAME]: Filtering out homophobic content"
						if(a["button74.is-checked"]=="true")
							if(FiltSex)
								FiltSex=0
								src<<"[AINAME]: No longer filtering out homophobic content"
						if(a["button75.is-checked"]=="true")
							if(!PM)
								PM=1
								src<<"[AINAME]: Receiving Private Messages"
						if(a["button76.is-checked"]=="true")
							if(PM)
								PM=0
								src<<"[AINAME]: No longer receiving Private Messages"
						if(a["button77.is-checked"]=="true")
							if(!Hear)
								Hear=1
								src<<"[AINAME]: You turn your OOC <u><b><a style=text-decoration:none;color:#00db24; href=?src=\ref[src];action=OOC>ON</a></b></u>"
								if(ChatMenu==1)
									winset(src,"OOCOff","is-visible=false")
									winset(src,"OOCOn","is-visible=true")
						if(a["button78.is-checked"]=="true")
							if(Hear)
								Hear=0
								src<<"[AINAME]: You turn your OOC <u><b><a style=text-decoration:none;color:#db0000; href=?src=\ref[src];action=OOC>OFF</a></b></u>"
								if(ChatMenu==1)
									winset(src,"OOCOff","is-visible=true")
									winset(src,"OOCOn","is-visible=false")
						if(a["button79.is-checked"]=="true")
							if(!AtName)
								AtName=1
								src<<"[AINAME]: Messages directed at you in OOC will be highlighted"
						if(a["button80.is-checked"]=="true")
							if(AtName)
								AtName=0
								src<<"[AINAME]: Messages directed at you in OOC will no longer be highlighted"
						if(a["button81.is-checked"]=="true")
							if(!ARequest)
								ARequest=1
								src<<"[AINAME]: You will receive arena requests"
						if(a["button82.is-checked"]=="true")
							if(ARequest)
								ARequest=0
								src<<"[AINAME]: You will no longer receive arena requests"
						if(a["button83.is-checked"]=="true")
							if(!GRequest)
								GRequest=1
								src<<"[AINAME]: You will receive guild invitations"
						if(a["button84.is-checked"]=="true")
							if(GRequest)
								GRequest=0
								src<<"[AINAME]: You will no longer receive guild invitations"
						if(a["button85.is-checked"]=="true")
							if(JutsuLang!="English")
								JutsuLang="English"
								src<<"[AINAME]: I have translated your jutsu to English"
								for(var/obj/SkillCards/A in contents)
									A.name=A.EName
						if(a["button86.is-checked"]=="true")
							if(JutsuLang!="Japanese")
								JutsuLang="Japanese"
								src<<"[AINAME]: I have translated your jutsu to Japanese"
								for(var/obj/SkillCards/A in contents)
									A.name=A.JName
						if(a["button87.is-checked"]=="true")
							if(!RunDrain)
								RunDrain=1
								src<<"[AINAME]: Your health will now drain if you run without stamina"
						if(a["button88.is-checked"]=="true")
							if(RunDrain)
								RunDrain=0
								src<<"[AINAME]: You will stop running if you run out of stamina"
					if(4)
						var/p=list()
						for(var/mob/Living/Player/M in world)
							if(M.key in BlockList)
								continue
							//if(M!=src)
							p+=M.key
						var/M=input("[AINAME]: Who would you like to block?\n- This will block their key","PM Block")in p+list("Cancel")
						if(M!="Cancel")
							if(BlockList==null)
								BlockList=list()
							BlockList+="[M]"
							src<<"[AINAME]: <font color=green>I have fully blocked [M]</font color>"
					if(5)
						var/p=list()
						for(var/M in BlockList)
							p+=M
						var/mob/M=input("[AINAME]: Who would you like to unblock?\n- This will unblock their key","PM Unblock")in p+list("Cancel")
						if(M!="Cancel")
							BlockList-="[M]"
							if(length(BlockList)==0)
								BlockList=null
							src<<"[AINAME]: I have fully Unblocked [M]"


mob/creation
//Color Selection
	verb
		SlotPick(N as num)
			set hidden=1
			winset(src,"SlotOneButtS","is-visible=false")
			winset(src,"SlotTwoButtS","is-visible=false")
			winset(src,"SlotThrButtS","is-visible=false")
			//winset(src,"Labels","is-visible=true")
			if(N==1)
				winset(src,"SlotOneButtS","is-visible=true")
			else if(N==2)
				winset(src,"SlotTwoButtS","is-visible=true")
			else if(N==3)
				winset(src,"SlotThrButtS","is-visible=true")
			winset(src,"LabelPane.grid2","is-visible=false")
			winset(src,"LoadButton","is-visible=false")
			winset(src,"DeleteButton","is-visible=false")
			winset(src,"NewButton","is-visible=false")
			Slot="Slot[N]"
			Slot2=N
			if(fexists(SAVEPATH))
				var/savefile/F=new(SAVEPATH)
				var/h
				F["hash"]>>h
				if(h==md5("[salt][F.ExportText("/data")]"))
					overlays=null
					F["Name1"]>>Name1
					var/PlayerStore/A=Players["[Name1]"]
					winset(src,"LabelChild","is-visible=false")
					winset(src,"LoadButton","is-visible=true")
					winset(src,"DeleteButton","is-visible=true")
					winset(src,"LabelPane.grid2","is-visible=true")
					if(A!=null)
						winset(src,"LabelChild","is-visible=true")
						var/icon/B=A.Display
						icon=B
						currentpage="LabelPane"
						UpdateChar()
						var/M=""
						if(A.Tai>A.Gen)
							if(A.Tai>A.Nin)
								M="Taijutsu"
							else
								M="Ninjutsu"
						else
							if(A.Gen>A.Nin)
								M="Genjutsu"
							else
								M="Ninjutsu"
						if(A.Tai==A.Nin==A.Gen)
							M="Balanced"
						winset(usr,"LabelPane.Level","text=[A.Level]")
						winset(usr,"LabelPane.Names","text=[A.Name]")
						winset(usr,"LabelPane.Rank","text=[A.Rank]")
						winset(usr,"LabelPane.Clan","text=[A.Clan]")
						winset(usr,"LabelPane.Village","text=[A.Village]")
						winset(usr,"LabelPane.Guild","text=[A.Guild]")
						//winset(usr,"LabelPane.Elements","text=[A.Elements2]")
						winset(usr,"LabelPane.Weapons","text=[A.Weapons2]")
						winset(usr,"LabelPane.Forte","text=[M]")
						winset(usr,"LabelPane.D","text=[A.Missions["D"]]")
						winset(usr,"LabelPane.C","text=[A.Missions["C"]]")
						winset(usr,"LabelPane.B","text=[A.Missions["B"]]")
						winset(usr,"LabelPane.A","text=[A.Missions["A"]]")
						winset(usr,"LabelPane.S","text=[A.Missions["S"]]")
						winset(usr,"LabelPane.Class","text=[GetLet(A)]")
						winset(usr,"LabelPane.Health","text=[A.HP]")
						winset(usr,"LabelPane.Stamina","text=[A.Stam]")
						winset(usr,"LabelPane.Chakra","text=[A.Chak]")
						winset(usr,"LabelPane.Taijutsu","text=[A.Tai]")
						winset(usr,"LabelPane.Ninjutsu","text=[A.Nin]")
						winset(usr,"LabelPane.Genjutsu","text=[A.Gen]")
						//winset(usr,"LabelPane.Location","text=[A.Location]")
						//winset(usr,"LabelPane.Kills","text=[A.Kills["Human"]]")
						winset(usr,"LabelPane.Deaths","text=[A.Deaths]")
						var/H=A.Deaths
						if(A.Deaths<1)
							H=1
						winset(usr,"LabelPane.Ratio","text=[A.Kills/H]")
			else
				winset(src,"LabelChild","is-visible=false")
				winset(src,"NewButton","is-visible=true")
				Slot="Slot[N]"

//Village
	verb
		VillageArrows(N as num)
			set hidden=1
			if(N==1)
				winset(src,"TabChild","is-visible=true")
				winset(src,"CharCreateChild","left=CharCreateVillage")
				winset(src,VillageInfo,"is-visible=false")
				VillageInfo=""
			else if(N==2)
				if(VillageInfo=="WaterfallLabel")
					FirstVillage("CloudLabel")
					return
				if(VillageInfo=="SoundLabel")
					FirstVillage("WaterfallLabel")
				if(VillageInfo=="SandLabel")
					FirstVillage("SoundLabel")
				if(VillageInfo=="RockLabel")
					FirstVillage("SandLabel")
				if(VillageInfo=="RainLabel")
					FirstVillage("RockLabel")
				if(VillageInfo=="MistLabel")
					FirstVillage("RainLabel")
				if(VillageInfo=="LeafLabel")
					FirstVillage("MistLabel")
				if(VillageInfo=="GrassLabel")
					FirstVillage("LeafLabel")
				if(VillageInfo=="CloudLabel")
					FirstVillage("GrassLabel")
			else if(N==3)
				if(VillageInfo=="GrassLabel")
					FirstVillage("CloudLabel")
					return
				if(VillageInfo=="LeafLabel")
					FirstVillage("GrassLabel")
				if(VillageInfo=="MistLabel")
					FirstVillage("LeafLabel")
				if(VillageInfo=="RainLabel")
					FirstVillage("MistLabel")
				if(VillageInfo=="RockLabel")
					FirstVillage("RainLabel")
				if(VillageInfo=="SandLabel")
					FirstVillage("RockLabel")
				if(VillageInfo=="SoundLabel")
					FirstVillage("SandLabel")
				if(VillageInfo=="WaterfallLabel")
					FirstVillage("SoundLabel")
				if(VillageInfo=="CloudLabel")
					FirstVillage("WaterfallLabel")
			else if(N==4)
				Village=VillageInfo
				winset(src,VillageInfo,"is-visible=false")
				if(Redoing==1)
					FinishCreation()
					return
				TabChange(2)

		FirstVillage(N as text)
			set hidden=1
			if(VillageInfo!="")
				winset(src,VillageInfo,"is-visible=false")
			src<<output(null,"VillageInfo.VillageOp")
			winset(src,"TabChild","is-visible=false")
			winset(src,"CharCreateChild","left=VillageInfo")
			winset(src,N,"is-visible=true")
			VillageInfo=N
			var/Infobox/B=VillageData["[VillageInfo]"]
			src<<output(B.Desc,"VillageInfo.VillageOp")

//Clan
	verb
		ClanArrows(N as num)
			set hidden=1
			if(N==1)
				winset(src,"CharCreateChild","left=CharCreateClan")
				winset(src,"TabChild","is-visible=true")
				winset(src,ClanInfo,"is-visible=false")
				ClanInfo=""
			else if(N==2)
				if(ClanInfo=="UchihaLabel")
					FirstClan("AburameLabel")
					return
				if(ClanInfo=="TaiSpecLabel")
					FirstClan("UchihaLabel")
				if(ClanInfo=="NaraLabel")
					FirstClan("TaiSpecLabel")
				if(ClanInfo=="KaguyaLabel")
					FirstClan("NaraLabel")
				if(ClanInfo=="InuzukaLabel")
					FirstClan("KaguyaLabel")
				if(ClanInfo=="HyuugaLabel")
					FirstClan("InuzukaLabel")
				if(ClanInfo=="HakuLabel")
					FirstClan("HyuugaLabel")
				if(ClanInfo=="AburameLabel")
					FirstClan("HakuLabel")
			else if(N==3)
				if(ClanInfo=="HakuLabel")
					FirstClan("AburameLabel")
					return
				if(ClanInfo=="HyuugaLabel")
					FirstClan("HakuLabel")
				if(ClanInfo=="InuzukaLabel")
					FirstClan("HyuugaLabel")
				if(ClanInfo=="KaguyaLabel")
					FirstClan("InuzukaLabel")
				if(ClanInfo=="NaraLabel")
					FirstClan("KaguyaLabel")
				if(ClanInfo=="TaiSpecLabel")
					FirstClan("NaraLabel")
				if(ClanInfo=="UchihaLabel")
					FirstClan("TaiSpecLabel")
				if(ClanInfo=="AburameLabel")
					FirstClan("UchihaLabel")
			else if(N==4)
				Clan=ClanInfo
				winset(src,ClanInfo,"is-visible=false")
				if(Redoing==1)
					FinishCreation()
					return
				TabChange(3)
				winset(src,"TabChild","is-visible=true")

		FirstClan(N as text)
			set hidden = 1
			if(ClanInfo!="")
				winset(src,ClanInfo,"is-visible=false")
			winset(src,"TabChild","is-visible=false")
			winset(src,"CharCreateChild","left=ClanInfo")
			winset(src,N,"is-visible=true")
			ClanInfo=N
			src<<output(null,"ClanInfo.ClanDescOp")
			var/Infobox/B=ClanData["[ClanInfo]"]
			src<<output(B.Desc,"ClanInfo.ClanDescOp")

//Body Creation
		NewCharacter()
			set hidden=1
			icon=null
			overlays=null
			winset(src,"CharLoad","is-visible=false")
			winset(src,"CreationChild","is-visible=true")
			src<<output(null,"CharCreateBody.grid2:1,1")

		ConfirmCreation()
			set hidden = 1
			if(Finishing!=1)
				Finishing=1
				var/mob/Living/Player/M=new/mob/Living/Player
				var/G=client.mob
				M.Village="[copytext(Village,1,length(Village)-4)]"
				M.Clan="[copytext(Clan,1,length(Clan)-4)]"
				M.basename=basename
				M.hairname=tmphairname
				M.hairhex="[tmphairhex]"
				M.eyehex="[eyehex]"
				M.ClanCheck()
				M.Slot=Slot
				M.gender=gender
				winset(src,"CreationChild","is-visible=false")
				winset(src,"map1","is-visible=true")
				new/obj/SkillCards/Bunshin/Docile/Bunshin_no_Jutsu(M)
				new/obj/SkillCards/Misc/Henge_no_Jutsu(M)
				new/obj/SkillCards/Misc/Kawarimi_no_Jutsu(M)
				/*M.BornBuff=pick(
					prob(85)
						"None",
					prob(5)
						"Cursed Seal",
					prob(5)
						"Sage",
					prob(5)
						"Genesis Seal"
				)*/
				M.First=1
				M.SZ=1
				M.MoveIt(154,592,1,M)
				M.ZWord="Academy"
				var/obj/Item/Wear/Clothes/K=new/obj/Item/Wear/Clothes/Footwear/Sandals()
				K.PickUp(M)
				K.Equip()
				K=new/obj/Item/Wear/Clothes/Pants/Shorts()
				K.PickUp(M)
				K.Equip()
				K=new/obj/Item/Wear/Clothes/Shirts/SShirt()
				K.PickUp(M)
				K.Equip()
				sight|=SEE_SELF
				client.mob=M
				del G

		ChangeSomethin(N as num)
			set hidden = 1
			Redoing=1
			if(N==1)
				TabChange(3)
			else if(N==2)
				TabChange(1)
			else if(N==3)
				TabChange(2)
			winset(src,"ConfirmChild","is-visible=false")
			winset(src,"TabChild","is-visible=false")
			UpdateChar()

		FinishCreation()
			set hidden = 1
			if(Village=="")
				alert(src,"You need to select a village","Select a Village","Okay")
				TabChange(1)
				return
			if(Clan=="")
				alert(src,"You need to select a clan","Select a Clan","Okay")
				TabChange(2)
				return
			if(icon==null)
				alert(src,"You need to select a body","Select a Body","Okay")
				return
			if(eyehex==null)
				alert(src,"You need to select an eye color","Select Eyes","Okay")
				return
			var/Infobox/A=VillageData["[Village]"]
			var/Infobox/B=ClanData["[Clan]"]
			winset(src,"CharCreateConfirm.NameSelection","text=[key]")
			src<<output(null,"CharCreateConfirm.ClanDescOp")
			src<<output(null,"CharCreateConfirm.VillageOpCon")
			src<<output(A.Desc,"CharCreateConfirm.VillageOpCon")
			src<<output(B.Desc,"CharCreateConfirm.ClanOpCon")
			winset(src,"CharCreateConfirm.[Village]Sel","is-visible=true")
			winset(src,"CharCreateConfirm.[Clan]Sel","is-visible=true")
			winset(src,"CharCreateChild","left=CharCreateConfirm")
			winset(src,"TabChild","is-visible=false")
			currentpage="CharCreateConfirm"
			UpdateChar()

		SetBody(N as text,G as text)
			set hidden = 1
			basename=N
			icon=icon(GetBody(basename))
			if(gender=="male")
				overlays-='Boxers.dmi'
			else
				overlays-='Bra.dmi'
				overlays-='Panties.dmi'
			gender=G
			if(gender=="male")
				overlays+='Boxers.dmi'
			else
				overlays+='Bra.dmi'
				overlays+='Panties.dmi'
			UpdateChar()

		TabChange(N as num)
			set hidden = 1
			winset(src,"TabChild","is-visible=true")
			winset(src,"VillageTab","is-visible=true")
			winset(src,"VillageTabUns","is-visible=true")
			winset(src,"ClanTab","is-visible=true")
			winset(src,"ClanTabUns","is-visible=true")
			winset(src,"BodyTab","is-visible=true")
			winset(src,"BodyTabUns","is-visible=true")
			if(N==1)
				if(Village!="")
					if(Village=="CloudLabel")
						winset(src,"CloudBut","is-visible=false")
					else
						winset(src,"CloudBut","is-visible=true")
					if(Village=="GrassLabel")
						winset(src,"GrassBut","is-visible=false")
					else
						winset(src,"GrassBut","is-visible=true")
					if(Village=="LeafLabel")
						winset(src,"LeafBut","is-visible=false")
					else
						winset(src,"LeafBut","is-visible=true")
					if(Village=="MistLabel")
						winset(src,"MistBut","is-visible=false")
					else
						winset(src,"MistBut","is-visible=true")
					if(Village=="RainLabel")
						winset(src,"RainBut","is-visible=false")
					else
						winset(src,"RainBut","is-visible=true")
					if(Village=="RockLabel")
						winset(src,"RockBut","is-visible=false")
					else
						winset(src,"RockBut","is-visible=true")
					if(Village=="SandLabel")
						winset(src,"SandBut","is-visible=false")
					else
						winset(src,"SandBut","is-visible=true")
					if(Village=="SoundLabel")
						winset(src,"SoundBut","is-visible=false")
					else
						winset(src,"SoundBut","is-visible=true")
					if(Village=="WaterfallLabel")
						winset(src,"Waterfallbut","is-visible=false")
					else
						winset(src,"WaterfallBut","is-visible=true")
				winset(src,"CharCreateChild","left=CharCreateVillage")
				winset(src,"VillageTabUns","is-visible=false")
			else if(N==2)
				if(Clan!="")
					if(Clan=="AburameLabel")
						winset(src,"AburameBut","is-visible=false")
					else
						winset(src,"AburameBut","is-visible=true")
					if(Clan=="AkimichiLabel")
						winset(src,"AkimichiBut","is-visible=false")
					else
						winset(src,"AkimichiBut","is-visible=true")
					if(Clan=="HyuugaLabel")
						winset(src,"HyuugaBut","is-visible=false")
					else
						winset(src,"HyuugaBut","is-visible=true")
					if(Clan=="InuzukaLabel")
						winset(src,"InuzukaBut","is-visible=false")
					else
						winset(src,"InuzukaBut","is-visible=true")
					if(Clan=="KaguyaLabel")
						winset(src,"KaguyaBut","is-visible=false")
					else
						winset(src,"KaguyaBut","is-visible=true")
					if(Clan=="NaraLabel")
						winset(src,"NaraBut","is-visible=false")
					else
						winset(src,"NaraBut","is-visible=true")
					if(Clan=="UchihaLabel")
						winset(src,"UchihaBut","is-visible=false")
					else
						winset(src,"UchihaBut","is-visible=true")

				winset(src,"CharCreateChild","left=CharCreateClan")
				winset(src,"ClanTabUns","is-visible=false")
			else if(N==3)
				winset(src,"CharCreateChild","left=CharCreateBody")
				winset(src,"BodyTabUns","is-visible=false")
				currentpage="CharCreateBody"

mob/Living/Player
	verb
		CloseEdit()
			set hidden=1
			InEdit=0
			Editing=null
			EditVar=null
			src<<output(null,"EditPage.SelectedOut")
			src<<output(null,"EditPage.VarName")
			src<<output(null,"EditPage.VarValue")
			winset(src,null,"EditPage.SelectedOut.background-color=#B4B4B4;EditPage.VarName.background-color=#B4B4B4;EditPage.VarValue.background-color=#B4B4B4")
			winset(src,"EditPage.VarGrid","cells=0x0")
			winset(src,"EditPage.BackBut","is-visible=false")
			sleep()
			UpdateEditVerbs(0)
		CloseCreate()
			set hidden=1
			Creating=null
			InCreate=0
			Reference=null
			CreateAdd=0
			CreateVar=null
			RefMat=null
			CreateFirst=null
			src<<output(null,"CreatePage.SelectedOut")
			winset(src,null,"CreatePage.button6.background-color=#B4B4B4;CreatePage.button5.background-color=#B4B4B4;CreatePage.button1.background-color=#B4B4B4;CreatePage.button2.background-color=#B4B4B4;CreatePage.SelectedOut.background-color=#B4B4B4")
			winset(src,"CreatePage.AtomGrid","cells=0x0")
			winset(src,"CreatePage.BackBut","is-visible=false")
			sleep()
			UpdateCreateVerbs(0)
