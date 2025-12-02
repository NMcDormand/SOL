mob
	verb
		DisplayLargeStats()
			usr.ShowLargeStats()
		listelements()
			var/Emsg = ""
			var/Smsg = ""
			for(var/A in vars)
				if(findtext(A,"Elemental"))
					var/B = replacetext(A, "Elemental", "")
					Emsg += "\"[B]\" = vars\[\"[A]\"\],"
				else if(findtext(A,"Skill") && !(findtext(A,"True")||findtext(A,"XP")||findtext(A,"Current")||findtext(A,"Seed")||findtext(A,"Boss")||findtext(A,"Time")||findtext(A,"Clay")))
					var/B = replacetext(A, "Skill", "")
					Smsg += "\"[B]\" = vars\[\"[A]\"\],"
			src <<"Elements<br>[Emsg]<br>"
			src <<"Skills<br>[Smsg]<br>"
	proc
		ShowLargeStats(var/mob/M = src)
			set category="Z"
			var
				list
					Primary = list("Stamina" = "[Stamina] / [StaminaMax]", "Chakra" = "[Chakra] / [ChakraMax]", "Wounds" = Wounds, "Taijutsu" = Taijutsu, "NinJutsu" = Ninjutsu, "Genjutsu" = Genjutsu)

					Elements = list(
						"Fire" = FireElemental,"Water" = WaterElemental,"Lightning" = LightningElemental,"Earth" = EarthElemental,"Wind" = WindElemental,
						"Lava" = LavaElemental,"Explosion" = ExplosionElemental,"Wood" = WoodElemental,"Magnet" = MagnetElemental,"Blaze" = BlazeElemental,"Boil" = BoilElemental,
						"Scorch" = ScorchElemental,"Storm" = StormElemental,"Swift" = SwiftElemental,"Gale" = GaleElemental,"Ice" = IceElemental,"Sand" = SandElemental,
						"Particle" = ParticleElemental,"Yin" = YinElemental,"Yang" = YangElemental
					)

					Weapons = list(
						"Knife" = KnifeSkill,"Throwing" = ThrowingSkill,"Sword" = SwordSkill,"Staff" = StaffSkill,"Fan" = FanSkill,"Axe" = AxeSkill,"Scythe" = ScytheSkill,
						"H2H" = H2HSkill
					)

					Secondary = list("Chakra-Control" = ChakraControl, "Fishing" = FishingSkill,"First-Aid" = FirstAidSkill,"Mining" = MiningSkill,"Crafting" = CraftingSkill)

					Professions = list("Clay-Skill" = ClaySkill,"Sand-Colleted" = ClaySkill)


				PrimaryStats
				SecondaryStats
				ElementStats
				WeaponStats
				ProfessionStats
				//Break=0
			for(var/A in Primary)
				if(Primary[A])
					PrimaryStats += {"
						<div onfocus="ReFocus()" class="PPStat" id="My[A]"><span onfocus="ReFocus()" class="StName">[A]:</span><span onfocus="ReFocus()" class="StEntr" id="[A]">[Primary[A]]</span></div>
					"}
			for(var/A in Secondary)
				if(Secondary[A])
					SecondaryStats += {"
						<div onfocus="ReFocus()" class="PPStat" id="My[A]"><span onfocus="ReFocus()" class="StName">[A]:</span><span onfocus="ReFocus()" class="StEntr" id="[A]">[Secondary[A]]</span></div>
					"}
			for(var/A in Elements)
				if(Elements[A])
					ElementStats += {"
						<div onfocus="ReFocus()" class="PPStat" id="My[A]"><span onfocus="ReFocus()" class="StName">[A]:</span><span onfocus="ReFocus()" class="StEntr" id="[A]">[Elements[A]]</span></div>
					"}
			for(var/A in Weapons)
				if(Weapons[A])
					WeaponStats += {"
						<div onfocus="ReFocus()" class="PPStat" id="My[A]"><span onfocus="ReFocus()" class="StName">[A]:</span><span onfocus="ReFocus()" class="StEntr" id="[A]">[Weapons[A]]</span></div>
					"}
			for(var/A in Professions)
				if(Class[A])
					ProfessionStats += {"
						<div onfocus="ReFocus()" class="PPStat" id="My[A]"><span onfocus="ReFocus()" class="StName">[A]:</span><span onfocus="ReFocus()" class="StEntr" id="[A]">[Professions[A]]</span></div>
					"}
			if(ProfessionStats)
				ProfessionStats = {"
					<div onfocus="ReFocus()" class="StCont" id="ProfessionStats">
						<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Class Stats</button>
						<div onfocus="ReFocus()" style="display:none;">
							[ProfessionStats]
						</div>
					</div>
				"}

			var/HTML={"<html>
						<head>
							<title>[trueName]'s Stats</title>
							<meta http-equiv="x-ua-compatible" content="IE=edge">
							<meta name="viewport" content="width=device-width, initial-scale=1.0">
							<meta name="Creator" content="JMV">
						</head>
						<style type="text/css">
							body {
								background:#707070;color:#CC1100;
								margin:0px;padding:0px;
								font-family:calibri;
								width:99%;max-width:640px;

								scrollbar-base-color: #000;
								scrollbar-face-color: #555;
								scrollbar-highlight-color: #000;
								scrollbar-track-color: #2A2A2A;
								scrollbar-arrow-color: #444;
								scrollbar-shadow-color: #2A2A2A;
							}

							button {cursor:pointer;}
							div span:hover,button:hover{color:#FF6D00;}
							#RedLine{position:fixed;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}

							.StCont {
								background:#FFFFFF;
								color:#CC1100;
								text-align:center;
								font-size:10px;
								font-weight:700;
								margin-bottom:4px;
							}

							.StatBut {
								width:100%;
								background:#303030;
								outline:none;
								font-weight:bold;
								border:0px;
								color:#FEFEFE;
								height:20px;
								font-size:10px;
								text-align:left;
								text-indent:34px;
							}

							.GamePage > .StCont {
								font-size:0px;
							}
							.GamePage > .StCont > div span{
								font-size:12px;
							}
							.NameStat .StName{
								position:relative;
								font-size: 16px;
								color:#313131;
							}

							.PPStat, .NameStat{
								display:block;
								position:relative;
								width:100%;
								margin:0px auto;
								padding:4px 0px;
							}

							.StName	{
								position:absolute;
								left:0px;
								width:100px;
								text-align:right;
							}
							#TrueName, #Alias, #Clan, #Rank, #Village {
								position:relative;
							}
							#BasicInfo .StEntr {
								position:relative;
								left:20px;
							}
							.StEntr {
								position:relative;
								left:30px;
								color:#313131;
							}

							#Stamina {
								Color:#40AA40;
							}
							#Chakra	{
								Color:#4040EE;
							}
						</style>
						<script type="text/javascript">
							function DispDesc(el){
								var inner = el.lastChild;
								if (inner.style.display == "none"){inner.style.display = "";}
								else{inner.style.display = "none";}
							}
							function HideThis(el,el2){
								if(el.style.display != "none"){
									el.style.display="none";
									//el.style.zIndex="0";
								}else{
									el.style.display="";
								}
								ReFocus();
							}
							function ReFocus(){
								window.location = "byond://winset?id=MainMap&focus=true";
							}
						</script>
						<body>
							<div onfocus="ReFocus()" class="StCont" id="BasicInfo">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling);">Profile</button>
								<div onfocus="ReFocus()">
									<div onfocus="ReFocus()" class="NameStat" id="PName"><span onfocus="ReFocus()" class="StName" id="trueName">[trueName] the [NinjaRank]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PLevel"><span onfocus="ReFocus()" class="StName">Level:</span><span onfocus="ReFocus()" class="StEntr" id="Level">[Level]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PZWord"><span onfocus="ReFocus()" class="StName">Location:</span><span onfocus="ReFocus()" class="StEntr" id="ZCoord">[ZCoord]</span></div>
								</div>
							</div>
							<div onfocus="ReFocus()" class="StCont" id="PrimaryStats">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Primary Stats</button>
								<div onfocus="ReFocus()">
									[PrimaryStats]
								</div>
							</div>
							<div onfocus="ReFocus()" class="StCont" id="SecondaryStats">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Basic Skills</button>
								<div onfocus="ReFocus()">
									[SecondaryStats]
								</div>
							</div>
							<div onfocus="ReFocus()" class="StCont" id="ElementStats">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Element Stats</button>
								<div onfocus="ReFocus()" style="display:none;">
									[ElementStats]
								</div>
							</div>
							<div onfocus="ReFocus()" class="StCont" id="WeaponStats">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Combat Skills</button>
								<div onfocus="ReFocus()" style="display:none;">
									[WeaponStats]
								</div>
							</div>
							[ProfessionStats]
							<div onfocus="ReFocus()" class="StCont" id="MissionStats">
								<button class="StatBut" onclick="HideThis(this.nextElementSibling)">Mission</button>
								<div onfocus="ReFocus()" style="display:none;">
									<div onfocus="ReFocus()" class="PPStat" id="PMMPoints"><span onfocus="ReFocus()" class="StName">Mission Points:</span><span onfocus="ReFocus()" class="StEntr" id="MPoints">[MissionPoints]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PMSrank"><span onfocus="ReFocus()" class="StName">S:</span><span onfocus="ReFocus()" class="StEntr" id="Smissions">[MissionsComplete["S"]]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PMArank"><span onfocus="ReFocus()" class="StName">A:</span><span onfocus="ReFocus()" class="StEntr" id="Amissions">[MissionsComplete["A"]]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PBMrank"><span onfocus="ReFocus()" class="StName">B:</span><span onfocus="ReFocus()" class="StEntr" id="Bmissions">[MissionsComplete["B"]]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PMCrank"><span onfocus="ReFocus()" class="StName">C:</span><span onfocus="ReFocus()" class="StEntr" id="Cmissions">[MissionsComplete["C"]]</span></div>
									<div onfocus="ReFocus()" class="PPStat" id="PMDrank"><span onfocus="ReFocus()" class="StName">D:</span><span onfocus="ReFocus()" class="StEntr" id="Dmissions">[MissionsComplete["D"]]</span></div>
								</div>
							</div>
							<div onfocus="ReFocus()" id="RedLine"></div>
						</body>
						</html>"}
			M<<browse(HTML,"window=Browser[trueName];size=600x400")