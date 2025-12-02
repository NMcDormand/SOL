obj/SkillCards/Clan/Akimichi/Baika
	cmdstring="Baika"
	name="Baika no Jutsu"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)Baika()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Expansion Technique"
		Description["title"]="Baika no Jutsu"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/Baika()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.nagashi)return
		if(usr.ingreen||usr.inyellow||usr.inred||usr.inpilluse)return
		if(usr.InMeatTank)
			usr<<"Not while using Nikudan Sensha!"
			return
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(usr.Calories<2)
			usr<<"You don't have enough Calories!"
			return
		if(usr.Giant)
			usr.Akimichi_Revert()
			usr.Giant=0
			usr.firing=0
			usr.stamina=usr.mstamina
			usr.Reflex=usr.mReflex
			usr.loadoverlays()
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.baika()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0
obj/SkillCards/Clan/Akimichi/Nikudan
	cmdstring="Nikudan"
	name="Nikudan Sensha"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)Nikudan()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Bullet Tank, run over your oppenents. Better with more calories!"
		Description["title"]="Nikudan Sensha"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/Nikudan()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.onwater)
			usr<<"You can't be on water to use Nikudan Sensha!"
			return
		if(usr.nagashi)return
		if(!usr.Giant)
			usr<<"You need to be using Baika no Jutsu!"
			return
		if(usr.InMeatTank)return
		if(usr.InMeatTankHari)return
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(usr.Calories<2)
			usr<<"You don't have enough Calories!"
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.nikudan()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0
obj/SkillCards/Clan/Akimichi/NikudanHari
	cmdstring="NikudanH"
	name="Nikudan Hari Sensha"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)NikudanH()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Bullet Tank with Spikes, run over your oppenents. Better with more calories!"
		Description["title"]="Nikudan Sensha"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=80
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/NikudanH()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.onwater)
			usr<<"You can't be on water to use Nikudan Sensha!"
			return
		if(!usr.Giant)
			usr<<"You need to be using Baika no Jutsu!"
			return
		if(usr.nagashi)return
		if(usr.InMeatTank)return
		if(usr.InMeatTankHari)return
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(usr.Calories<2)
			usr<<"You don't have enough Calories!"
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.nikudanhari()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0
obj
	Items
		Pills
			icon='Pills.dmi'
			Green
				icon_state="green"
				pill=1
			Yellow
				icon_state="yellow"
				pill=2
			Red
				icon_state="red"
				pill=3
			Click()
				if(!pill)return
				if(usr.Giant)
					usr<<"You can't eat the Pills while using Baika no Jutsu!"
					return
				if(usr.InMeatTank||usr.InMeatTankHari)
					usr<<"Not while in Nikudan Sensha or Nikudan Hari Sensha!"
					return
				if(usr.inpilluse||usr.pilldelay)
					usr<<"You can´t use any pill again just yet!"
					return
				if(pill==1)
					if(usr.ingreen||usr.inyellow||usr.inred)return
					usr.inpilluse=1
					usr.ingreen=1
					usr.inyellow=0
					usr.inred=0
					usr.loadoverlays()
					usr.Tstamina=usr.mstamina
					usr.mstamina=round(round(usr.mstamina+round(usr.mstamina/0.2)))
					usr.tai=round(usr.mtai*1.2)
					usr.Reflex+=10
					if(usr.stamina<usr.mstamina)usr.stamina=usr.mstamina
					usr<<"<b>You eat the Green Pill</b>"
					spawn(50)
						if(usr.inpilluse)
							usr.inpilluse=0
					usr.PillsDrain()
					spawn(200)
						if(usr.ingreen)
							usr<<"The Effects of the Green Pill are over!"
							usr.ingreen=0
							usr.tai=usr.mtai
							usr.mstamina=usr.Tstamina
							if(usr.stamina>usr.mstamina)usr.stamina=usr.mstamina
							usr.Tstamina=null
							usr.pilldelay=1
							spawn(350)
								if(usr)
									usr.pilldelay=0
				if(pill==2)
					if(!usr.ingreen)
						usr<<"You need to be under the effect of the Green Pill!"
						return
					if(usr.inyellow||usr.inred)return
					usr.inpilluse=1
					usr.ingreen=0
					usr.inyellow=1
					usr.inred=0
					usr.loadoverlays()
					usr.mstamina=round(round(usr.mstamina+round(usr.mstamina/0.4)))
					usr.tai=round(usr.mtai*1.4)
					usr.nin=round(usr.mnin*0.8)
					usr.Reflex+=20
					if(usr.stamina<usr.mstamina)usr.stamina=usr.mstamina
					usr<<"<b>You eat the Yellow Pill</b>"
					spawn(50)
						if(usr.inpilluse)
							usr.inpilluse=0
					spawn(280)
						if(usr.inyellow)
							usr<<"The Effects of the Yellow Pill are over!"
							usr.inyellow=0
							usr.tai=usr.mtai
							usr.nin=usr.mnin
							usr.Reflex=usr.mReflex
							usr.mstamina=usr.Tstamina
							if(usr.stamina>usr.mstamina)usr.stamina=usr.mstamina
							usr.Tstamina=null
							usr.loadoverlays()
							usr.pilldelay=1
							spawn(450)
								if(usr)
									usr.pilldelay=0
				if(pill==3)
					if(!usr.inyellow)
						usr<<"You need to be under the effect of the Yellow Pill!"
						return
					if(usr.ingreen||usr.inred)return
					usr.inpilluse=1
					usr.ingreen=0
					usr.inyellow=0
					usr.inred=1
					usr.Calories=0
					usr.loadoverlays()
					usr.mstamina=round(round(usr.mstamina+round(usr.mstamina/1.2)))
					usr.tai=round(usr.mtai*1.8)
					usr.nin=round(usr.mnin*1.2)
					usr.Reflex+=40
					if(usr.stamina<usr.mstamina)usr.stamina=usr.mstamina
					usr<<"<b>You eat the Red Pill</b>"
					spawn(50)
						if(usr.inpilluse)
							usr.inpilluse=0
					spawn(320)
						if(usr.inred)
							usr<<"The Effects of the Red Pill are over!"
							usr.inred=0
							usr.tai=usr.mtai
							usr.mstamina=usr.Tstamina
							usr.nin=usr.mnin
							usr.Reflex=usr.mReflex
							usr.wounds=150
							usr.stamina=0
							usr.KO=1
							usr.Tstamina=null
							usr.Death(usr,"Pill")
							usr.pilldelay=1
							spawn(550)
								if(usr)
									usr.pilldelay=0
