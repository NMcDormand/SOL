mob/player
	Dummy1
		name="Roy"
		icon='Base_Medium.dmi'
		NinjaRank="Jounin"
		Stamina=10
	Dummy2
		name="Xavier"
		icon='Base_Medium.dmi'
		Stamina=10
		NinjaRank="Jounin"
	Dummy3
		name="Clint"
		icon='Base_Medium.dmi'
		Stamina=10
		NinjaRank="Jounin"
	Dummy4
		name="Jeff"
		icon='Base_Medium.dmi'
		Stamina=10
		NinjaRank="Jounin"
	Dummy5
		name="Zack"
		icon='Base_Medium.dmi'
		Stamina=10
		NinjaRank="Jounin"

mob/VerbHolder/Admin/Creator/verb
//	SelectForForest(mob/B in view())
//		set category="Staff"
//		ForestList+=B
	BeginExam()
		set category="Staff"
		spawn(100)
			ChuuninCheck=0
			ChuuninAccess=0
			ChuuninTime=1
			for(var/mob/player/G in world)
				if(G.client&&G.NinjaRank=="Genin") {G<<"<font size=2><b>Chuunin exam has started!</b></font>"; spawn(1200)G<<"The Chuunin exam is over."}
			spawn(7200)
				ChuuninExamTime=world.timeofday+7200; ChuuninTime=0; ChuuninCheck=1
				spawn(50)ChuuninExamCollection()
				for(var/mob/player/C in world)
					if(C.NinjaRank=="Genin")
						if(C.TakingChuuninExam) C<<"The Chuunin exam is over; please wait while your papers are collected."
						else
							ChuuninVillage=pick("Leaf","Mist","Sand","Cloud","Rock","Sound","Waterfall","Grass","Rain")
							C<<"<font size=2><b>The next Chuunin exam will be held in [ChuuninVillage] in two hours.</b></font>"
	RoundListWho()
		set category="Staff"
		world<<"<u>---Fighting List---</u>"
		for(var/mob/player/P in FightingList) world<<"<font color=red>[P]</font>"
		world<<"<u>---Battle List---</u>"
		for(var/mob/player/P in BattleList) world<<"<font color=red>[P]</font>"
		world<<"<u>---Round 2---</u>"
		for(var/mob/player/P in RoundTwoList) world<<"<font color=red>[P]</font>"
		world<<"<u>---Round 3---</u>"
		for(var/mob/player/P in RoundThreeList) world<<"<font color=red>[P]</font>"
		world<<"<u>---Round 4---</u>"
		for(var/mob/player/P in RoundFourList) world<<"<font color=red>[P]</font>"

