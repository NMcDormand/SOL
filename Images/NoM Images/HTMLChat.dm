mob/Living/Player
	//var
		//list/ChatToggle = ("OOC"=1,"Say"=1,"Village"=1,"Guild"=1,"Output"=1,"Private"=1,"Admin"=0,"DMGMSG" = 1, "GainMsg" =1)
	verb
		TestMeBitch()
			HTMLChatPanel("Sett","ColoSetts",1)
			HTMLChatPanel("Game","ItemPage",2)
			HTMLChatPanel("Game","StatsPage",3)
			HTMLChatPanel("Chat","OOC",4)

		TryMe(N as num)
			if(N == 1)
				winset(usr,"map1","size=1280x640")
				winset(usr,"map1","pos=0,0")
				client.view="40x20"
				winset(src,"Panel1","is-visible=false")
				winset(src,"Panel2","is-visible=false")
				winset(src,"Panel3","is-visible=false")
				winset(src,"Panel4","is-visible=false")
			else if(N == 2)
				winset(usr,"map1","size=960x640")
				winset(usr,"map1","pos=0,0")
				client.view="30x20"
				winset(src,"Panel1","is-visible=false")
				winset(src,"Panel2","is-visible=false")
				winset(src,"Panel3","is-visible=true")
				winset(src,"Panel4","is-visible=true")
			else if(N == 3)
				winset(usr,"map1","size=640x640")
				winset(usr,"map1","pos=320,0")
				client.view="20x20"
				winset(src,"Panel1","is-visible=true")
				winset(src,"Panel2","is-visible=true")
				winset(src,"Panel3","is-visible=true")
				winset(src,"Panel4","is-visible=true")
			else if(N == 4)
				winset(usr,"map1","size=960x640")
				winset(usr,"map1","pos=320,0")
				client.view="30x20"
				winset(src,"Panel1","is-visible=true")
				winset(src,"Panel2","is-visible=true")
				winset(src,"Panel3","is-visible=false")
				winset(src,"Panel4","is-visible=false")

	proc
		MacMes(MT="Mac",MSG,Dude)
			src << output(list2params(list(MT,MSG,Dude)),"Panel1:AddChat")
			src << output(list2params(list(MT,MSG,Dude)),"Panel2:AddChat")
			src << output(list2params(list(MT,MSG,Dude)),"Panel3:AddChat")
			src << output(list2params(list(MT,MSG,Dude)),"Panel4:AddChat")
		HTMLChatPanel(SInte,SPage,WPAN,STab)
			var
				PanelHTML
				list/Panel = UIColour["Panel[WPAN]"]

			/*var/Stats1,Stats2
			for(var/B in vars)
				if(istype(vars[B],/Stat))
					var/Stat/A=vars[B]
					if(!(A.Name == "Health"||A.Name == "Stamina"||A.Name == "Chakra"||A.Name == "Level"))
						/*if(A.Name=="Willpower"||A.Name=="Reflexes"||A.Name=="Spear"||A.Name=="Attack Speed")
							Stats2 += \
							{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current]</span></div><br>"}
						else*/
						Stats2 += \
						{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current]</span></div>"}
					else if(A.Name != "Level")
						Stats1 += \
						{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current] / [A.Max]</span></div>"}
