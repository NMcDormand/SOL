/*proc
	AdminActionLog(var/action, var/reason, var/time=0, var/mob/punishedPlayer, var/mob/VerbHolder/Admin, var/ignoreDatabase=0)
		var/message
		if(punishedPlayer)
			if(time)
				message = "[time2text(world.realtime)]: [punishedPlayer] was [action] for [time] minutes; Action by [Admin.ckey]; Reason: [reason]"
			else
				message = "[time2text(world.realtime)]: [punishedPlayer] had [action] happen; Action by [Admin]; Reason: [reason]"

		else
			message = "[time2text(world.realtime)]: [action] happen; Action by [Admin]; Reason: [reason]";
		text2file(message, "Punishments/[punishedPlayer.ckey].txt")
		text2file(message, "AdminLogs/[Admin.ckey].txt")
*/
mob
	verb
		Admin_Logs()
			var/A = input("Which GM log would you like to check?","GM Log") as null|anything in GMs
			if(A)
				var/playerAbuse = \
				      {"
						<html>
							<head>
								<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
								<title>GM Log</title>
								<style>
									html		{overflow-x:hidden;}
									body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
									h1			{position:relative;left:35px;padding:0px;}
									#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
								</style>
								<script>
									function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
								</script>
							</head>
							<body>
								<h1>[A] Admin Log</h1>
								[file2text("AdminLogs/[A].txt")]
								<div id="RedLine"></div>
							</body>
						</html>
				      "}
				src << browse(playerAbuse, "window=Check History;size=800x500")
proc
	AddPunishment(var/action, var/reason, var/time=0, var/mob/PunishedPlayer, var/mob/VerbHolder/Admin)
		var/message
		if(!Admin || !PunishedPlayer)
			return
		if(time)
			message = "<br /><span class=\"[action]\">[time2text(world.realtime)]: [action] for [time] minutes; Action by [Admin.ckey]; Reason: [reason]</span>"
		else
			message = "<br /><span class=\"[action]\">[time2text(world.realtime)]: [action]; Action by [Admin.ckey]; Reason: [reason]</span>"

		text2file(message, "Punishments/[PunishedPlayer.ckey].txt")


	AdminActionLog(var/action, var/reason, var/time=0, var/mob/punishedPlayer, var/mob/Admin)
		var/message
		if(!Admin || !punishedPlayer)
			return
		if(punishedPlayer)
			if(time)
				message = "<br /><span class=\"[action]\">[time2text(world.realtime)]: [punishedPlayer.trueName] was [action] for [time] minutes; Action by [Admin.ckey]; Reason: [reason]</span>"
			else
				message = "<br /><span class=\"[action]\">[time2text(world.realtime)]: [punishedPlayer.trueName] was [action]; Action by [Admin]; Reason: [reason]</span>"
		else
			message = "<br /><span class=\"[action]\">[time2text(world.realtime)]: [action] happen; Action by [Admin]; Reason: [reason]</span>";
		text2file(message, "AdminLogs/[Admin.ckey].txt")