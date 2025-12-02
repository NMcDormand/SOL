mob/proc/StartGame()
	if(!MasterPlayerList) MasterPlayerList=new()
	if(!(src in MasterPlayerList)) MasterPlayerList+=src
	NameArchive()
	protect=1
	loc = locate(21,58,2); ZCoord="Ninja Academy"; ZCoordProc(ZCoord)
	gold=500
	new/obj/Clothing/Feet/Sandals(src); new/obj/Clothing/Pants/Pants(src)
	switch(Village)
		if("Rock") new/obj/Clothing/Shirt/RockShirt(src)
		if("Leaf") new/obj/Clothing/Shirt/LeafShirt(src)
		if("Grass") new/obj/Clothing/Shirt/GrassShirt(src)
		if("Cloud") new/obj/Clothing/Shirt/CloudShirt(src)
		if("Rain") new/obj/Clothing/Shirt/RainShirt(src)
		if("Sound") new/obj/Clothing/Shirt/SoundShirt(src)
		if("Mist") new/obj/Clothing/Shirt/MistShirt(src)
		if("Waterfall") new/obj/Clothing/Shirt/WaterfallShirt(src)
		if("Sand") new/obj/Clothing/Shirt/SandShirt(src)
	//clothes as objs only abover here
	for(var/obj/Clothing/O in src)
		if(!O.Overlay)
			O.Overlay = new/Overlay_Obj(O.icon,O.layer)
			O.worn=1
			O.suffix="Equipped"
			if(O.mask)
				//name = "???"
				wearingMask=1
				//maptext = "<center><B>???</B></center>"
	//no clothes below this point
	new/obj/PlaceHolder(src)
	spawn(10) AssignSkills()
	LoadSkin()
	//if(client.IsByondMember()) verbs += new/mob/VerbHolder/Jutsu/Gen/verb/OboroBunshinnoJutsu() // This is the old bunshin!
	//verbs += typesof(/mob/VerbHolder/verb)
	verbs += typesof(/mob/VerbHolder/Guild/NonMember/verb)
	loggedin=1

	var/firstletter=copytext(ckey, 1, 2)
	if(fexists("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav"))
		var/savefile/RB = new("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav")
		RB["REData"] >> RebirthData
		src<<"Rebirth Amount: [RebirthData.Total]";
		spawn(10)
			RebirthData.Birthed(src)
		if(RB["CSBites"])
			RB["CSBites"] >> OroBittenTimes
		if(RB["PlayerKills"])
			RB["PlayerKills"] >> PlayerKills
		if(RB["VillageKills"])
			RB["VillageKills"] >> VillageKills
		if(RB["CriminalKills"])
			RB["CriminalKills"] >> CriminalKills
		if(RB["AnimalKills"])
			RB["AnimalKills"] >> AnimalKills
		if(RB["LargeAnimalKills"])
			RB["LargeAnimalKills"] >> LargeAnimalKills
		if(RB["TotalKills"])
			RB["TotalKills"] >> TotalKills
		if(prob(0.1))
			src<<"You feel an overwhelming amount of chakra build inside you, it's here. How do you use it though?";
			ChakraTrue=999999;
		world<<"<font color=green><b>[src]</b> is restarting in [Village]. Amount restarted: [RebirthData.Total]"
	else
		RebirthData = new(src)
		rulesAlert()
		world<<"<font color=green><b>[src]</b> has emerged in [Village]"

	UpdateInventory();
	StatUpdate_SelfImage()
	AssignElements();
	ProvideElements()
	WipeVersion=WorldVersion

	CreationSkin(1)

	if(SurveyList && SurveyList[ckey])
		SurveyLogin()

	spawn(600) PlayerOnlineTime()
	//FriendlyFire["village"]=1
	RefreshPlayerStats()
	PreLoadHotBar()
	CheckToggles()
	//gift()
	statboost() // Give a stat boost to the player on creation!
	RefreshStats()
	GMList()
	Set_Float()
	SV = WorldSaveVersion
	spawn(100) LoadHUD()
	ResetHotBar()

mob
	proc
		Set_Float()
			return
			switch(NinjaRank)
				if("Academy Student")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - AS</center>"
				if("Chuunin")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - C</center>"
				if("Special Joinin")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - SJ</center>"
				if("Anbu")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - A</center>"
				if("Jounin")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - J</center>"
				if("Kage Level")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - KL</center>"
				if("Missing Nin")
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - MN</center>"
				else
					maptext = "<center style=font-size:4pt;color:[VillageColour];>[Level] - K</center>"
			maptext_y = 16
