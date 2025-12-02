mob/var
	DamageMessages="all"
proc
	/*
	L = Listener
	M = Victim
	dmg = Damage
	attack = type of attack
	*/
	Damage_Message(mob/M,var/dmg,var/attack)
		if(!(attack)||(attack==null)) attack="attack"
		if(!(dmg)||(attack==dmg)) dmg="unknown"
		for(var/mob/L in DMGMSGlist)
			if(get_dist(L,M)<6)
				M<<"<i>[M] was hit by the [attack] for [round(dmg)] damage!</i>"

	DamageReport(mob/victim,mob/attacker,DAMAGE,METHOD)
		set waitfor = 0
		var/list/tell=list()
		if(DAMAGE < 10)
			DAMAGE = 10

		for(var/mob/player/L in DMGMSGlist)
			if(L && victim)
				if(get_dist(L,victim)<6 && L.z == victim.z && attacker.z == L.z)
					tell +=L

		if(!victim)
			return
		if(isobj(METHOD))
			tell<<"[victim] was hit by [attacker]'s [METHOD:name] for [DAMAGE] damage!"
		else
			if(!METHOD)
				METHOD="?"

			switch(METHOD)
				if("strikes") tell<<"[attacker] strikes [victim] for [DAMAGE] damage!"
				if("BunshinExplode") tell<<"[attacker]'s clone Explosion hit [victim] for [DAMAGE] damage!"
				if("attacks") tell<<"[attacker] hits [victim] for [DAMAGE] damage!"
				if("punch") tell<<"[attacker] punches [victim] for [DAMAGE] damage!"
				if("palm") tell<<"[attacker] palms [victim] for [DAMAGE] damage!"
				if("palms") tell<<"[attacker] palms [victim] for [DAMAGE] damage!"
				if("kick") tell<<"[attacker] kicks [victim] for [DAMAGE] damage!"
				if("slices") tell<<"[attacker] slices [victim] for [DAMAGE] damage!"
				if("hacks at") tell<<"[attacker] hacks at [victim] for [DAMAGE] damage!"
				if("stabs") tell<<"[attacker] stabs [victim] for [DAMAGE] damage!"
				if("whips") tell<<"[attacker] whips [victim] for [DAMAGE] damage!"
				if("sweeps") tell<<"[attacker] sweeps [victim] for [DAMAGE] damage!"
				if("slashes") tell<<"[attacker] slashes [victim] for [DAMAGE] damage!"
				if("swings at") tell<<"[attacker] swings at [victim] for [DAMAGE] damage!"
				if("pierced") tell<<"[attacker] pierced [victim] for [DAMAGE] damage!"
				if("slaps") tell<<"[attacker] slaps [victim] for [DAMAGE] damage!"
				if("rasengan") tell<<"[attacker]'s Rasengan hits [victim] for [DAMAGE] damage!"
				if("chidori") tell<<"[attacker]'s Chidori hits [victim] for [DAMAGE] damage!"
				if("sawarabi") tell<<"[victim] takes [DAMAGE] damage from [attacker]'s Sawarabi no Mai."
				if("own sawarabi") tell<<"[victim] has breached \his limit and takes [DAMAGE] damage from perfroming Sawarabi no Mai."
				if("throat slit") tell<<"[victim] had \his throat slit by [attacker] for [DAMAGE] damage."
				if("garouga") tell<<"[attacker] hits [victim] with Garouga for [DAMAGE] damage."
				if("tsuuga") tell<<"[attacker] hits [victim] with Tsuuga for [DAMAGE] damage."
				if("meattank") tell<<"[attacker] hits [victim] with Meat Tank for [DAMAGE] damage."
				if("Hiraishin") tell<<"[attacker] was hit by a flash for [DAMAGE] damage."
				if("HiraishinBarrage") tell<<"[attacker] hit [victim] 18 times for [DAMAGE] damage. all you see is a yellow flash"
				if("gatsuuga") tell<<"[attacker] hits [victim] with Gatsuuga for [DAMAGE] damage."
				if("suna shuriken") tell<<"[attacker] hits [victim] with a suna shuriken for [DAMAGE] damage."
				if("Dorou Doumu") tell<<"[victim] is hurt by [attacker]'s Dorou Doumu and takes [DAMAGE] damage."
				if("electricrecoil") tell<<"[attacker]'s electrical jutsu surges through [victim]'s suiton jutsu and hits \him for [DAMAGE] damage!"
				if("shinjuu") tell<<"[victim] is hurt by [attacker]'s Shinjuu Zashu attack, and takes [DAMAGE] damage."
				if("Explosion") tell<<"[victim] is hurt by [attacker]'s XPlosive Bunshins and takes [DAMAGE] damage."
				if("reflect") tell<< "<b>[attacker]'s attack is reflected back at \him causing [DAMAGE] damage!</b>"
				if("shock") tell<<"[victim] is paralysed by [attacker]'s Lightning dispersal, and takes [DAMAGE] damage."
				if("Inazuma") tell<<"[victim] is shocked by [attacker]'s Inazuma, and takes [DAMAGE] damage."
				if("KazanFunka") tell<<"[victim] is burned by [attacker]'s eruption, and takes [DAMAGE] damage."
				if("KuchuNejire") tell<<"[victim] is pushed by [attacker]'s gust of wind, and takes [DAMAGE] damage."
				if("neck bind") {tell-=victim; victim-=attacker; tell<<"[attacker]'s Neck Bind does [DAMAGE] damage to [victim]."}
				if("Self") tell<<"[victim] injures themself for [DAMAGE] damage."
				if("Samehada Self") tell<<"[victim] has been damaged by Samehada's Thirst for [DAMAGE] damage."
				if("Shibuki") tell<<"[victim] has been damaged by an Explosive Note for [DAMAGE] damage."
				if("doublePunch")
					var/dmgNum=(DAMAGE/1.8)
					dmgNum=DAMAGE%dmgNum
					tell<<"[attacker] strikes [victim] twice for [DAMAGE] (+[dmgNum]) damage!"
				if("RasenShuriken") tell << "[victim] is immeasurably damaged by [attacker]'s Rasenshuriken for [DAMAGE] damage."
				if("Jashin") tell<<"[victim] is injured by [attacker]'s Blood Ritual for [DAMAGE] damage."
				if("tsukuyomi") tell<<"[victim] is damaged by [attacker]'s Tsukuyomi, and takes [DAMAGE] damage."
				if("RetsudoTensho") tell << "[victim] is damaged by [attacker]'s Retsudo Tensho, and takes [DAMAGE] damage."
				if("ClayDeteriorate") tell << "[victim] is damaged by [attacker]'s C4 bombs, and takes [DAMAGE] damage."
				if("ClayBomb") tell << "[victim] is damaged by [attacker]'s clay bomb, and takes [DAMAGE] damage."
				if("ZeroBomb") tell << "[victim] is damaged by [attacker]'s ultimate explosion, and takes [DAMAGE] damage."
				if("Lotus") tell << "[victim] is damaged by [attacker]'s Lotus, and takes [DAMAGE] damage."
				if("Shibari") tell << "[victim] is damaged by [attacker]'s Lightning Pillars, and takes [DAMAGE] damage."
				if("Sound") tell << "[victim] is damaged by [attacker]'s Wave of sound, and takes [DAMAGE] damage."
				if("ShikiFujin") tell << "[victim]'s body rots for [DAMAGE] damage."
				if("Shinwonryu") tell << "[victim]'s has their Shinsu drained from their body for [DAMAGE] damage."
				if("ShinsuForce") tell << "[victim] was blasted by [attacker]s Shinsu for [DAMAGE] damage."
				if("sliced") tell << "[victim]'s had their tendons sliced for [DAMAGE] damage."
				if("FuujinHeki") tell << "[attacker]'s barrier slashed [victim] for [DAMAGE] damage."
				if("Suirou") tell << "[attacker]'s Suirou damages [victim] for [DAMAGE] damage."
				if("SoSo") tell << "[attacker] crushed [victim] for [DAMAGE] damage."
				if("TengaShinsei") tell << "[attacker]'s Tenga Shinsei damaged [victim] for [DAMAGE] damage."
				if("HaiseBlow") tell << "[attacker]'s Haisekisho explosion damaged [victim] for [DAMAGE] damage."
				if("HaiseFlames") tell << "[attacker]'s Flames from Haisekisho damaged [victim] for [DAMAGE] damage."
				if("drowning") tell << "You are suffering from water entering your lungs and damaged for [DAMAGE]."
				if("ChibakuTensei") tell << "You are crushed by the pull from [attacker]'s Chibaku Tensei for [DAMAGE] damage."
				if("?") tell<<"Console: [attacker]'s attack had no METHOD variable. Please report this to a GM, or in the SoM discord; be sure to mention what attack caused it!"
				else tell<<"Console: <u>Unrecognised attack</u>.\nDamage=[DAMAGE]\nAttacker=[attacker]\nVictim=[victim]\nMethod=[METHOD]\nPlease inform a GM or leave a message on the SoM Discord"