mob
	proc
		PillsDrain()
			if(!ingreen&&!inyellow&&!inred)return
			var/timer=0
			if(ingreen)
				stamina-=rand(30,50)
				if(stamina<50)stamina=50
				timer=100
			if(inyellow)
				stamina-=rand(80,120)
				if(stamina<35)stamina=35
				timer=80
			if(inred)
				stamina-=rand(150,350)
				if(stamina<1)stamina=1
				timer=50
			spawn(timer)
				if(src)
					PillsDrain()
		nikudanhari()
			InMeatTankHari=1
			InMeatTankHit=0
			savespeed=movespeed
			movespeed=1
			loadoverlays()
			spawn(100)
				if(InMeatTankHari)
					InMeatTankHari=0
					movespeed=savespeed
					src<<"<b>You stop using Nikudan Sensha!</b>"
					loadoverlays()
		nikudan()
			InMeatTank=1
			InMeatTankHit=0
			savespeed=movespeed
			movespeed=1
			loadoverlays()
			spawn(100)
				if(InMeatTank)
					InMeatTank=0
					movespeed=savespeed
					src<<"<b>You stop using Nikudan Sensha!</b>"
					loadoverlays()
		baika()
			Giant=1
			loadoverlays()
			spawn(1)Calorie_Drain(2)
			stamina*=2
			Reflex-=20
			if(Reflex<1)Reflex=1
		Calorie_Drain(var/previous)
			if(!Giant) return
			if(Calories<=10)
				Akimichi_Revert()
				return
			Calories-=previous
			if(Calories<1)Calories=1;
			if(Calories<0)Calories=0; //If we go under zero, set to 0
			previous*=1.05
			spawn(20) Calorie_Drain(previous)
		Akimichi_Revert()
			Giant=0
			if(InMeatTank)
				InMeatTank=0
				movespeed=savespeed
			if(InMeatTankHari)
				InMeatTankHari=0
				movespeed=savespeed
			if(stamina>mstamina)stamina=mstamina
			Reflex=mReflex
			loadoverlays()
		Akimichi_Revert_Death()
			if(InMeatTank)
				InMeatTank=0
				movespeed=savespeed
			if(InMeatTankHari)
				InMeatTankHari=0
				movespeed=savespeed
			firing=0
			Giant=0
			stamina=mstamina
			Reflex=mReflex
			loadoverlays()

mob
	var
		Calories=30
		CalorieLimit=200
		InBaika=0
		InMeatTank=0
		InMeatTankHari=0
		InMeatTankHit=0
		Giant
//------------------------------//
//--------------DONT KNOW HOW YOU HAVE THE BUMP SYSTEM MINE IS REALLY JUST NO BUMP I HAVE DETECTION ANYWAY ADD mob/Bump()---------------------//
mob
	Bump(mob/I)
		if(I==usr)return
		if(I.owner==usr)return
		if(InMeatTank)
			view(I)<<"[I] was hit by [src] Nikudan Sensha!"
			InMeatTankHit++
			if(InMeatTankHit>=5)
				InMeatTank=0
				loadoverlays()
				src<<"You stop using Nikudan Sensha!"
		if(InMeatTankHari)
			view(I)<<"[I] was hit by [src] Nikudan Hari Sensha!"
			InMeatTankHit++
			if(InMeatTankHit>=8)
				InMeatTankHari=0
				loadoverlays()
				src<<"You stop using Nikudan Hari Sensha!"