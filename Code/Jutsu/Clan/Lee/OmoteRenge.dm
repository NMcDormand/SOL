obj/SkillCards/Clan/Lee/OmoteRenge
	icon_state="card_OmoteRenge"
	cmdstring="OmoteRenge"
	Cooldown=2000
	CanLevel = 0

	Description = list(
		"about"="The user delivers an upward kick to their opponent, sending them high into the air folowing up with an attaack"
		,"title"="Omote Renge"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	Activate(mob/U)
		if(U.Gate<1) {U<<"You need to open the Initial Gate first"; return}
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		for(var/mob/M in get_step(U,U.dir))
			if(TAIATTACKCHECKYOU(M)) return
			if(M.TreeStump) {U<<"You cannot use this on this type of enemy."; return}
			if(U.CooldownCheck("Omote",CooldownCur*U.cooldownmultiplier)) return
			U.JutsuMessage(Description["title"])
			U.MoveUses[name]++
			flick("highkick",U)
			if(U.PracticeMode) return ..()
			var/dmg=round(U.Taijutsu*0.5-(M.Taijutsu*0.1))
			dmg+=U.Kicks()
			if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
			U.attacking=1
			if(U.HitCheck(M))
				var/a=M.movespeed
				M.movespeed=0; step(M,U.dir); M.movespeed=a
				flick("stagger",M)
				U.dir=M.dir;
				spawn(0)
					if(M)
						U.Move(M.loc)
				M.DamageMe(U,dmg,"kick")
				if(M && !M.KO && !M.dead)
					flick("lotus",U)
					if(U.dir==NORTH) U.pixel_y-=16
					if(U.dir==NORTHWEST) {U.pixel_y-=4; U.pixel_x+=8}
					if(U.dir==NORTHEAST) {U.pixel_y-=4; U.pixel_x-=8}
					if(U.dir==SOUTH) U.pixel_y+=16
					if(U.dir==SOUTHWEST) {U.pixel_y+=4; U.pixel_x+=8}
					if(U.dir==SOUTHEAST) {U.pixel_y+=4; U.pixel_x-=8}
					if(U.dir==WEST)	U.pixel_x+=16
					if(U.dir==EAST)	 U.pixel_y-=16
					U.Lotus=1; M.Lotus=1
					U.Lotus(M)
				else spawn(15)U.attacking=0
				var/taiup=rand(3,5)
				U.ApplyEXP(taiup+M.taitraining,"taijutsu")
				U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1;
				spawn(15)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
		..()

mob/proc
	Lotus(mob/M)
		spawn(7)
			if(M)
				Lotus=0; M.Lotus=0
				var/dmg=round(Taijutsu*2.5-(M.Taijutsu*0.3))
				if(dmg<round(Taijutsu*0.2)) dmg=round(Taijutsu*0.2)
				M.DamageMe(src,dmg,"Lotus"); DamageMe(src,dmg*0.0015,"Lotus")
				range(6,M)<<"[src] brings [M] crashing down with \his Lotus"
				pixel_x=0; pixel_y=0; attacking=0
		spawn(30)attacking=0