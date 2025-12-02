mob/var
	HasBeenKO
	NPCDamage[]
mob/proc
	AttributeDamagePoints(mob/NPC,wounds)	//not called anywhere
		if(wounds>100) wounds=100
		wounds=min(wounds,(150-NPC.Wounds))
		var/pts=NPC.KillValue*(wounds/100)
		if(!NPC.HasBeenKO&&NPC.Wounds<100)
			if(NPC.ShadowCaptured)
				var/mob/share=NPC.ShadowCaptured
				if(share!=src) {pts/=2; share.KonohaInvasionPoints+=pts}
				share.Refresh_InvasionScore()
			if(Creator)
				Creator.KonohaInvasionPoints+=pts
			else
				KonohaInvasionPoints+=pts
			Refresh_InvasionScore()

	AttributeKillPoints(mob/NPC)
		if(!NPC.NPCDamage) NPC.NPCDamage=new()
		var/pts = 0
		if(MostDamageCheck(NPC,KI_Participants)&&NPC.HasBeenKO==src) pts+=(NPC.KillValue*1.1)
		else if(MostDamageCheck(NPC,KI_Participants)) pts+=(NPC.KillValue*1)
		else if(NPC.HasBeenKO==src) pts+=(NPC.KillValue*0.6)
		else if(NPC.NPCDamage[src]>0) pts+=(NPC.KillValue*0.3)
		else pts+=round(NPC.KillValue*0.1)

		if(Creator)
			Creator.KonohaInvasionPoints+=pts
		else
			KonohaInvasionPoints+=pts

		Refresh_InvasionScore()

	MostDamageCheck(mob/NPC,list/People)
		var/mostdamage=0
		if(!NPC.NPCDamage) NPC.NPCDamage=new()
		for(var/mob/m in People) mostdamage=max(NPC.NPCDamage[m],mostdamage)
		if(mostdamage==NPC.NPCDamage[src]) return 1
		else return 0

	Refresh_InvasionScore()
		if(client)
			var/points=round(KonohaInvasionPoints)
			winset(src,"mainwindow.MissionScore","text='[points] pts'")

	Show_InvasionScore()
		if(client) winshow(src,"mainwindow.MissionScore",1)

	Hide_InvasionScore()
		if(client) winshow(src,"mainwindow.MissionScore",0)