obj
	damageOverlay
		maptext_width   = 160
		maptext_y       = 30
		maptext_x       = -65
		alpha           = 255
		layer           = 99

var
	WorldDamageOverlays = 1

mob
	var
		DOLAYS = 1
proc
	TextRandoOverlay(var/mob/M, MSG, Alpha=200, Repeat=1, Wait=1, FNTCLR = "#FF0000")
		set waitfor = 0 //We don't want the damage txt holding us up!!!
		spawn(-1)

			MSG ="<b><center><font color = [FNTCLR]> [MSG]</font></center></b>"

			var/DOIT = 0
			for(var/T = 1 to Repeat)
				var/image/i = image(null,M)
				for(var/mob/player/PL in viewers(8,M))
					if(PL.DOLAYS)
						DOIT++
						PL << i
				if(DOIT)
					var
						X=rand(-260,260)
						Y=rand(-260,260)
					i.layer=255
					i.ilvl=1234
					i.maptext_width=96
					//i.maptext_height=64
					i.pixel_x=X
					i.pixel_y=Y
					i.alpha=Alpha
					i.maptext=MSG
					spawn(5)
						var/B=i.alpha*0.5
						for(var/I=1 to 2)
							i.alpha-=B
							i.maptext_y+=16
							sleep(2)
						del i
				else
					del i
				sleep(Wait)

	TextExactOverlay(var/mob/M, MSG, X=0, Y=0, Alpha=200, FNTCLR = "#FF0000")
		set waitfor = 0 //We don't want the damage txt holding us up!!!
		spawn(-1)
			MSG ="<b><center><font color = [FNTCLR]> [MSG]</font></center></b>"
			var/image/i = image(null,M)
			var/DOIT = 0
			for(var/mob/player/PL in viewers(8,M))
				if(PL.DOLAYS)
					DOIT++
					PL << i
			if(DOIT)
				i.layer=255
				i.ilvl=1234
				i.maptext_width=96
				//i.maptext_height=64
				i.pixel_x=-48
				i.pixel_y=Y
				i.alpha=Alpha
				i.maptext=MSG
				spawn(5)
					var/B=i.alpha*0.5
					for(var/I=1 to 2)
						i.alpha-=B
						i.maptext_y+=16
						sleep(2)
					del i
			else
				del i

	TextOverlay(var/mob/M, dano, tipo, X=pick(-48,-32,-16,0),Y=28,Alpha=200)
		set waitfor = 0 //We don't want the damage txt holding us up!!!
		spawn(-1)
			var
				msg
				image/i = image(null,M)

			switch(tipo)
				if("Damage")
					msg ="<b><center><font color= #FF0000> -[dano]</font></center></b>"
				//if("Damage")
				//	msg ="<b><center><font color = red> +[dano]</font></center></b>"

				if("Miss")
					msg ="<b><center><font color = red> MISS</font></center></b>"

				if("stump")
					msg ="<b><center><font color = #9400D3> -[dano]</font></center></b>"

				if("health")
					msg ="<b><center><font color = green> -[dano]\n Wounds</font></center></b>"

				if("RestoreMp")
					msg ="<b><center><font color = blue> +[dano]</font></center></b>"

				if("RemoveMp")
					msg ="<b><center><font color = blue> -[dano]</font></center></b>"

			var/DOIT = 0
			for(var/mob/player/PL in viewers(4,M))
				if(PL.DOLAYS)
					DOIT++
					PL << i
			if(DOIT)
				i.layer=255
				i.ilvl=1234
				i.maptext_width=96//512
				//i.maptext_height=64
				i.pixel_x=X
				i.pixel_y=Y
				i.alpha=Alpha
				i.maptext=msg
				sleep(5)
				var/B=i.alpha*0.5
				for(var/I=1 to 2)
					i.alpha-=B
					i.maptext_y+=16
					sleep(2)
				del i
			else
				del i
