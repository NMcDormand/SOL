mob/Hittable/Responsive/NPC/
	Bosses
		verb
			Talk()
				set src in view(2)
				var/PLAYER(B)=usr
				if(B.Talking)
					return
				B.Talking=1
				B.CanMove=0
		Keni
			WaterWalkOn=1
			name="Kenny"
			//clan="TaFu"
			gender="male"
			basename="Base_Tan.dmi"
			hairname="Shikamaru.dmi"
			hairhex="#202020"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#400000"
				I.Blend("#800000")
				overlays+=I
				I=icon('ANBUArmor.dmi')
				I.Blend("#202020")
				overlays+=I
				I=icon('ANBUGloves.dmi')
				I.Blend("#202020")
				overlays+=I
				overlays+=icon('Pants.dmi')
				I=icon('LegWraps.dmi')
				I.Blend("#202020")
				overlays+=I
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Spear
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Spear) in src
				A.Equip()
				EleGrant("Fire",100);EleGrant("Wind",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Um gay la",
				"Lord Jashin is watching soon we will all face his judgement",
				"If the Lord requests for your life, i will provide it")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Myst
			WaterWalkOn=1
			name="Mystie"
			//clan="Uchiha"
			gender="male"
			basename="Base_Tan.dmi"
			hairname="LongStraight.dmi"
			hairhex="#606060"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#9920f0"
				I.Blend("#9920f0")
				overlays+=I
				overlays+=icon('ChronosSuit2.dmi')
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				overlays+=icon('Madara-Mask.dmi')
				EleGrant("Fire",100);EleGrant("Wind",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Australia is the best",
				"Aussie Aussie Aussie",
				"I need to stop Mysting, it's getting annoying!",
				"I couldnt stop Mysting for a whole ten minutes",
				"I once Mysted all over my pants before eating Macas",
				"I Mysted in class once, it wasnt fun")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Naptus
			WaterWalkOn=1
			name="Neip"
			//clan="Uchiha"
			gender="male"
			basename="Base_Tan.dmi"
			hairname="Deidara.dmi"
			hairhex="#202040"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#9920f0"
				I.Blend("#9920f0")
				overlays+=I
				I=icon('LShirt.dmi')
				I.Blend("#9920f0")
				overlays+=I
				overlays+=icon('Jounin_Sound.dmi')
				overlays+=icon('Pants.dmi')
				overlays+=icon('KakashiMask.dmi')
				overlays+=icon('ShikamaruHBR.dmi')
				I=icon('LegWraps.dmi')
				I.Blend("#202040")
				overlays+=I
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Scythe
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Scythe) in src
				A.Equip()
				EleGrant("Fire",100);EleGrant("Wind",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Easy",
				"If you get pushed down 8 times, get back up 9",
				"Hue hue hue")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Nero
			WaterWalkOn=1
			name="Nairo"
			//clan="TaiSpec"
			gender="male"
			basename="Base_Medium.dmi"
			hairname="Kakashi.dmi"
			hairhex="#990000"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#ff00ff"
				I.Blend("#ff00ff")
				overlays+=I
				I=icon('Singlet.dmi')
				I.Blend("#990000")
				overlays+=I
				overlays+=icon('WShirt.dmi')
				I=icon('Pants.dmi')
				I.Blend("#990000")
				overlays+=I
				I=icon('Shorts.dmi')
				I.Blend("#999999")
				overlays+=I
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/BroadSword
				I=icon(A.icon)
				I.Blend("#909090")
				A.icon=I
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/BroadSword) in src
				A.Equip()
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				EleGrant("Water",100);EleGrant("Earth",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Falling down is my specialty!",
				"When there is no talent there is no growth!",
				"What's the best way forward?")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Ryo
			WaterWalkOn=1
			name="Hikaru"
			//clan="Takasiro"
			gender="male"
			basename="Base_Medium.dmi"
			hairname="Kakashi.dmi"
			hairhex="#1b4c1a"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#215296"
				I.Blend("#215296")
				overlays+=I
				I=icon('Pants.dmi')
				I.Blend("#606060")
				overlays+=I
				I=icon('SShirt.dmi')
				I.Blend("#606060")
				overlays+=I
				overlays+=icon('Jshirt_short.dmi')
				overlays+=icon('JGauntlet.dmi')
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Staff
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Staff) in src
				A.Equip()
				EleGrant("Fire",100);EleGrant("Lightning",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Your death is but the beginning",
				"Is your life that precious to you?",
				"You are nothing before my power")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Salute
			WaterWalkOn=1
			name="Idomaru"
			//clan="none"
			gender="male"
			basename="Base_Dark.dmi"
			hairname="Jiroubou.dmi"
			hairhex="#000000"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#0c780f"
				I.Blend("#0c780f")
				overlays+=I
				I=icon('Pants.dmi')
				I.Blend("#606060")
				overlays+=I
				overlays+=icon('NejiShirt.dmi')
				overlays+=icon('JPants_chain.dmi')
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Spear
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Spear) in src
				A.Equip()
				EleGrant("Fire",100);EleGrant("Lightning",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Bye felecia",
				"Its not personal I'm just better than you",
				"There's no meaning to a flower unless it blooms",
				"Surpassing a sparrow is my goal, you are but a step in its path")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Wizzy
			WaterWalkOn=1
			name="Dana"
			//clan="Uzumaki"
			gender="male"
			basename="Base_Pale.dmi"
			hairname="Short.dmi"
			hairhex="#AAAAAA"
			New()
				..()
				overlays-=icon('Shoes.dmi')
				overlays-=icon('Sandles.dmi')
				var/icon/I=icon('Eyes.dmi')
				eyehex="#000000"
				overlays+=I
				I=icon('Bra.dmi')
				I.Blend("#450000")
				overlays+=I
				I=icon('Panties.dmi')
				I.Blend("#450000")
				overlays+=I
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Staff
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Staff) in src
				A.Equip()
				EleGrant("Water",100);EleGrant("Wind",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"I will defend the rights of women everywhere",
				"We prefer feminist, thank you",
				"Does this make my junk look flat?",
				"Fabulous!")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
		Yen
			WaterWalkOn=1
			name="Miroku"
			//clan="Uzumaki"
			gender="male"
			basename="Base_Pale.dmi"
			hairname="Gaara.dmi"
			hairhex="#000000"
			New()
				..()
				var/icon/I=icon('Eyes.dmi')
				eyehex="#454545"
				I.Blend("#454545")
				overlays+=I
				overlays+=icon('Pants.dmi')
				overlays+=icon('NejiShirt.dmi')
				I=icon('ANBUGloves.dmi')
				I.Blend("#454545")
				overlays+=I
				overlays+=icon('KakashiMask.dmi')
				I=icon('LegWraps.dmi')
				I.Blend("#454545")
				overlays+=I
				NinStat(202000,78000,118000,20000,5000,3000,24,,100)
				var/obj/Item/Wear/Weapons/Wield/A=new /obj/Item/Wear/Weapons/Wield/Gunbai
				A.PickUp(src)
				A = locate(/obj/Item/Wear/Weapons/Wield/Gunbai) in src
				A.Equip()
				EleGrant("Water",100);EleGrant("Wind",100)
			Talk()
				..()
				var/PLAYER(B)=usr
				var/msg=pick(
				"Panties!",
				"sorry you are too old for this game",
				"I like them young, how old are you?",
				"A miracle only happens once, but everytime I look at you...")
				usr<<{"<b><font color="#555555">[name]</font> says: [html_encode(msg)]</b>"}
				B.CanMove=1
				B.Talking=0
