mob/Hittable/Unresponsive/NPC/People/Hiashi/DamageMe(mob/M, var/D,METHOD,hidemessage)
	if(M.protect||dead) return
	if(!kaiten)
		overlays+='kaiten.dmi'
		kaiten=1
		spawn(50)
			Stamina=StaminaMax
			kaiten=0
			overlays-='kaiten.dmi'
	var/w
	if(D<1)D=1
	D=round(D); w=(D/StaminaMax)*73
	Stamina-=D; Wounds+=w
	if(!hidemessage) DamageReport(src,M,D,METHOD)
	M.RefreshStats()
	if(Wounds>=200)
		KillMe(M)
	if(Stamina<=0&&Wounds<100)
		if(!KO)
			KO=1
			var/R=500
			icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
			spawn(50)
				if(Wounds<100) {KO=0; icon_state=""; Stamina=R}
				else KillMe(M)
		else Wounds+=5
	else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
		if(!KO)
			KO=1; icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
			spawn(50)if(M)KillMe(M)

mob/Hittable/Responsive/NPC/DamageMe(mob/M, var/D,METHOD,hidemessage)
	set waitfor = 0
	if(M.protect||dead) return
	if(!istype(M,/mob/NPC))
		if(!(M in HitList)) HitList+=M
	var
		d=D; w
	if(BugArmour) D-=(d*0.12)
	if(SandArmour) D-=(d*0.20)
	if(MushiKabe) D-=(d*0.80)
	if(Blocking && METHOD != "ClayDeteriorate") D-=(d*0.45)
	if(InKaramatsu)
		D-=(d*0.20)
		var/recoil=(Taijutsu*0.1)
		M.Stamina-=recoil; M.Wounds+=(recoil/StaminaMax)*90
	if(D<1)D=1
	D=round(D); w=(D/StaminaMax)*65
	Stamina-=D; Wounds+=w
	if(!hidemessage) DamageReport(src,M,D,METHOD)
	if(M)
		M.ExperienceCheck(w,src)
		M.RefreshStats()
		for(var/mob/Fry in range())
			if(Fry.Creator && Fry.Creator==Creator)
				if(!(M in Fry.HitList))
					Fry.HitList += M
	if(Wounds>=200)
		KillMe(M)

	spawn(1800)
		if(!dead && !KO && src)
			if(!DamagedRecently && Stamina < StaminaMax)
				Stamina = StaminaMax
				Wounds = 0
				HasKonchuu = list()
				var/NOLOC = 0
				for(var/mob/MO in HitList)
					if(get_dist(MO, src) <= 8)
						NOLOC = 1
				if(!NOLOC)
					loc=respawn

	if(Stamina<=0&&Wounds<100)
		if(!KO)
			KO=1
			var/R=500
			for(var/mob/b in KageBunshinList) del(b)
			icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
			spawn(50)
				if(Wounds<100) {KO=0; icon_state=""; Stamina=R}
				else KillMe(M)
		else Wounds+=5
	else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
		if(!KO)
			KO=1; icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
			spawn(50)if(M&&!M.dead)KillMe(M)

mob/Hittable/Responsive/NPC/KillMe(mob/M)
	for(var/obj/Scrolls/ChuuninScrolls/X in src)
		viewers(5,src)<<"<b>[src] dropped \an [X.name]</b>"
		X.loc=loc; HasHeaven=0; HasEarth=0;
	if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
	if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
	if(dead) return
	dead=1
	if(M)
		SpawnMe(2400,type,respawn)
	for(var/mob/KM in KageBunshinList)
		del KM
	if(prob(18+M.Luck)) DropItem()
	loc=locate(0,0,0)

