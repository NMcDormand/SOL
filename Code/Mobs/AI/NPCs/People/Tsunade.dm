mob/var/tmp/RanshinShouCooldown
mob/var
	GaveSake = 0
	GotPanties = 0
obj/Clothing/Underwear
	TsunadePanties
		name="Tsunade's Panties"
		icon='Panties.dmi'
		layer=UNDER_LAYER
		price=10
		var/Colour = ""
		New()
			..()
			var/icon/IC = icon(icon)
			switch(pick(1,2,3))
				if(1)
					IC.Blend("#99FF99")
					Colour = "Green"
				if(2)
					IC.Blend("#FF4444")
					Colour = "Green"
				if(3)
					IC.Blend("#9999FF")
					Colour = "Blue"
			icon = IC
		Drop()
			return
		verb
			Customise()
				usr << "I wouldnt dare customise these majestic things"
				return

mob/Hittable/Responsive/NPC/Tsunade
	name="Tsunade"
	icon='Tsunade.dmi'
	Village="Leaf"
	NinjaRank="Kage Level"
	Reflex=100
	protect=0
	VillageColour = LEAFCLR

	Taijutsu=60000
	Ninjutsu=70000
	Genjutsu=70000
	TaijutsuMax=60000
	NinjutsuMax=70000
	GenjutsuMax=70000
	Stamina=900000
	StaminaMax=900000
	FireElemental=5000
	WindElemental=5000
	ChakraControl=100

	gender="female"

	Action(mob/user)
		if(!(user in range(2, user))) return
		if(!(user in user.HitList))
			if(user.sliced) {user<<"[user] has reattached your tendons!."; user.sliced=null; return}
			if(user.Nerves) {user<<"[user] has repaired your nerves!."; user.Nerves=null; return}
			if(user.Blasted) {user<<"[user] has repaired your inner ear!."; user.Blasted=null; return}
			if(user.Poisoned) {user<<"[user] has cured you!."; user.Poisoned=null; return}
			if(length(user.HasKonchuu))
				user<<"[user] has rid you of Konchuus!"; user.HasKonchuu=list()
				for(var/mob/player/P in world) RemoveBug(P,user)
			if(!user.GaveSake)
				var/obj/Item/DeluxeSake/OB = locate() in user.contents
				if(OB)
					user << "Hey, I'll trade you two pairs of these for that sake i see on your waistband!"
					del OB
					new/obj/Clothing/Underwear/TsunadePanties(user)
					new/obj/Clothing/Underwear/TsunadePanties(user)
					user << "<font size=2>You received 2 pairs of <b>Tsunade's Panties</b>!"
					user.GaveSake = 1
					user.GotPanties = 1
					user.UpdateInventory()
					return
			switch(pick(1,2,3))
				if(1) user<<"I see great potential in you."
				if(2) user<<"Fancy a game of Black Jack? Poker perhaps?"
				if(3)
					if(gender=="male") user<<"...Hey! What are you staring at? My face is up <b>here</b>."
					else if(gender=="female") user<<"Good day."


	New()
		respawn=loc
		spawn(4) AI()
	Bump(A)
		if(ismob(A))
			var/mob/M=A
			if(!(istype(M,/mob/NPC)))
				if(HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"

	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> I didn't want to do this, but you forced my hand."
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> So, you're not dead quite yet."
					else
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=150; M.KillMe(src)

	LocateTarget(mob/T)
		if(Darkness)
			if(prob(45)&&T) HuntList+=T
		else if(!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCamo) {if(prob(95)&&T) HuntList+=T}
			else if(T.InCloak) {if(prob(70)&&T) HuntList+=T}
			else if(T.InMeiMei) {if(prob(80)&&T) HuntList+=T}
		else HuntList+=T


	Attack1(mob/M)
		if(M.loc==loc) step_away(src,M)
		if(sleepy&&prob(98)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				if(M)
					if(M.icon_state=="seals"&&prob(80)) Evade1(M)
					else if(prob(20+M.Luck)&&!M.HasSeal&&M.Wounds>85) {step_to(src,M); M.GenesisSealAttain(src); HitList-=M}
					else if(firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,30)
					else AI_Attack(M,10,30)
			else
				if(M)
					if(!M.sliced&&!firing&&prob(33)) AI_SliceTendons()
					else if(!firing&&prob(25)&&!CooldownCheck("Tsuuten",70)) AI_Oukashou()
					else if(!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,35)
					else AI_Attack(M,12,66)

	Attack2(mob/M)
		if(M.loc==loc) step_away(src,M)
		if(sleepy&&prob(100)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)<3&&prob(30))
				if(M&&M.icon_state=="seals"&&prob(50)) Evade1(M)
				else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14,25)
				else if(M&&!CooldownCheck("Tsuuten",180)) {Move_In(M); spawn(15) PainfulSkyLeg()}
				else if(M) AI_Attack(M,10,22)
			else if(M)
				Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_towards(src,M)
						spawn(1)
							if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,60)
							else if(M) AI_SelfShousen()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
						else if(M&&!RanshinShouCooldown) AI_RanshinShou()
						else if(M) AI_Attack(M,15,44)


