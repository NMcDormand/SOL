var/IPMuteList=list()
mob/proc/TrackTarget(mob/T)
	if(T&&T.z==1)
		if(T&&T.y<=567)
			for(var/obj/tracking/tracker1/P in client.screen)
				P.invisibility=7
			if(T.x<795)
				for(var/obj/tracking/tracker1/P in client.screen)
					P.pixel_y=T.y/6.163
					P.pixel_x=T.x/6.25
					var/l="1:[P.pixel_x],1:[P.pixel_y]"
					P.screen_loc="MiniMap:[l]"
			else
				for(var/obj/tracking/tracker1/P in client.screen)
					P.pixel_y=T.y/6.163
					P.pixel_x=(T.x-795)/6.40625
					var/l="5:[P.pixel_x],1:[P.pixel_y]"
					P.screen_loc="MiniMap:[l]"
	spawn(20)
		if(Tracking&&T)
			TrackTarget(T)
		else
			for(var/obj/tracking/tracker1/t in client.screen) t.invisibility=7
mob/VerbHolder/Admin/Level3/verb
/*	CheckOutPlayer()
		set category = "Staff"
		set name = "Check Out player"
		set desc= "L3: See many player stats."
		var/mob/w=input("View who's profile?","View Profile") as null|anything in MasterPlayerList
		if(w) {usr.CheckOut(w); winshow(usr,"StatView",1)}
*/
	Toggle_Density()
		set category = "Staff"
		if(density)
			density = 0
		else
			density = 1
	SaveAll()
		set category = "Staff"
		set name = "Save All"
		set desc="Host: Save everyone's game file"
		usr<<"<font color=red>Saving...</font>"
		AdminActionLog("Save All", "None", , , src, 1)
		WorldSave(1)
//-------------------------------------------------------------------------------------------------------------
	Remove_Overlays(mob/M in world)
		set name = "Remove Overlays"
		set category = "Staff"
		set desc="Host: Remove overlayed objects from a player's icon"
		if(istype(M,/mob/player)) {M.overlays=null; AdminActionLog("Remove Overlays", "None", , M, src, 1);}
//-------------------------------------------------------------------------------------------------------------
	Remove_Underlays(mob/M in world)
		set name = "Remove Underlays"
		set category = "Staff"
		set desc="Host: Remove underlayed objects from a player's icon"
		if(istype(M,/mob/player)) {M.underlays=null; AdminActionLog("Remove Underlays", "None", , M, src, 1);}

	Reboot()
		set name = "Reboot"
		set category = "Staff"
		set desc="Host: Reboot world."
		if(AdminLevel>4)
			switch(alert("Please choose a reboot type","Reboot Type","Auto","Hidden","Normal"))
				if("Hidden")
					WorldSave(1)
					src<<"Rebooting Now... xoxo"
					world.Reboot()
					return
				if("Auto")
					WorldRebootProc()
					return
		AdminActionLog("Reboot", "None", , , src, 1)
		world << "<font color=red size=3><b>World Reboot in 10 seconds.</font>"
		NotifyAll("reboot")
		spawn(100)world << "<font color=red>Rebooting now...</font>"; spawn(110)world.Reboot()

	Invis()
		set name="Invis"
		set category="Staff"
		set desc="MGM: Become invisible and lose density"
		if(!usr.GMInvis)
			usr.RemoveAllTargetMe()
			usr.GMInvis=1
			usr.invisibility += 10
			usr.density=0
			usr<<"<font color=red>Invisibility on.</font>"
		else if(usr.GMInvis)
			usr.GMInvis=0
			usr.invisibility -= 10
			usr.density=1
			usr<<"<font color=red>Invisibility off.</font>"

	Reset_Cooldowns(var/mob/M in MasterPlayerList)
		M.Cooldowns = list()

	ClearRebirth(mob/M in MasterPlayerList)
		if(alert("Are you sure you would you like to clear their Rebirth Profile?","Rebirth Reset","Yes","No") == "Yes")
			fdel("Saves/[copytext(M.ckey, 1, 2)]/[M.ckey]/[M.Slot]/Rebirth.sav")
			M.RebirthData = null
			M.RebirthData = new(M)

	CheckRebootTime()
		set category = "Staff"
		set name = "Check Reboot Time"
		set desc= "L3: See how long until the next scheduled reboot - telling the players this time is not encouraged as it might enable AFKing."
		usr<<"The next scheduled reboot will be in [round((RebootTime-world.timeofday)/600)] minutes."
	/*TrackPlayer(mob/M in world)
		set category = "Staff"
		set name = "Track player"
		set desc= "L3: Will show their location on minimap if they are on it - runs on same proc as inuzuka track and Aburame track."
		if(M)
			AdminActionLog("Track player", "None", , M, src, 1)
			usr.TrackTarget(M)
			var/d=get_dir(usr,M)
			if(d==1) d="North"
			if(d==2) d="South"
			if(d==4) d="East"
			if(d==8) d="West"
			if(d==5) d="North-East"
			if(d==6) d="South-East"
			if(d==10) d="South-West"
			if(d==9) d="North-West"
			usr<<"<b>[M.name]:</b><font color=silver>Direction: [d]  Location: [M.x],[M.y],[M.z]"*/

