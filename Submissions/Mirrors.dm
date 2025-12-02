var/mirrorType=1;

// taken from http://www.byond.com/forum/post/171649
atom/proc/turn_towards(atom/A)
	var/d = get_dir(src, A)
	// check for straight ahead
	if(d == dir) return
	// check for straight behind; turn either way
	if(d == turn(dir, 180))
		dir = turn(dir, pick(45, -45)); return
	// if facing diagonally
	if(dir & (dir-1))
		// check for a 45 or 90 turn
		if(dir & d)
			// find the common cardinal direction (north, east, etc.)
			dir &= d; return
			// the only thing left is a 135 turn
		dir ^= turn(d, 180); return
	// if facing a cardinal direction...
	dir |= d & ~turn(dir, 180); return


obj/SkillCards/Clan/Yuki/MakyouHyoushou
	icon_state="card_MakyouHyoushou"
	cmdstring="MakyouHyoushou"
	Click(x,y)
		if((src in usr)&&(findtext("[y]","HotBar")))
			if(usr.hbDelay) return
			usr.hbDelay=1;
			MakyouHyoushou();
			usr.hbDelay=0
		else ..()
	New()
		if(!src.Description) src.Description=new()
		src.Description["about"]="Trap your opponent in ice mirrors, and throw sensatsu at them."
		src.Description["title"]="Hyouton: Makyou Hyoushou"
		src.Description["range"]="6"
		src.Description["type"]="Ninjutsu"
		src.Description["cost"]="4000"
		src.Description["seals"]="7"
		src.Description["strong"]="?"
		src.Description["weak"]="Fire"
		src.Description["rank"]="C"
//		src.Description["pic"]='MakyouHyoushou.png'
		src.Description["category"]="ninjutsu"
	verb/MakyouHyoushou()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.choosingHoming)
			return
		var/mob/M
		var/dist=6;
		if(ismob(usr.targeting)&&get_dist(usr.targeting,usr)<= dist) {M = usr.targeting;}
//		else {M = AttackList(usr, dist);}
		else {usr.choosingHoming=1;M = input("Who do you want to attack?","Attack List") as mob in orange(usr,dist)}
		if(!M) {usr.choosingHoming=0;return}
		spawn(10)usr.choosingHoming=0
		if(usr.GenericAttackCheck()||usr.Gokusamaisou||usr.mirroring||M.mirroring||usr.InMirrors||InvisibilityCheck(usr,M)) return
		var
			c=4000; mx=c; s=usr.SS*8
		var/obj/AIM=new
		//var/originalSpot=usr.loc
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("Mirrors",(3000*usr.cooldownmultiplier)+s)) return
		usr.firing=1
		usr.icon_state="seals"
		spawn(s/1.1) AIM.loc=M.loc
		spawn(s)
			spawn(12) usr.firing=0
			usr.icon_state=null
			if(prob(usr.ChakraControl))
				usr.JutsuSeals(s); usr.JutsuChakra(c); usr.JutsuNin(c); usr.WaterElementalup(); usr.WindElementalup()
				usr.MoveUses[src.cmdstring]++
				usr.UseChakra_Jutsu(c); usr.JutsuMessage(4,src.Description["title"])
				usr.Mirrors(AIM,M)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"; return}
	verb/MirrorsAttack()
		set src in usr.contents
		var/mob/tmp/
			currentMirror = pick(usr.AllMirrors)
			randomMirror = pick(usr.AllMirrors)
		while(!usr.dead && usr.MirrorTarget && usr.MirrorTarget.InMirrors && !usr.MirrorTarget.dead && get_dist(usr.MirrorsCentre, usr.MirrorTarget.loc) < 5)
			randomMirror = pick(usr.AllMirrors)
			// Until we find a mirror that is on the (same x or same y) and is more then two tiles away from the user and isn't our current mirror, pick a new mirror
			while((randomMirror.loc.x != usr.MirrorTarget.loc.x && randomMirror.loc.y != usr.MirrorTarget.loc.y) || (get_dist(randomMirror.loc, usr.MirrorTarget.loc) < 2) || (randomMirror == currentMirror))
				randomMirror = pick(usr.AllMirrors)
			usr.loc = randomMirror.loc
			usr.turn_towards(usr.MirrorTarget)
			usr.turn_towards(usr.MirrorTarget)
			usr.turn_towards(usr.MirrorTarget)
			usr.turn_towards(usr.MirrorTarget)
			usr.MirrorsSensatsu()
			sleep(5)
		if(!usr.MirrorTarget || !usr.MirrorTarget.InMirrors || usr.MirrorTarget.dead || get_dist(usr.MirrorsCentre, usr.MirrorTarget.loc) > (usr.MirrorDist + 1))
			usr.EndMirrors()
			return
		return
	verb/CreateMirrors()
		usr.MirrorCreationMode = 1
		return