*/
			PanelHTML={"
			<!DOCTYPE html>
<html>
	<head>
		<title>Blah</title>
		<meta http-equiv="x-ua-compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="Creator" content="JMV">
		<style type="text/css">
			[StyleGenerate(WPAN)]
		</style>
		<script type="text/javascript">
			[JavaGenerate(WPAN)]
		</script>
	</head>
	<body onclick="HideContext()">
		<div id="PageInd"></div>
		<div id="PanelNum">[WPAN]</div>
		<div id="Tabs">
			<button class="TButs" id="SHTab" style="display:none;" onclick="this.nextElementSibling.removeAttribute('style'),this.style.display='none',document.getElementById('Cont1').style.top='26px'">+</button>
			<div>
				<button class="TButs" id="HITab" onclick="HideThis(this.parentNode),document.getElementById('SHTab').style.display='inline',document.getElementById('Cont1').style.top='0px'">-</button>
				<button class="TButs" id="TabSel" onclick="HideThis(this.nextElementSibling)">&#9881;</button>
				<div id="TabSelB" style="display:none;">
					<button class="TapTOG" id="TPop" onclick="PopThis()">Pop Out</button>
					<button class="TabTOG" id="" onclick="SwitchPage('ChatBox')">Chat</button>
					<button class="TabTOG" id="" onclick="SwitchPage('GameBox')">Game</button>
					<button class="TabTOG" id="" onclick="SwitchPage('SetBox')">Setting</button>
				</div>
				<div id="ChatTab" class="Header" style="display:none;" >
					<div id="ChatInd"></div>
					<div class="TButs" onclick="SetThis('OOC')"><span>OOC</span></div>
					<div class="TButs" onclick="SetThis('Gam')"><span>Game</span></div>
					<div class="TButs" onclick="SetThis('Gui')"><span>Guild</span></div>
					<div class="TButs" onclick="SetThis('Vil')"><span>Village</span></div>
					<div class="TButs" id="PrivO" onclick="SetThis('Pri')"><span class="PNote1" style="display:none;">0</span><span>Private</span></div>
					<div class="TButs" id="POpts" style="display:none;" onclick="HideThis(this.nextElementSibling)"><span class="PNote1" style="display:none;">0</span><span>Player</span></div>
					<div id="PrivSet" data-Player="All" style="display:none;">
						<div class="PTogs" data-Player="All" onclick="SwitchPriv(this)"><span class="PNote">0</span>All<button class="PClose" onclick="CloseChat(this)">x</button></div>
						<div class="PTogs" data-Player="Fry" onclick="SwitchPriv(this)"><span class="PNote">0</span>Fry<button class="PClose" onclick="CloseChat(this)">x</button></div>
						<div class="PTogs" data-Player="Frank" onclick="SwitchPriv(this)"><span class="PNote">0</span>Frank<button class="PClose" onclick="CloseChat(this)">x</button></div>
						<div class="PTogs" data-Player="Hairy" onclick="SwitchPriv(this)"><span class="PNote">0</span>Hairy<button class="PClose" onclick="CloseChat(this)">x</button></div>
						<div class="PTogs" data-Player="Peter" onclick="SwitchPriv(this)"><span class="PNote">0</span>Peter<button class="PClose" onclick="CloseChat(this)">x</button></div>
					</div>
					<div class="TButs" onclick="SetThis('Adm')"><span>Admin</span></div>
					<div class="TButs" id="CustO" onclick="SetCust()"><span>Custom</span></div>
					<div class="TButs" id="COpts" style="display:none;" onclick="HideThis(this.nextElementSibling)"><span>Option</span></div>
					<div id="ChatSet" style="display:none;">
						<button class="CTogs" id="TOOC" data-Toggled="true" onclick="ToggleMe(this,'OOC')">OOC</button>
						<button class="CTogs" id="TSay" data-Toggled="true" onclick="ToggleMe(this,'Say')">Say</button>
						<button class="CTogs" id="TVil" data-Toggled="true" onclick="ToggleMe(this,'Vil')">Village</button>
						<button class="CTogs" id="TGui" data-Toggled="true" onclick="ToggleMe(this,'Gui')">Guild</button>
						<button class="CTogs" id="TPri" data-Toggled="true" onclick="ToggleMe(this,'Pri')">Private</button>
						<button class="CTogs" id="TAdm" data-Toggled="true" onclick="ToggleMe(this,'Adm')">Admin</button>
						<button class="CTogs" id="TDam" data-Toggled="true" onclick="ToggleMe(this,'Dam')">Damage</button>
						<button class="CTogs" id="TGai" data-Toggled="true" onclick="ToggleMe(this,'Gai')">Gains</button>
						<button class="CTogs" id="TMac" data-Toggled="true" onclick="ToggleMe(this,'Mac')">Machine</button>
						<button class="CTogs" id="TAnn" data-Toggled="true" onclick="ToggleMe(this,'Ann')">Announce</button>
					</div>
				</div>
				<div id="GameTab" class="Header" style="display:none;">
					<div class="TButs" onclick="SwitchGameTab('StatsPage')">Stats</div>
					<div class="TButs" onclick="SwitchGameTab('ItemPage')">Items</div>
					<div class="TButs" onclick="SwitchGameTab('TechPage')">Techs</div>
					<div class="TButs" onclick="SwitchGameTab('VerbPage')">Verb</div>
					<div class="TButs" onclick="SwitchGameTab('GuildPage')">Guild</div>
					<div class="TButs" onclick="SwitchGameTab('AdminPage')">Admin</div>
				</div>
				<div id="SetTab" class="Header" style="display:none;">
					<div class="TButs" onclick="SwitchSetTab('ChatSetts')">Chat</div>
					<div class="TButs" onclick="SwitchSetTab('ColoSetts')">Colour</div>
					<div class="TButs" onclick="SwitchSetTab('PlaySetts')">Player</div>
					<div class="TButs" onclick="SwitchSetTab('GameSetts')">Game</div>
					<div class="TButs" onclick="SwitchSetTab('ServSetts')">Server</div>
				</div>
			</div>
		</div>
		<div id="Cont1">
			<div id="ChatBox" class="Page" style="display:none;">
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message 1</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message 2</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Say"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> says: <span class="MSG">Message</span></div>
				<div class="OOC">(<span class="GuildName">TFS</span>) <div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>: <span class="MSG">Message</span></div>
				<div class="OOC">(<span class="GuildName">TFS</span>) <div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>: <span class="MSG">Message</span></div>
				<div class="Say"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> says: <span class="MSG">Message</span></div>
				<div class="Vil"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>: <span class="MSG">Message</span></div>
				<div class="Gui">{<span class="GuiTitle">Captain</span>} <div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Adm"><font style="color:#FFFF00;">*</font><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>: <span class="MSG">Message</span></div>
				<div class="Dam"><span class="MSG">You did 100 damage to Frank</span></div>
				<div class="Gai"><span class="MSG">Your Strength has increased by 1</span></div>
				<div class="Ann"><span class="MSG">* game will go down in 5 minutes *</span></div>
				<div class="Mac"><span class="Login"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div>/Screwyparasite has logged in!</span></div>
				<div class="Mac"><span class="Logout">Fry/Screwyparasite has logged in!</span></div>
				<div class="Mac"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> has beaten <div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank</div> in the arena!</div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Fry" oncontextmenu="ContextME(this)">Fry<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Frank" oncontextmenu="ContextME(this)">Frank<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Hairy" oncontextmenu="ContextME(this)">Hairy<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
				<div class="Pri"><div onclick='' class="PlayerName" data-Player="Peter" oncontextmenu="ContextME(this)">Peter<div class="PlayerBox"><button>Whisper</button><button>Inspect</button></div></div> whsipers: <span class="MSG">Message</span></div>
			</div>
			<div id="GameBox" class="Page" style="display:none;">
				<div id="GameInd"></div>
				<div class="GamePage" id="StatsPage">
					<div class="StCont" id="BasicInfo">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Basic Info</button>
						<div>
							<span class="PPStat" id="PName"><span class="StName" id="Name1">[Name1]</span> <span class="StName" id="Clan">[Clan]</span> <span class="StName" id="Alias">[Alias]</span></span>
							<span class="PPStat" id="PRank"><span class="StName" id="Rank">[Rank]</span> of the <span class="StName" id="Village">[Village]</span></span>
							<span class="PPStat" id="PLevel"><span class="StName">Level:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Level">[Level.Current]</span></span>
							<span class="PPStat" id="PYen"><span class="StName">Yen:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Yen">[Yen]</span></span>
							<span class="PPStat" id="PProfession"><span class="StName">Profession:</span><span class="StDesc">Description Here</span><span class="StEntr" id="ZWord">[Profession]</span></span>
							<span class="PPStat" id="PZWord"><span class="StName">Location:</span><span class="StDesc">Description Here</span><span class="StEntr" id="ZWord">[ZWord]</span></span>
						</div>
					</div>
					<div class="StCont" id="PrimaryStats">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Primary Stats</button>
						<div>
							<span class="PPStat" id="PHealth"><span class="StName">Health:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Health">[Health.Current] / [Health.Max]</span></span>
							<span class="PPStat" id="PStamina"><span class="StName">Stamina:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Stamina">[Stamina.Current] / [Stamina.Max]</span></span>
							<span class="PPStat" id="PChakra"><span class="StName">Chakra:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Chakra">[Chakra.Current] / [Chakra.Max]</span></span>
							<br />
							<span class="PPStat" id="PTaijutsu"><span class="StName">Taijutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Taijutsu">[Taijutsu.Current]</span></span>
							<span class="PPStat" id="PNinjutsu"><span class="StName">Ninjutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Ninjutsu">[Ninjutsu.Current]</span></span>
							<span class="PPStat" id="PGenjutsu"><span class="StName">Genjutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Genjutsu">[Genjutsu.Current]</span></span>
							<br />
							<span class="PPStat" id="PBugCount" style="display:none;"><span class="StName">Bugs:</span><span class="StDesc">Description Here</span><span class="StEntr" id="BugCount">[BugCount]</span></span>
							<span class="PPStat" id="PSandCollected" style="display:none;"><span class="StName">Sand:</span><span class="StDesc">Description Here</span><span class="StEntr" id="SandCollected">[SandCollected] / [SandMax]</span></span>
							<span class="PPStat" id="PInSharingan" style="display:none;"><span class="StName">Sharingan:</span><span class="StDesc">Description Here</span><span class="StEntr" id="InSharingan">[InSharingan]</span></span>
							<span class="PPStat" id="PInGate" style="display:none;"><span class="StName">Gate:</span><span class="StDesc">Description Here</span><span class="StEntr" id="InGate">[InGate] / [CanGate]</span></span>
						</div>
					</div>
					<div class="StCont" id="SecondaryStats">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Secondary Stats</button>
						<div style="display:none;">
							<span class="PPStat" id="PChakra-Control"><span class="StName">Chakra Control:</span><span class="StDesc">Description Here</span><span class="StEntr" id="ChakraControl">[ChakraControl.Current]</span></span>
							<span class="PPStat" id="PSealSpeed"><span class="StName">Seal Speed:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Seal Speed">[SealSpeed.Current]</span></span>
							<span class="PPStat" id="PReflexes"><span class="StName">Reflexes:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Reflexes">[Reflexes.Current]</span></span>
							<span class="PPStat" id="PSpeed"><span class="StName">Speed:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Speed">[Speed.Current]</span></span>
							<br />
							<span class="PPStat" id="PCrafting"><span class="StName">Crafting:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Crafting Skill">[Crafting.Current]</span></span>
							<span class="PPStat" id="PMining"><span class="StName">Mining:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Mining Skill">[Mining.Current]</span></span>
							<span class="PPStat" id="PFirstAid"><span class="StName">First Aid:</span><span class="StDesc">Description Here</span><span class="StEntr" id="First Aid Skill">[FirstAid.Current]</span></span>
							<span class="PPStat" id="PFishing"><span class="StName">Fishing:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Fishing">[Fishing.Current]</span></span>
							<br />
							<span class="PPStat" id="PKnife"><span class="StName">Knife:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Knife">[Knife.Current]</span></span>
							<span class="PPStat" id="PSword"><span class="StName">Sword:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Sword">[Sword.Current]</span></span>
							<span class="PPStat" id="PPole"><span class="StName">Pole:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Pole">[Pole.Current]</span></span>
							<span class="PPStat" id="PFan"><span class="StName">Fan:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Fan">[Fan.Current]</span></span>
							<span class="PPStat" id="PShuriken"><span class="StName">Shuriken:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Shuriken">[Shuriken.Current]</span></span>
							<span class="PPStat" id="PSenbon"><span class="StName">Senbon:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Senbon">[Senbon.Current]</span></span>
							<span class="PPStat" id="PUnarmed"><span class="StName">Unarmed:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Unarmed">[Unarmed.Current]</span></span>
						</div>
					</div>
					<div class="StCont" id="ElementStats" style="display:none;">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Elements</button>
						<div style="display:none;">
							<span class="PEStat" style="display:none;" id="PEarth"><span class="StName">Earth:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Earth">[EarthElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PFire"><span class="StName">Fire:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Fire">[FireElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PLightning"><span class="StName">Lightning:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Lightning">[LightningElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PWater"><span class="StName">Water:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Water">[WaterElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PWind"><span class="StName">Wind:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Wind">[WindElement.Current]</span></span>
							<br />
							<span class="PEStat" style="display:none;" id="PLava"><span class="StName">Lava:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Lava">[LavaElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PExplosion"><span class="StName">Explosion:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Explosion">[ExplosionElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PWood"><span class="StName">Wood:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Wood">[WoodElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PMagnet"><span class="StName">Magnet:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Magnet">[MagnetElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PBlaze"><span class="StName">Blaze:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Blaze">[BlazeElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PBoil"><span class="StName">Boil:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Boil">[BoilElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PScorch"><span class="StName">Scorch:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Scorch">[ScorchElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PStorm"><span class="StName">Storm:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Storm">[StormElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PSwift"><span class="StName">Swift:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Swift">[SwiftElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PGale"><span class="StName">Gale:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Gale">[GaleElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PSand"><span class="StName">Sand:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Sand">[SandElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PParticle"><span class="StName">Particle:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Particle">[ParticleElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PYin"><span class="StName">Yin:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Yin">[YinElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PYang"><span class="StName">Yang:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Yang">[YangElement.Current]</span></span>
							<span class="PEStat" style="display:none;" id="PNature"><span class="StName">Nature:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Nature">[NatureElement.Current]</span></span>
						</div>
					</div>
					<div class="StCont" id="PetStats" style="display:none;">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Pet</button>
						<div style="display:none;">
							<span class="PPStat" id="DgHealth"><span class="StName">Health:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgHealth">Pet Health</span></span>
							<span class="PPStat" id="DgChakra"><span class="StName">Chakra:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgChakra">Pet Chakra</span></span>
							<span class="PPStat" id="DgStamina"><span class="StName">Stamina:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgStamina">Pet Stamina</span></span>
							<br />
							<span class="PPStat" id="DgNinjutsu"><span class="StName">Ninjutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgNinjutsu">Pet Ninjutsu</span></span>
							<span class="PPStat" id="DgTaijutsu"><span class="StName">Taijutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgTaijutsu">Pet Taijutsu</span></span>
							<span class="PPStat" id="DgGenjutsu"><span class="StName">Genjutsu:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgGenjutsu">Pet Genjutsu</span></span>
							<span class="PPStat" id="DgSpeed"><span class="StName">Speed:</span><span class="StDesc">Description Here</span><span class="StEntr" id="DgSpeed">Pet Speed</span></span>
						</div>
					</div>
					<div class="StCont" id="MissionStats">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Mission</button>
						<div style="display:none;">
							<span class="PPStat" id="PMSrank"><span class="StName">S:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Smissions">[Missions["S"]]</span></span>
							<span class="PPStat" id="PMArank"><span class="StName">A:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Amissions">[Missions["A"]]</span></span>
							<span class="PPStat" id="PBMrank"><span class="StName">B:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Bmissions">[Missions["B"]]</span></span>
							<span class="PPStat" id="PMCrank"><span class="StName">C:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Cmissions">[Missions["C"]]</span></span>
							<span class="PPStat" id="PMDrank"><span class="StName">D:</span><span class="StDesc">Description Here</span><span class="StEntr" id="Dmissions">[Missions["D"]]</span></span>
						</div>
					</div>
				</div>
				[HTMLITEMGEN()]
				<div class="GamePage" id="VerbPage" style="display:none;">
					<div class="StCont" id="VerbTab">
					</div>
				</div>
				<div class="GamePage" id="GuildPage" style="display:none;">
					<span id="GuName">\[GuName]</span>
					<img class="Image" id="GuImg" src="">
					<div id="GuInfo">
						<span>value</span>
					</div>
					<div id="GuVerbs">
						<button class="Verb1">\[Verbs]</button>
						<button class="Verb2">\[Verbs]</button>
						<button class="Verb1">\[Verbs]</button>
						<button class="Verb2">\[Verbs]</button>
					</div>
				</div>
				<div class="GamePage" id="AdminPage" style="display:none;">
					<div class="StCont" id="AdminTab">
							<button class='Verb1'>Kick</button>
							<button class='Verb2'>Mute</button>
							<button class='Verb1'>Announce</button>
							<button class='Verb2'>Admin Chat</button>
							<button class='Verb1'>Who</button>
							<button class='Verb2'>Save World</button>
							<button class='Verb1'>Reboot</button>
							<button class='Verb2'>Shutdown</button>
					</div>
				</div>

				<div id="InfoPanel" style="display:none;">
					<div>
						<button id="InfoClose" onclick="InfoClose()">x</button>
						<span id="ObName">\[ObName]</span>
						<img class="Image" id="InfoImg" src="">
						<div id="ObInfo">
							<span>value</span>
						</div>
						<div id="ObjVerbs">
							<button class="Verb1">\[Verbs]</button>
							<button class="Verb2">\[Verbs]</button>
							<button class="Verb1">\[Verbs]</button>
							<button class="Verb2">\[Verbs]</button>
						</div>
					</div>
				</div>
			</div>
			<div id="SetBox" class="Page" style="display:none;">
				<div id="SettInd"></div>
				<div class="SettPage" id="ChatSetts" style="display:none;">
						<div id="Notify">
							<span>Notification:</span>
							<label for="NotiO">On</label><input type="radio" id="NotiO" name="Notify" checked="checked">
							<label for="NotiN">Off</label><input type="radio" id="NotiN" name="Notify">
						</div>
				</div>
				<div class="SettPage" id="ColoSetts">
						<button class="SaveSetButton" onclick="SaveColors()">Save</button>
						<button  id="HowToButton" onclick="HideThis(this.nextElementSibling)">How to</button>
						<div style="font-size:12px;display:none;">
							These colours support three modes, it can use Hex code, RGB, and RGBA.
							<p>
								<b>Hex code</b> these are the most common found online; they follow a 6 digit format after a hash tag (#) to look like this <b>#000000</b> this is black for example. Each colour is controlled in pairs, the first pair following the hash is Red, the next is Green, and the last pair is Blue.
								<br /><br />They scale from 00-FF, with 99 being the highest number followed by letters AA-FF; 00 being no color and FF being the most possible from the color. As an example #FF0000 would give me a bright red because the first two are both FF while the other pairs all have 00 to state there is no colour.

								<br /><br /> <b>RGB and RGBA</b> these are less common but provide better control with a bit more complexity available. when keying this in youll need to type it specifically as follows <b>RGB(000,000,000)</b> each number is in trios where the first zero is only important if you are going over 100.
								<br>the numbers all scale from 000-255 and follow the same format as hex codes in that the first trio is Red, second is Green, and the third is Blue. to follow the example from hex codes RGB(255,000,000) will give me bright red.
								<br><br>
								This is where the control comes in, When you usr RGBA you have an extra layer of control with transparency. To put it simply you can make to so you can see through your colour, this still follows the same formatting of RGB with the aditional Alpha number. <b>RGBA(000,000,000,1)</b> is how this would look for a flat black. the alpha works in decimals, as an example 0.5 is half and 0.25 is a quarter.
								Try using RGBA(255,000,000,0) and tell me if its red.
								<br /><br />
								Finally when finished rememebr to save your changes!
							</p>
						</div>
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Panels</button>
						<div>
							<span>Background:</span><input type="text" class="ColourInput" id="BGC" value="[Panel["BGC"]]" style="background:linear-gradient(-90deg, [Panel["BGC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["BGC"]]';};" onkeyup="SettColor(this);">
							<span>Tab Background:</span><input type="text" class="ColourInput" id="TBC" value="[Panel["TBC"]]" style="background:linear-gradient(-90deg, [Panel["TBC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["TBC"]]';};" onkeyup="SettColor(this);">
							<span>Verb Background:</span><input type="text" class="ColourInput" id="VBC" value="[Panel["VBC"]]" style="background:linear-gradient(-90deg, [Panel["VBC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["VBC"]]';};" onkeyup="SettColor(this);">
							<span>Head:</span><input type="text" class="ColourInput" id="HBC" value="[Panel["HBC"]]" style="background:linear-gradient(-90deg, [Panel["HBC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["HBC"]]';};" onkeyup="SettColor(this);">
							<span>Head Font:</span><input type="text" class="ColourInput" id="HFC" value="[Panel["HFC"]]" style="background:linear-gradient(-90deg, [Panel["HFC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["HFC"]]';};" onkeyup="SettColor(this);">
							<span>Highlight:</span><input type="text" class="ColourInput" id="HLC" value="[Panel["HLC"]]" style="background:linear-gradient(-90deg, [Panel["HLC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["HLC"]]';};" onkeyup="SettColor(this);">
							<span>Hover:</span><input type="text" class="ColourInput" id="HOC" value="[Panel["HOC"]]" style="background:linear-gradient(-90deg, [Panel["HOC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["HOC"]]';};" onkeyup="SettColor(this);">
							<span>Health:</span><input type="text" class="ColourInput" id="HEC" value="[Panel["HEC"]]" style="background:linear-gradient(-90deg, [Panel["HEC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["HEC"]]';};" onkeyup="SettColor(this);">
							<span>Stamina:</span><input type="text" class="ColourInput" id="STC" value="[Panel["STC"]]" style="background:linear-gradient(-90deg, [Panel["STC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["STC"]]';};" onkeyup="SettColor(this);">
							<span>Chakra:</span><input type="text" class="ColourInput" id="CHC" value="[Panel["CHC"]]" style="background:linear-gradient(-90deg, [Panel["CHC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["CHC"]]';};" onkeyup="SettColor(this);">
							<span>Base Text:</span><input type="text" class="ColourInput" id="BTC" value="[Panel["BTC"]]" style="background:linear-gradient(-90deg, [Panel["BTC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["BTC"]]';};" onkeyup="SettColor(this);">
						</div>
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Chat</button>
						<div>
							<span>OOC Message:</span><input type="text" class="ColourInput" id="OCOL" value="[Panel["OCOL"]]" style="background:linear-gradient(-90deg, [Panel["OCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["OCOL"]]';};" onkeyup="SettColor(this);">
							<span>OOC Name:</span><input type="text" class="ColourInput" id="OPCOL" value="[Panel["OPCOL"]]" style="background:linear-gradient(-90deg, [Panel["OPCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["OPCOL"]]';};" onkeyup="SettColor(this);">
							<span>Say Message:</span><input type="text" class="ColourInput" id="SCOL" value="[Panel["SCOL"]]" style="background:linear-gradient(-90deg, [Panel["SCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["SCOL"]]';};" onkeyup="SettColor(this);">
							<span>Say Name:</span><input type="text" class="ColourInput" id="SNCOL" value="[Panel["SNCOL"]]" style="background:linear-gradient(-90deg, [Panel["SNCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["SNCOL"]]';};" onkeyup="SettColor(this);">
							<span>Whisper Message:</span><input type="text" class="ColourInput" id="PCOL" value="[Panel["PCOL"]]" style="background:linear-gradient(-90deg, [Panel["PCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["PCOL"]]';};" onkeyup="SettColor(this);">
							<span>Whisper Name:</span><input type="text" class="ColourInput" id="PRNCOL" value="[Panel["PRNCOL"]]" style="background:linear-gradient(-90deg, [Panel["PRNCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["PRNCOL"]]';};" onkeyup="SettColor(this);">
							<span>Guild Message:</span><input type="text" class="ColourInput" id="GCOL" value="[Panel["GCOL"]]" style="background:linear-gradient(-90deg, [Panel["GCOL"]] 60%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["GCOL"]]';};" onkeyup="SettColor(this);">
							<span>Guild Name:</span><input type="text" class="ColourInput" id="GNCOL" value="[Panel["GNCOL"]]" style="background:linear-gradient(-90deg, [Panel["GNCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["GNCOL"]]';};" onkeyup="SettColor(this);">
							<span>Village Message:</span><input type="text" class="ColourInput" id="VCOL" value="[Panel["VCOL"]]" style="background:linear-gradient(-90deg, [Panel["VCOL"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["VCOL"]]';};" onkeyup="SettColor(this);">
							<span>Damage:</span><input type="text" class="ColourInput"id="DAC" value="[Panel["DAC"]]" style="background:linear-gradient(-90deg, [Panel["DAC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["DAC"]]';};" onkeyup="SettColor(this);">
							<span>Gains:</span><input type="text" class="ColourInput" id="GAC" value="[Panel["GAC"]]" style="background:linear-gradient(-90deg, [Panel["GAC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["GAC"]]';};" onkeyup="SettColor(this);">
							<span>Status:</span><input type="text" class="ColourInput" id="STAC" value="[Panel["STAC"]]" style="background:linear-gradient(-90deg, [Panel["STAC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["STAC"]]';};" onkeyup="SettColor(this);">
							<span>Login:</span><input type="text" class="ColourInput" id="LIC" value="[Panel["LIC"]]" style="background:linear-gradient(-90deg, [Panel["BGC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["LIC"]]';};" onkeyup="SettColor(this);">
							<span>Logout:</span><input type="text" class="ColourInput" id="LOC" value="[Panel["LOC"]]" style="background:linear-gradient(-90deg, [Panel["LOC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["LOC"]]';};" onkeyup="SettColor(this);">
							<span>Player Name:</span><input type="text" class="ColourInput" id="PNC" value="[Panel["PNC"]]" style="background:linear-gradient(-90deg, [Panel["PNC"]] 30%, #111111 90%)" onblur="if(this.value==''){this.value='[Panel["PNC"]]';};" onkeyup="SettColor(this);">
						</div>
				</div>
				<div class="SettPage" id="PlaySetts" style="display:none;">
						<div id="Notify">
							<span>Player:</span>
							<label for="NotiO">On</label><input type="radio" id="NotiO" name="Notify" checked="checked">
							<label for="NotiN">Off</label><input type="radio" id="NotiN" name="Notify">
						</div>
				</div>
				<div class="SettPage" id="GameSetts" style="display:none;">
						<div id="Notify">
							<span>Game:</span>
							<label for="NotiO">On</label><input type="radio" id="NotiO" name="Gamey" checked="checked">
							<label for="NotiN">Off</label><input type="radio" id="NotiN" name="Gamey">
						</div>
				</div>
				<div class="SettPage" id="ServSetts" style="display:none;">
						<div id="Notify">
							<span>Server:</span>
							<label for="NotiO">On</label><input type="radio" id="NotiO" name="Notify" checked="checked">
							<label for="NotiN">Off</label><input type="radio" id="NotiN" name="Notify">
						</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			document.addEventListener("contextmenu", function (e) {
			//	e.preventDefault();
			}, false);
			window.onload = BottomBoy(),LoadPage("[SInte]","[SPage]","[STab]"),Unhide("[Clan]");
			//window.onload = BottomBoy(),LoadPage("Game","StatsPage","[STab]"),Unhide("[Clan]");
		</script>
	</body>
</html>
			"}
			//HTMLChatPanel(SInte,SPage,WPAN,STab)
			src << browse(PanelHTML,"Window=Panel[WPAN];")
			//winset(src,"Panel[WPAN]","is-visible=true")