var/Rules={"
<!DOCTYPE html>
<html>
<head>
<style>
body {font-family: 'Arial'; font-size: 10pt; background: #222; color: #c0c0c0; font-weight: Bold;}
	a {color: #0000ff; text-decoration: underline}
	a:visited {color: #ff00ff}
	img.icon {width: 16px; height: 16px;}
	li {margin:10px 10px;color:#ddd}
	dd {position:relative;left:20px;margin:5px 20px;color:#999;font-weight: normal;}
	b {color: #ff99ff;}
	div button
		{
			color: #999;
			margin: 10px 0px;
			background: #101010;
			font-weight: Bold;
			border: 0px;
			padding: 5px 5px;
			width:100%;
		}
div.container {
    width: 100%;
    border: 1px solid gray;
}

header, footer {
    padding: 1em;
    color: white;
    background-color: #0000ff;
    clear: left;
    text-align: center;
}

nav {
    float: left;
    max-width: 160px;
    margin: 0;
    padding: 1em;
}

nav ul {
    list-style-type: none;
    padding: 0;
}

nav ul a {
    text-decoration: none;
}

article {
    margin-left: 170px;
    border-left: 1px solid gray;
    padding: 1em;
    overflow: hidden;
}
</style>
</head>
<body>

<div class="container">

<header>
   <h1>Shinobi of Legend Rules</h1>
</header>

<nav>
  <ul>
    <li><a href="#GN">General Notice</a></li>
    <li><a href="#NR">Name Rules</a></li>
    <li><a href="#OR">OOC Rules</a></li>
    <li><a href="#CR">Camping</a></li>
    <li><a href="#GU">Guilds</a></li>
    <li><a href="#VK">Village Kage</a></li>
    <!--<li><a href="#AK">AFK Checks</a></li>-->
    <li><a href="#AB">Abuse</a></li>
    <li><a href="#GR">General Rules</a></li>
    <li><a href="#JL">Jailing</a></li>
    <li><a href="#GM">GM Rules</a></li>
    <li><a href="#EA">End Announcements</a></li>
  </ul>
</nav>

<article>
  <h1 id="GN">General Notice</h1>
  <p>Remember ignorance is no excuse, it is a players duty to read these rules and abide by them.</p>
  <p>Account sharing is not permitted and securing your account is your own responsibility.<br>
We will not reduce punishments for claims of someone else using your account, however true it may be.</p>
  <p>Just because a rule isn't listed here doesn't mean you can't be punished for it, common sense  is your best friend.</p>
</article>

<article>
  <h1 id="NR">Name Rules</h1>
  <p>Your name can not come, or contain one, from the Naruto manga, anime or video     game series.</p>
  <p>Naruto based surnames are not permitted.<br>
  <i>Bob is allowed, Uchiha Bob is not allowed.</i></p>
  <p>Your name must begin with a letter.</p>
  <p>You may have a maximum of 3 numbers or symbols in your name.</p>
  <p>You may not use the same name on more than one character.</p>
  <p>Differences in the same name are not permitted.<br>
  <i>Having two characters named Screwy and S.crewy or Screwy 2 is not   allowed</i></p>
  <p>You can use adjectives with your original name on a different Character.<br>
  <i>Super Fush and Fush</i></p>
  <p>Your name may not be entirely in capital letters, nor alternate capitals.    Subtle capital letters as a kind of 'accent' are acceptable.  GM discretion   applies.<br>
  <i>SuperFush is allowed, SuPeR FuSh or SUPER FUSH is not allowed</i></p>
  <p>Keep names appropriate, having foul language within your name as well as other     indecencies may lead to a rename.</p>
  <p>You are not permitted to use HTML code in your name</p>
</article>

<article>
	<h1 id="OR">OOC Rules</h1>
	<p>Mutes now work on a four strike system where each strike has a maximum and minimum sentence. Minimum sentences are one third of the maximum <br>
	<ul>
	<li>Mute sentences:</li>
	<li>Strike 1 = 10 Minutes</li>
	<li>Strike 2 = 20 Minutes</li>
	<li>Strike 3 = 30 Minutes</li>
	<li>Strike 4 = Ip Mute</li>
	</ul>
	Strikes will be cleared half an hour after your last mute has ended (gm discretion)</p>
	<ul>
		<li>Each offense earns you one strike, more than one offense in one sentence will earn multiple strikes</li>
		<li>If you quote someone else saying anything that breaks the below rules, expect a double punishment!</li>
		<li>Posting the same sentence, or topic, more than twice within a short span of   time.</li>
		<li>Using 5 or more capitals in a sentence, <b>with exception of correct   punctuation</b>.</li>
		<li>Excessive use of the same symbols and/or letters in one sentence.</li>
		<li>Avoiding the curse filters</li>
		<li>Harassing/Disrespecting a GM in OOC as a <b>direct result of punitive   action</b>.</li>
		<li>Repeated harassment of others.</li>
		<li>Discrimination based on race, gender, sexual orientation, ethnicity, demographic   etc.</li>
		<li>No asking or telling any requirements in OOC, this includes ranks, jutsus and   NPC locations. You are allowed to tell the req for water walking. (this includes   asking on ooc for a whisper, say, and/or buddy chat)</li>
		<li>Nagging (especially for handouts) GMs</li>
		<li>No pornographic images or video links in OOC or village say. Kids play this game after all.  First offense is 30 minutes,  Second will be an Ip mute</li>
		<li>Do not post links to other BYOND games more than once. I.P. mute for blatant spam. (unless it's in context of a conversation, GMs discretion of muting)</li>
		<li>Do not argue in OOC, if the arguement is that important take it to guild talk, village talk, or private chat.</li>
		<li>In the event of a topic in OOC getting out of hand, a GM reserves the right to mute the players involved and/or responsible; this is only to handle the situation and to calm the players involved, not a punishment.</li>
	</ul>

</article>

<article>
	<h1 id="CR">Camping Rules</h1>
	<ul>
		<li>You may not repeatedly kill a player leaving the hospital or safe zone, you may   wait for players who have ran from you into the safe zones or hospital.</li>
		<li>You may not camp the chuunin</li>
		<li>You may Camp the S5 mission squares and Itachi</li>
	</ul>
</article>

<article>
	<h1 id="GU">Guild Rules</h1>
	<ul>
	<li>Anything here may result in the denial or dismissal of a guild.</li>
	<li>No links, Strikes, Underlining</li>
	<li>Changing the font size is not allowed</li>
	<li>You are limited to 15 char length (at Gm discretion)</li>
	<li>Guild houses are no longer in the game, do not ask for one.</li>
	<li>Nobody may make a guild if it still exists, without the current leaders permission</li>
	<li>In the event of a player wanting permanent claim to a guild name, they are to submit a request to a gm</li>
	</ul>
</article>

<article>
<h1 id="AK">AFK Checks</h1>
<p>You may use an automated program or a macro to train, catch fish/garbage, or collect feathers/rocks while not at your computer.<br>
<i>Inattentively training and failing to comply with an AFK check will be considered AFK training, no excuses will be accepted</i><br>
<i>Using a macro lock is not permitted for a time longer than 1 minute.</i></p>

<p>When a GM checks you, you have 1 minute to respond or log out. The response must be on the character being checked, you are not allowed to respond on an alternate key</p>
<p>When a player AFK checks you, prepare to be subjected to a GM check (if you do not respond), it is up to a GM to decide if you purposely "wasted their time" if you respond to their AFK check (But not the player's)</p>

<p>Notes
<br>- If you are jailed and respond with an alt, after or during any afk check is done, you will still be jailed for the full time if you fail the check
<br>- If a high level admin catches you AFK training, they have the right to edit your stats back to base (aka 100 Stamina or 10 taijutsu)
</p>
<ul>
<li>First offense is 600 minutes.</li>
<li>Second offense is 1200 minutes.</li>
<li>Every subsequent offense is Infinite</li>
</ul>
each Strike has a maximum sentence
the minimum sentence is half that of the aforementioned maximum sentence</p>
</article>
<article>
	<h1 id="AB">Abuse</h1>
	<ul>
		<li>Being in the void.</li>
		<li>Being in the academy as a genin or higher.</li>
		<li>Exploiting the games programming.</li>
		<li>To Naras: You may not use any tai skills on your Kagemane Victim, you may not Create Kage Bunshins after you lock a victim in kagemane(this does not apply to raiton/mizu bunshin)</li>
		<li>You may not trade items with your alternative slots or keys, this extends to gold and anyother tradeable asset</li>
		<li>Alternative slots or keys are not allowed to interact in anyway with each other.</li>
	</ul>

	<ul>
		<li><i>This should pretty much be common sense. If you are unsure if Something is bug abuse, ask a GM if it isn't already posted in the forums. Don't complain to GMs if you get jailed for bug abuse when it's your responsibility to find out if it is abuse or not.</i></li>
		<li><b>Note to GMs from SPM -  Ignorance is no excuse as the rule says above.  But show leniency where it is genuinely clear that the player has made a reasonable mistake.</b></li>
	</ul>
	Some of these will Grant an instant infinite Jail
</article>

<article>
	<h1 id="GR">General Rules</h1>
	<ul>
		<li>Non-compliance with appopriate staff requests can be punished at the staff member's discretion.  Punishments must not be excessive.</li>

		<li>You are not allowed to log out If you are being chased and/or affected by another player's techniques. (Taijutsu, Ninjutsu, and Genjutsu all apply to this rule)</li>

		<li>Harassing a player through Say, or PM is unacceptable - Gm discretion whether to punish - minor punishment only</li>

		<li>"Farming" Rank kills will earn you a jail - Gm discretion - 1 warning will be given</li>
	</ul>
</article>

<article>
	<h1 id="JL">Jailing</h1>
	<p>Majority of breaches to these rules result in a Jail.</p>
	<p>The jail sentence follows a nearly identical strike system the mutes, they differ in that they are permanent as well as more severe.
	<br>
	Each Strike, once again, has a maximum sentence.
	the minimum sentence is half of the aforementioned maximum sentence.
	<br>
	Minor jail strikes
	<ul>
		<li>Strike 1 =  60 Minutes</li>
		<li>Strike 2 =  120 Minutes</li>
		<li>Strike 3 =  240 Minutes</li>
		<li>Strike 4 =  ect.</li>
	</ul>
	</p>
	<p>
	Each strike doubles the last strike's time.
	Jail Strikes are permanent and will never leave your player.
	<br>
	Major jail strikes
	<ul>
		<li>Strike 1 =  600 Minutes</li>
		<li>Strike 2 =  Brand</li>
		<li>Strike 3 =  Infinite time</li>
	</ul>
	</p>

	<p>For your jail time to expire you must be logged on that character, logging out will reset your jail time.
	Lastly, These are minor jails. For more severe breaches there are more severe jail times.</p>
</article>

<article>
  <h1 id="GM">GM Rules</h1>
<p>A GM may not admin themself. This includes alts.</p>

<p>A GM may not undo another GMs work unless they are of higher rank, and fully understand the reason for the initial act.</p>

<p>A GM must follow the same rules that players do</p>

<p>
Corollary: GMs are not entitled to respect/treatment above or beyond that expected towards a regular player.  Thus, it is not punishable for a player to "disrespect GMs".  However, it will be punishable if that disrespect/etc inhibits their ability to moderate the game.  This includes "disrespect" as a reaction to punitive measures taken (as above).<br>
It is the duty of the players to take up disputes respectfully, and it is the duty of the GMs to mirror that respect, be reasonable, and to listen to the other side.</p>
</article>

<article>
  <h1 id="EA">End Announcements</h1>
<p><b> Remember ignorance is no excuse, it is a players duty to read these rules and abide by them</b>
<b> All rules are subject to change at any time, although there may be a time difference between a rule being added or taken out because GMs are debating it</b>
<b> Some offenses can and will get your save wiped if it has gotten out of hand</b>
</article>

</div>

</body>
</html>

"}

mob/proc
	rulesAlert()
		switch(alert("Have you read the rules yet? \n\n Ignorance is not an excuse!",,"Yes","Read Rules"))
			if("Yes")
				readRules=1;
				alert("You can find the rules by clicking the '?' \n Make sure to check the rules from time to time.")
			if("Read Rules")
				//src << browse("<script>window.location='http://s4.zetaboards.com/Sol_Forum/topic/10052129/1/#new';</script>", "window=Check History;size=800x500")
				src << browse(Rules, "window=Check History;size=800x500")

	AssignSkills()
		new/obj/SkillCards/ActionButton(src); new/obj/SkillCards/ClimbTree(src)

		for(var/T in typesof(/obj/SkillCards/Ninjutsu/Starter/)-/obj/SkillCards/Ninjutsu/Starter/) new T(src)
		for(var/T in typesof(/obj/SkillCards/Genjutsu/Starter/)-/obj/SkillCards/Genjutsu/Starter/) new T(src)
		for(var/T in typesof(/obj/SkillCards/Taijutsu/Starter/)-/obj/SkillCards/Taijutsu/Starter/)
			new T(src)
		for(var/T in typesof(/obj/SkillCards/Starter/)-/obj/SkillCards/Starter/) new T(src)


	ProvideElements()
		//Add Element base
		/*switch(PE)
			if("Fire") FireElemental+=10
			if("Wind") WindElemental+10
			if("Water") WaterElemental+=10
			if("Earth") EarthElemental+=10
			if("Lightning") LightningElemental+=10
		switch(SE)
			if("Fire") FireElemental=10
			if("Wind") WindElemental=10
			if("Water") WaterElemental=10
			if("Earth") EarthElemental=10
			if("Lightning") LightningElemental=10*/
		vars["[PE]Elemental"] += 10
		vars["[SE]Elemental"] += 10

		//Add Village Bonus
		if((Village=="Rock"||Village=="Grass") && (PE=="Earth"||SE=="Earth"))
			EarthElemental+=100

		if((Village=="Sand"||Village=="Sound") && (PE=="Wind"||SE=="Wind"))
			WindElemental+=100

		if((Village=="Leaf") && (PE=="Fire"||SE=="Fire"))
			FireElemental+=100

		if((Village=="Cloud"||Village=="Rain") && (PE=="Lightning"||SE=="Lightning"))
			LightningElemental+=100

		if((Village=="Mist"||Village=="Waterfall") && (PE=="Water"||SE=="Water"))
			WaterElemental+=100

	newYearsGift()
		src<<output("<b>Happy New Year! Thank you for supporting SoM through to the next year, Have a fantastic 2021!</b>","Chat")
		src<<"<b>Check your inventory! Happy New Year!</b>"
		new/obj/Clothing/Over/Temari_Suit(src)

	statboost()
		if(!Player_Boost_Enabled) return
		Stamina=Player_Boost_Stamina; StaminaMax=Player_Boost_Stamina; StaminaTrue=Player_Boost_Stamina
		Chakra=Player_Boost_Chakra; ChakraMax=Player_Boost_Chakra; ChakraTrue=Player_Boost_Chakra
		//ChakraControl=50
		//SS=10
		Ninjutsu=Player_Boost_Ninjutsu; NinjutsuTrue=Player_Boost_Ninjutsu
		Genjutsu=Player_Boost_Genjutsu; GenjutsuTrue=Player_Boost_Genjutsu
		Taijutsu=Player_Boost_Taijutsu; TaijutsuTrue=Player_Boost_Taijutsu
		gold+=Player_Boost_Gold;
		src<<"<b>You have been given a stat boost.</b>"

	AssignElements()
		alert(src,"Your elemental alignment governs what elemental jutsus you are able to perform.  As your strength grows you will be able to perform elemental combination jutsu; so the combination of elements that you choose is also relatively important.  Note that your choice of village and/or clan may have predetermined all or part of your elemental choices.","Elemental Alignment")
		choosing = 1
		if(!PE)
			switch(input(src,"Please select your Primary Element before you continue","Primary Element Selection")in list("Water","Fire","Wind","Earth","Lightning"))
				if("Water") PE="Water"
				if("Fire") PE="Fire"
				if("Wind") PE="Wind"
				if("Earth") PE="Earth"
				if("Lightning") PE="Lightning"
		if(!SE)
			var/list/SE_List =list("Water","Fire","Wind","Earth","Lightning")
			SE_List-=PE
			SE = input(src,"Please select your Secondary Element before you continue.","Secondary Element Selection") in SE_List

		/*
		if(!SE)
			if(Village=="Rock")
				if(PE!="Earth") SE="Earth"
				else SESelect(PE)

			if(Village=="Leaf")
				if(PE!="Fire") SE="Fire"
				else SESelect(PE)

			if(Village=="Grass")
				SESelect(PE)

			if(Village=="Cloud")
				if(PE!="Lightning") SE="Lightning"
				else SESelect(PE)

			if(Village=="Rain")
				if(PE=="Water") SE="Lightning"
				else if(PE=="Lightning") SE="Water"
				else SE=pick("Water","Lightning")

			if(Village=="Sound")
				if(PE!="Wind") SE="Wind"
				else SESelect(PE)

			if(Village=="Mist")
				if(PE!="Water") SE="Water"
				else SESelect(PE)

			if(Village=="Waterfall")
				if(PE=="Water") SE="Lightning"
				else if(PE=="Lightning") SE="Water"
				else SE=pick("Water","Lightning")

			if(Village=="Sand")
				if(PE!="Wind") SE="Wind"
				else SESelect(PE)
		*/
		choosing = 0