client
	Click(atom/O)//Checks what you have clicked
		..()
		if(isturf(O))
			var/mob/U=src.mob
			if(U.MirrorCreationMode)
				// var/mirror_health = min(U.Ninjutsu * 0.0035 * U.IceElemental, U.mstamina) // Cap health of the mirrors at user's stamina
				new/mob/Inanimate/Break/DemonMirrorGhost/Wall(O,U)

mob
	proc
		MirrorsSensatsu()
			if(usr.MirrorTarget.ckey == "neptus0" && prob(5))
				usr.MirrorTarget << "You're stealth neck was able to dodge the attacker"

			var/obj/Yuki/Sensatsu/S=new/obj/Yuki/Sensatsu
			var/obj/Yuki/Sensatsu/S2=new/obj/Yuki/Sensatsu; var/obj/Yuki/Sensatsu/S3=new/obj/Yuki/Sensatsu
			S.Power=3
			CreateProjectile(usr,S,"Ice",usr.loc,usr.dir,1,7,0.9,1.9)
			CreateProjectile(usr,S2,"Ice",get_step(usr,turn(usr.dir,90)),usr.dir,1,7,0.9,1.6)
			CreateProjectile(usr,S3,"Ice",get_step(usr,turn(usr.dir,-90)),usr.dir,1,7,0.9,1.6)
			sleep(5)
			CreateProjectile(usr,S,"Ice",usr.loc,usr.dir,1,7,0.9,1.9)
			CreateProjectile(usr,S2,"Ice",get_step(usr,turn(usr.dir,90)),usr.dir,1,7,0.9,1.6)
			CreateProjectile(usr,S3,"Ice",get_step(usr,turn(usr.dir,-90)),usr.dir,1,7,0.9,1.6)
		EndMirrors()
			if(usr.MirrorTarget)
				usr.MirrorTarget.InMirrors = 0
			usr.MirrorTarget = 0
			usr.mirroring = 0
			usr.invisibility -= 2

			for(var/Mist in usr.MirrorMist)
				del(Mist)
			for(var/Mirror in usr.AllMirrors)
				del(Mirror)
		Mirrors(AIM,mob/M)
			usr.MirrorsCentre = AIM
			for(var/turf/T in view(MirrorDist,AIM))
				if(T.density)
					continue
				if(get_dist(AIM,T)>(usr.MirrorDist-1))
					new/mob/Inanimate/Break/DemonMirrorGhost/Wall(T,src)
				else
					var/obj/Destructable/DemonMirror/m=new/obj/Destructable/DemonMirror/Middle
					m.loc=T; m.Owner=src; MirrorMist+=m
			var/mob/randomMirror = pick(usr.AllMirrors)
			src.loc = randomMirror.loc
			src.MirrorTarget=M
			src.mirroring = 1
			// For some reason +2 doesn't work... not sure what to do about that.
			src.invisibility = 2
			M.InMirrors=1
			spawn(500)
				src.EndMirrors()

mob
	var
		tmp
			MirrorCreationMode = 0
			InMirrors = 0
			MirrorDist = 3

			mob/MirrorTarget
			turf/MirrorsCentre = 0
			list/AllMirrors = list()
			list/MirrorMist = list()
	Inanimate
		var
			Health
			mob/Owner = 0
			mob/Containing
		CantHenge = 1
		Death(mob/M,DAMAGE,METHOD,hidemessage)
			if(M == src.Owner)
				src.Health+=DAMAGE
				src.Owner << "Your sensatsu have hit and strengthened your mirrors!"
			else
				src.Health-=DAMAGE
				if(Health <= 0)
					del src
		Break
			DemonMirrorGhost
				var/IceElemental = 0
				icon='DemonMirrors_SOL.dmi'
				layer=MOB_LAYER-1
				Wall
					icon_state="front"
					New(turf/placement, mob/owner)
						loc = placement
						Owner = owner
						owner.AllMirrors += src
						IceElemental = (owner.WaterElemental + owner.WindElemental) * 0.5
						Health = owner.mstamina * (src.IceElemental * 0.00025)
						Taijutsu = owner.Taijutsu
						Ninjutsu = owner.Ninjutsu
						Genjutsu = owner.Genjutsu
						..()
					Del()
						..()
					Click()
						var/mob/U = usr
						if(U == src.Owner)
							U.loc = src.loc
				WallSide
					icon_state="side"
					density=1
				Corner
					icon_state="corner"
					density=1