mob/proc/DropItem()
	switch(pick(prob(33); 1,2,3,4,prob(80); 5,6,prob(66); 7,8,9,10,11,12,13,14,15,16,17,18,19,prob(80);20,prob(80);21,prob(80);22,prob(20);23,prob(20);24,prob(20);25,26,prob(85);27,prob(10);28,29,30,31,32,33,34))
		if(1) {var/obj/Weapon/Thrown/WindmillShuriken/W=new(loc); W.amount=rand(1,10); W.Checkamount()}
		if(2) new/obj/Weapon/Thrown/Shuriken(loc)
		if(3) new/obj/Weapon/Wield/Kunai(loc)
		if(4) {var/obj/Weapon/Thrown/DoubleEdgedKunai/W=new(loc); W.amount=rand(1,30); W.Checkamount()}
		if(5) {var/obj/Weapon/Wield/ExplosionNote/W=new(loc); W.amount=rand(1,10); W.Checkamount()}
		if(6) new/obj/Weapon/Wield/Katana(loc)
		if(7) new/obj/Weapon/Wield/BroadSword(loc)
		if(8) new/obj/Clothing/Face/Sunglasses(loc)
		if(9) new/obj/Clothing/Face/Spectacles(loc)
		if(10) new/obj/Clothing/Face/KakashiMask(loc)
		if(11) new/obj/Clothing/Shirt/LongSleeveShirt(loc)
		if(12) new/obj/Clothing/Shirt/ShortSleeveShirt(loc)
		if(13) new/obj/Clothing/Shirt/Singlet(loc)
		if(14) new/obj/Clothing/Pants/Pants(loc)
		if(15) new/obj/Clothing/Pants/Shorts(loc)
		if(16) new/obj/Clothing/Feet/Sandals(loc)
		if(17) new/obj/Clothing/Feet/Shoes(loc)
//		if(18) new/obj/Clothing/Feet/WoodenSandals(loc)
//		if(19) new/obj/Clothing/Hands/Gloves(loc)
		if(20) {var/obj/Fish/Large/W=new(loc); W.amount=rand(1,7); W.Checkamount()}
		if(21) {var/obj/Fish/Medium/W=new(loc); W.amount=rand(1,7); W.Checkamount()}
		if(22) {var/obj/Fish/Small/W=new(loc); W.amount=rand(1,7); W.Checkamount()}
		if(23) new/obj/Item/rod/Rod1(loc)
		if(24) new/obj/Item/rod/Rod2(loc)
		if(25) new/obj/Item/rod/Rod3(loc)
		if(26) new/obj/Item/Ramen(loc)
		if(27) {var/obj/Item/Bandages/W=new(loc); W.amount=rand(1,10); W.Checkamount()}
		if(28) {var/obj/gold/E=new(loc); E.gold=rand(2,2000)}
		if(29) new/obj/Weapon/Wield/PickAxe(loc)
		if(30) new/obj/Weapon/Wield/WoodAxe(loc)
		if(31) new/obj/Weapon/Wield/Scythe(loc)
		if(32) new/obj/Weapon/Wield/Spear(loc)
		if(33) new/obj/Weapon/Wield/Staff(loc)
		if(34) new/obj/Weapon/Wield/FryKatana(loc)

mob/proc
	DropRareItem()
		switch(pick(prob(120); 1,2,prob(40); 3))
			if(1) new/obj/Weapon/Wield/Elemental/Kunai(loc)
			if(2) new/obj/Weapon/Wield/Elemental/Katana(loc)
			if(3) new/obj/Weapon/Wield/Elemental/BroadSword(loc)
mob/proc
	GiveRareItem()
		switch(pick(1,2,3,4,5))
			if(1)
				new/obj/Clothing/Over/Akatsuki_Cloak(src)
			if(2)
				new/obj/Clothing/Over/Akatsuki_Cloak/Collar(src)
			if(3)
				new/obj/Clothing/Over/Akatsuki_Cloak/Open(src)
			if(4)
				new/obj/Clothing/Over/Akatsuki_Cloak/Second(src)
			if(5)
				new/obj/Clothing/Over/Akatsuki_Cloak/Torn(src)
		src<<"<b><i>You obtain something special...</i></b>"
		UpdateInventory();
	RareChance(var/mult)
		switch(Rank_Calculator(src))
			if("S") return round(4*mult)
			if("A") return round(3*mult)
			if("B") return round(2*mult)
			if("C") return round(1*mult)
			else return 0

