mob/proc
	Suiton_Suikoudan()
		var/c=200,s=SS*10
		if((!(GENERICATTACKCHECK(src))&&Chakra>c)&&(!onwater||WaterElemental>=2000))
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Suiton: Suikoudan!</b>"
				var/obj/Jutsu/Suiton/Suikoudan/S=new/obj/Jutsu/Suiton/Suikoudan
				CreateProjectile(src,S,"Water",get_step(src,dir),dir,2,18,1,1.6)
				sleep(6)

	Katon_Ryuuka()
		var/c=200,s=SS*9
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Katon: Ryuuka no Jutsu!</b>"
				var/obj/Jutsu/Katon/Ryuuka/K=new/obj/Jutsu/Katon/Ryuuka
				CreateProjectile(src,K,"Fire",loc,dir,2,18,1,1.5)
				sleep(6)

	Doton_DoryuuDango()
		var/c=350,s=SS*8
		if(!(GENERICATTACKCHECK(src))&&Chakra>c&&(!onwater||EarthElemental>2000))
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				view(4,src)<<"<b>[src]: Doton: Doryuu Dango!</b>"
				var/obj/Jutsu/DoryuuDango/D=new/obj/Jutsu/DoryuuDango
				CreateProjectile(src,D,"Earth",loc,dir,1,9,1,1.3)
				sleep(6)

	Raiton_Raikyuu()
		var/c=120,s=SS*5
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Raiton: Raikyuu!</b>"
				var/obj/Jutsu/Raiton/Raikyuu/R=new/obj/Jutsu/Raiton/Raikyuu
				CreateProjectile(src,R,"Lightning",loc,dir,0,8,1,1.5)
				sleep(6)

	Fuuton_Daitoppa()
		var/c=100,s=SS*2
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				view(4,src)<<"<b>[src]: Fuuton: Daitoppa!</b>"
				var/obj/Jutsu/Fuuton/Daitoppa/F=new/obj/Jutsu/Fuuton/Daitoppa
				CreateProjectile(src,F,"Wind",loc,dir,0,10,1,1.2)
				sleep(6)

	AI_Shousen(mob/M)
		return
proc
	AI_Kyoumeisen(mob/U,mob/m)
		var/c=50,s=U.SS*2
		if(!(GENERICATTACKCHECK(U)) &&U.Chakra>c)
			U.icon_state="seals"; U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(20)
					if(U)
						U.firing=0
				U.Chakra-=c; hearers(4,U)<<"<b>[U]: Kyoumeisen!</b>"
				var/turf/T = U.loc; var/mob/M
				for(var/i=1;i<=2;i++)
					T = get_step(T,U.dir)
					if(T)
						M = locate() in T
						if(M&&m==M) break
						else M=null
				if(M)
					M<<"[U] has blasted you with sound."
					sleep(2)
					M<<"Your inner ear has been damaged."; M.Blasted=1
					spawn(90)
						if(M) {M<<"Your sense of balance has returned."; M.Blasted=0}

	AI_Ranshin_Shou(mob/U,mob/M)
		if(!(GENERICATTACKCHECK(U)) && !TAICHECKBOTH(U,M))
			if(U.HitCheck(M))
				flick("punch",U)
				U.attacking=1; spawn(5)U.attacking=null
				M<<"[U] disrupted your nerves."; M.Nerves=1
				spawn(400)
					if(M&&M.Nerves)  {M.Nerves=0; M<<"Your nerves have healed."}
			else
				U.attacking=1; spawn(10)U.attacking=null
				M<<"You dodged [U]'s attack."
			sleep(10)