/*	IP_Mute()
		set name="IP Mute"
		set category = "Staff"
		set desc="L3: Prevent an IP address from using OOC. Will auto-reset upon reboot."
		var/people=list()
		for(var/mob/player/p in world) people+=p
		var/mob/M=input("Select a player to be muted","IP Mute") as null|anything in people
		if(M)
			var/reason=input({""This player will be IP-muted for...""}) as text
			IPMuteList+=M.client.address
			world << "<font color=red><i>[M] has been IP-muted for: [reason]</font></i>"*/
	IP_Unmute()
		set name="IP Unmute"
		set category = "Staff"
		set desc="L3: Allow an IP address to using OOC."
		var/people=list()
		for(var/mob/player/p in world)
			if(p.client.address in IPMuteList) people+=p
		var/mob/M=input("Select a player to be unmuted","IP Unmute") as null|anything in people
		if(M) {IPMuteList-=M.client.address; world << "<font color=red><i>[M] is no longer IP-muted.</font></i>"}

//-------------------------------------------------------------------------------------------------------------
	Invisible()
		set name="Invisiblity"
		set category="Staff"
		set desc="L3: Become invisible."
		if(!usr.GMInvis)
			usr.RemoveAllTargetMe()
			usr.GMInvis=1
			usr.invisibility += 80
			usr<<"<font color=red>Invisibility on.</font>"
			AdminActionLog("Invis", "Went Invisible", , , src, 1)
		else if(usr.GMInvis)
			usr.GMInvis=0; usr.density=1;
			usr.invisibility -= 80
			usr<<"<font color=red>Invisibility off.</font>"
			AdminActionLog("Invis", "Went Visible", , , src, 1)
//----------------------------------------------------------------------------------------------
	GoTo(varX as num, varY as num, varZ as num)
		set name = "Go To X/Y/Z"
		set category = "Staff"
		set desc = "L3: Take yourself to any grid point"
		if(varX > world.maxx) varX = world.maxx
		else if(varX < 1) varX = 1
		if(varY > world.maxy) varY = world.maxy
		else if(varY < 1) varY = 1
		if(varZ > world.maxz) varZ = world.maxz
		else if(varZ < 1) varZ = 1
		AdminActionLog("GoTo", "Loc: [varX], [varY], [varZ]", usr, , src, 1)
		if(varZ==3) varZ = 1;

		usr.loc.loc.Exited(usr)
		usr.loc = locate(varX,varY,varZ)

		usr.loc.loc.Entered(usr)
