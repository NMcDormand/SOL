obj/SkillCards/Clan/Lee/UraRenge
	icon_state="card_UraRenge"
	cmdstring="UraRenge"
	Cooldown=3000
	CanLevel = 0

	Description = list(
		"about"="Reverse Lotus"
		,"title"="Ura Renge"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	Activate(mob/U)
		if(U.Gate<3) {U<<"You need to open the Life Gate first"; return}
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		for(var/mob/M in get_step(U,U.dir))
			if(TAIATTACKCHECKYOU(M)) return
			if(M.TreeStump) {U<<"You cannot use this on this type of enemy."; return}
			if(U.CooldownCheck("Ura",CooldownCur*U.cooldownmultiplier)) return
			U.MoveUses[name]++
			U.JutsuMessage(Description["title"])
			flick("highkick",U)
			if(U.PracticeMode) return ..()
			var/dmg=round(U.Taijutsu*0.5-(M.Taijutsu*0.1))
			dmg+=U.Kicks()
			if(dmg<round(U.Taijutsu*0.18)) dmg=round(U.Taijutsu*0.09)
			U.attacking=1
			if(U.HitCheck(M))
				var/a=M.movespeed
				M.movespeed=0; step(M,U.dir); M.movespeed=a
				flick("stagger",M)
				U.dir=get_dir(U,M); U.Move(M.loc)
				M.DamageMe(U,dmg,"kick")
				if(!M.KO&&!M.dead)
					U.Lotus=1; M.Lotus=1
					flick("lotus",U)
					if(U.dir==NORTH) U.pixel_y-=16
					if(U.dir==NORTHWEST) {U.pixel_y-=4; U.pixel_x+=8}
					if(U.dir==NORTHEAST) {U.pixel_y-=4; U.pixel_x-=8}
					if(U.dir==SOUTH) U.pixel_y+=16
					if(U.dir==SOUTHWEST) {U.pixel_y+=4; U.pixel_x+=8}
					if(U.dir==SOUTHEAST) {U.pixel_y+=4; U.pixel_x-=8}
					if(U.dir==WEST)	U.pixel_x+=16
					if(U.dir==EAST)	 U.pixel_y-=16
					U.ReverseLotus(M)
				else spawn(15)U.attacking=0
				var/taiup=rand(3,5)
				U.ApplyEXP(taiup+M.taitraining,"taijutsu")
				U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1;
				spawn(15)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"

mob/proc
	ReverseLotus(mob/M,DM)
		spawn(7)
			if(M)
				Lotus=0; M.Lotus=0
				var/dmg=round(Taijutsu*4-(M.Taijutsu*0.3))
				if(dmg<round(Taijutsu*0.3)) dmg=round(Taijutsu*0.3)
				M.DamageMe(src,dmg,"Lotus"); DamageMe(src,dmg*0.2,"Lotus")
				range(6,M)<<"[src] brings [M] crashing down with \his Reverse Lotus"
				pixel_x=0; pixel_y=0; attacking=0
		spawn(50)attacking=0