//--------------------------------------------------------
mob/proc
	AI_Oukashou()
		for(var/mob/M in get_step(src,dir))
			if(TAICHECKBOTH(src,M)) return
			var/dmg = round(Taijutsu*1.8-(M.Taijutsu*0.2))
			if(dmg<=round(Taijutsu*0.1)) dmg=Taijutsu*0.1
			view(4,src)<< "<b>[src]</b>: Oukashou!"
			attacking=1
			spawn(9)
				spawn(20)attacking=0
				flick("punch",src)
				if(HitCheck(M)&&M in HitList)
					M.DamageMe(src,dmg,"strikes")
				else
					attacking=1; spawn(25)attacking=null
					M<<"You dodged [src]'s attack"

	AI_SelfShousen()
		if(GENERICATTACKCHECK(src)||healing||healingself)
			return
		else
			icon_state="seals"
			firing=1
			spawn(2)
				spawn(1)icon_state=null
				healingself=1; spawn(70) healingself=0
				spawn(15)AI_SelfShousenProc()

	AI_SelfShousenProc()
		if(healingself)
			var
				c=ChakraMax*0.28; heal=c*0.007
			Wounds-=heal
			TextOverlay(src, round(heal), "health");
			if(Wounds<=25) {healingself=0; Wounds=25}
			spawn(15)SelfShousenProc()
		else
			healingself=0; spawn(15)firing=0

	AI_SliceTendons()
		if(GENERICATTACKCHECK(src))
			return
		else
			for(var/mob/M in get_step(src,dir))
				if(TAICHECKBOTH(src,M)||M.sliced) return
				if(HitCheck(M))
					flick("punch",src)
					attacking=1; spawn(5)attacking=0
					M.sliced=1
					spawn(250)
						if(M&&M.sliced) {M.sliced=0; M<<"Your tendons have healed."}
				else
					attacking=1; spawn(15)attacking=null
					M<<"You dodged [src]'s attack."

	AI_RanshinShou()
		for(var/mob/M in get_step(src,dir))
			if(TAICHECKBOTH(src,M)||M.Nerves)
				return
			else
				RanshinShouCooldown=1; spawn(50) RanshinShouCooldown=0
				if(HitCheck(M))
					flick("punch",src)
					attacking=1; spawn(5)attacking=null
					M<<"[src] disrupted your nerves."
					M.Nerves=1
					spawn(400)
						if(M&&M.Nerves)  {M.Nerves=0; M<<"Your nerves have healed."}
				else
					attacking=1; spawn(10)attacking=null
					M<<"You dodged [src]'s attack."

	PainfulSkyLeg()
		for(var/mob/M in get_step(src,dir))
			if(TAICHECKBOTH(src,M)) return
			var/dmg = round(Taijutsu*2.3-(M.Taijutsu*0.3))
			if(dmg<=round(Taijutsu*0.25)) dmg=Taijutsu*0.25
			view(4,M)<< "<b>[src]</b>:  Tsuuten Kyaku!"
			attacking=1
			spawn(15)
				spawn(30)attacking=0
				flick("kick",src)
				if(HitCheck(M))
					M.DamageMe(src,dmg,"kick")
				else
					attacking=1; spawn(40)attacking=null
					M<<"You dodged [src]'s attack"