//-------------------------------------------------------------------------------------------------------------
	DeathVerb(mob/M in world)
		set name = "Death"
		set category = "Staff"
		set desc="L3: Kill anyone/thing."
		//Add check here for village rank, if kage - don't take it away from them
		if(istype(M,/mob/Hittable/Responsive)||istype(M,/mob/player)||istype(M,/mob/Hittable/Command/Clones)||istype(M,/mob/Hittable/Responsive/Animal/Pet)) {
			M.KillMe(usr)
			AdminActionLog("Death Verb", "None", usr, M, src, 1)
		}
		else usr<<"Could not kill this type of mob"
	/*DeathView()
		set name = "Death View"
		set category = "Staff"
		set desc="L3: Kill any or all mobs on your screen"
		AdminActionLog("Death View", "None", usr, , src, 1)
		for(var/mob/M in oview())
			if(istype(M,/mob/NPC)||istype(M,/mob/player)||istype(M,/mob/Hittable/Command/Clones)||istype(M,/mob/Hittable/Responsive/Animal/Pet)) M.KillMe(usr)*/
//-------------------------------------------------------------------------------------------------------------
	Freeze(mob/M in world)
		set name = "Freeze"
		set category = "Staff"
		set desc="L3: Freeze a cheat."
		M.GMfrozen = 1
		spawn(10)
			M.overlays += 'frozen.dmi'
			world << "<font color=red><b>A hand descends from above and freezes [M]</b>!</font>"
			AdminActionLog("Frozen", , , M, src)

	Unfreeze(mob/M in world)
		set name = "Unfreeze"
		set category = "Staff"
		set desc="L3: Restore a frozen player."
		AdminActionLog("Un-Freeze", "None", , M, src, 1)
		M.GMfrozen = 0
		M.overlays -= 'frozen.dmi'
		M<< "<font color=red>You are no longer frozen!</font>"
		world<< "<font color=red><b>[M] is no longer frozen.</b></font>"
//------------------------------------------------------------------------------------------------------------
/*	WorldMute()
		set name = "World Mute"
		set category = "Staff"
		set desc="L3: No one can use OOC except staff."
		worldmute=1
		world<<"<font color=red><b>[usr] has muted the world</font></b>"
*/
	WorldUnMute()
		set name = "World UnMute"
		set category = "Staff"
		set desc="Everyone can use OOC again."
		worldmute=0
		world<<"<font color=red><b>[usr] has unmuted the world</font></b>"

	CheckTheirSkillSeeds(mob/M in MasterPlayerList)
		var/T={"<h1>[M]'s Skill Seeds</h1><h3>If you obtain the following Stat levels you will unlock the Skill</h3>"}
		var/B=0
		for(var/X in M.SkillSeeds)
			if(B==0)
				B=1
			else
				B=0
			//if(istype(x.vars[X]))
			/*if(0)
			//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				//var/Z=x.vars[X]
				//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

				//)</div>"}
				var/hi=1;*/
			var/SkillSeed/SS = M.SkillSeeds[X]
			if(SS)
				var/list/SR = SS.Stat_Req
				T+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>Ninjutsu:[SR["Ninjutsu"]], Taijutsu: [SR["Taijutsu"]], Genjutsu: [SR["Genjutsu"]]</span></div>"}
		//var/i="\[i]"
		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[M]'s Skill Seeds</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:12pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:32;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:8px 0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{color:#FF0000;position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function DispDesc(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		usr<<browse(HTML,"window=Browser[M]SS;size=600x400")
//-------------------------------------------------------------------------------------------------------------
	/*InitiateExam()
		set name="Start Exam"
		set category="Staff"
		set desc="L3: Using this will cause 2 exams to run unless the automatic exam has stopped..."
		switch(input("Which exam do you want to start?","Start an Exam")in list("Genin Exam","Chuunin Exam", "Instant Chuunin","Cancel"))
			if("Genin Exam")
				GeninAlert()
				return
			if("Chuunin Exam")
				ChuuninAlert()
				return
			if("Instant Chuunin")
				InstantChuuninAlert()
				return*/
//-------------------------------------------------------------------------------------------------------------
mob/VerbHolder/Admin/Level3/verb
/*	ChangeTag(mob/M in world)
		set name="Change Tag"
		set	desc="L3: Change a player's tag"
		set category="Staff"
		var/varNewTag = input(usr,"Change to what?","Tag Change","[M:Rank]") as text
		M:Rank = varNewTag
*/
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------