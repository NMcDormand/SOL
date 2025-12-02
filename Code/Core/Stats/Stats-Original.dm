world
	//fps = 50// 25 frames per second
	icon_size = 32 // 32x32 icon size by default
var/list/PID = list()
var/CID = 1

var
	TotalSavePrevention

var/list
	MasterPlayerList[]

atom/movable
	var
		TeamID = 0
		GuildID = 0
		PlayerID = 0
		tmp
			TempID = 0
			Overlay_Obj
				CMarker
				CPaths

mob
	step_size = 32
	invisibility = 6
	see_invisible = 7

	var/VillageChange
	var/tmp
		KageBunshinList[0]

	player
		invisibility = 7

	Cross(var/atom/movable/A)
		if(istype(A,/obj/Jutsu))
			var/obj/Jutsu/J = A
			var/mob/O = J.Owner
			if(!O)
				del J
				return
			if(O == src)
				return 1
			else if(IDCHECK(O,src))
				return 1
			else
				.=..()
		else
			.=..()

obj
	step_size = 32

mob/var
	noHenge=0; //For Admins Only
	readRules=0; //Has passed the rule check!

	tmp/list/DamagedMe = list()
	tmp/InCombat = 0
	VillageFriendly = 1

	Stamina=1; StaminaMax=1; StaminaTrue=1
	StaminaXP=1; StaminaMXP=100
	Wounds=0

	SharType = 0
	SharType2 = 0

	ByakType = 0
	RinnType = 0

	Chakra=1; ChakraMax=1; ChakraTrue=1
	ChakraXP=0; ChakraMXP=80

	ChakraControl=1; ChakraControlTrue=1; ChakraControlMax=0
	ChakraControlXP=1; ChakraControlMXP=100

	SS=18; SSTrue=18;
	SSXP=1; SSMXP=100

	Taijutsu=1; TaijutsuMax=1; TaijutsuTrue=1
	TaijutsuXP=1; TaijutsuMXP=100

	Ninjutsu=1; NinjutsuMax=1; NinjutsuTrue=1
	NinjutsuXP=1; NinjutsuMXP=100

	Genjutsu=1; GenjutsuMax=1; GenjutsuTrue=1
	GenjutsuXP=1; GenjutsuMXP=100

	PE; SE

	KO

	Reflex=1; ReflexTrue=1
	ReflexExp=0; ReflexMXP=600

	KnifeSkill=1; KnifeSkillTrue=1
	KnifeSkillXP=0; KnifeSkillMXP=10

	ThrowingSkill=1; ThrowingSkillTrue=1
	ThrowingSkillXP=0; ThrowingSkillMXP=10

	SwordSkill=1; SwordSkillTrue
	SwordSkillXP=0; SwordSkillMXP=10

	StaffSkill=1; StaffSkillTrue
	StaffSkillXP=0; StaffSkillMXP=10

	FanSkill=1; FanSkillTrue
	FanSkillXP=0; FanSkillMXP=10

	AxeSkill=1; AxeSkillTrue
	AxeSkillXP=0; AxeSkillMXP=10

	ScytheSkill=1; ScytheSkillTrue
	ScytheSkillXP=0; ScytheSkillMXP=10
	/*Skill=1; SkillTrue
	SkillXP=0; SkillMXP=10

	Skill=1; SkillTrue
	SkillXP=0; SkillMXP=10*/

	H2HSkill=1;  H2HSkillTrue=1
	H2HSkillXP=0; H2HSkillMXP=10
	H2HHits=0;

	FishingSkill=1; FishingSkillTrue=1
	FishingSkillXP=0; FishingSkillMXP=10

	FirstAidSkill=1; FirstAidSkillTrue=1
	FirstAidSkillXP=0; FirstAidSkillMXP=10

	tmp/IsMining = 0
	MiningSkill = 20; MiningSkillTrue = 20
	MiningSkillXP = 0; MiningSkillMXP = 10

	Elements = 0
	AdvancedElements = 0

	FireElemental=0
	WaterElemental=0
	LightningElemental=0
	EarthElemental=0
	WindElemental=0
//Advanced Elements
	LavaElemental = 0
	ExplosionElemental = 0
	WoodElemental = 0
	MagnetElemental = 0
	BlazeElemental = 0
	BoilElemental = 0
	ScorchElemental = 0
	StormElemental = 0
	SwiftElemental = 0
	GaleElemental = 0
	IceElemental = 0
	SandElemental = 0
	ParticleElemental = 0
	YinElemental = 0
	YangElemental = 0

	Level=1
	Exp=0; MXP=1000;

	gold=0; goldinbank=0; bankaccount=0

	Kills=0
	deaths=0; suicides=0;ratio=0

	PlayerKills = 0
	VillageKills = 0
	CriminalKills = 0
	CurCrimKills = 0

	AnimalKills = 0
	CurAnimKills = 0
	LargeAnimalKills = 0
	CurLAnimKills = 0
	TotalKills = 0
	BossKills = 0
	tmp/CurrentKills = 0

	movespeed=3
	setspeed=3
	Village
	Clan
	Speciality
	ZCoord="Logging In"
	InBuilding
	Cap_Stamina=2000;
	Cap_Chakra=400;
	Cap_Genjutsu=1000;
	Cap_Ninjutsu=1000;
	Cap_Taijutsu=1000

	//Easter Eggs :D
	rockLuck = 0;
	isZetsu = 0;
	Emoji = 0;

	// Back to normal
	InBoost = 0
	wielding=null
	wearingMask=0
	TreeStump
	storedShuriken
	VillageColour
	AQuestSP
	DeliverySP
	BB1SP
	FeathersSP
	GarbageSP
	CatSP
	SelfImage
	DeathMessages="all"
	CriminalHistory="Clean"
	screen_r=256
	screen_g=256
	screen_b=256
	redditMute=0
	respawn
	SRate

	jiraiya=0;
	cheater=0;
	muteTimes=0;
	jailTimes=0;
	RocksThrown
	Henge1Icon; Henge1Clothes=list(); Henge1Text;
	Henge2Icon; Henge2Clothes=list(); Henge2Text;
	Henge3Icon; Henge3Clothes=list(); Henge3Text;
	Slot1; Slot2; Slot3

	//Appearance
	IrisColour
	HairColour
	basename
	CurrentHair
	OriginalIcon
	CustomIcon = 0
	EyeIcon
	HairIcon

	//------------------
	/***Overlays***/
	hair=""
	//hairlist=list()
	Eyes=""

	tmp
		Aggressive = 0
		CantHenge
		HengeChoice
		TailList=list()
		target=""
		Kawarimi

		DamagedRecently
		TakenDamage
		UsingBandages=0
		SavePrevention
		BYONDMEMBER
		KOfrom
		AFK
		AlreadyOnWater
		Provoke[0]
		BandageUses
		fallen
		recentLogin
		loggedin
		whopause
		restdelay
		choosing
		hbDelay

//------------------
/***Jutsu Vars***/
	hasRasengan=0
	ChidoriUse=10
	RasenganUse=10
	ActiveChidoriUse
	ActiveRasenganUse
	BlockTarget = 0
	HasRinnegan=0;
	tmp
		Talking
		InKawarimi
		InSexy
		InHenge
		InMeiMei
		InByakugan
		InGarouga
		InJuujin
		InSoutourou
		InGatsuuga
		InTsuuga
		mob/VerbHolder/Admin/Creator
		freezer
		frozen
		mirroring
		inchidori
		inrasengan
		kaiten
		cantwater
		Bfollow
		Intangible
		SnakeBound

//------------------
/***Exam Vars***/
	tmp/TakingExam
	NinjaRank="Academy Student"
//------------------
/***Mod Stuff***/
	Rank
	screensize=9
	listenooc=1
	TeamInvites = 1
	Villagelistenooc=1
	jailed=0
	jailLevel=0
	muted=0
	muteLevel=0
	summoned
	sy=1
	sx=1
	sz=1
	GMfrozen
	WipeVersion
	Brand
//------------------
/****TROLL STUFF ***/
	summonSamahada=0
	chakraWW=0
//------------------
	spawnwhere
	last_x
	last_y
	last_z
	onwater
	tmp/canfindrocks=1
	Fame = 0
	MissionPoints = 0
	list/MissionsComplete = list("S" = 0,"A" = 0,"B" = 0,"C" = 0,"D" = 0)
	dead
	onmountain
	mountainspeed
	GM=0
	AdminLevel=0
	MGM=0
	protect = 0
	tmp
		OriginalOverlays[]
		swimming
		hasname
		list/HitList=list()
		throwing
		resting
		Collected
		attacking
		firing
		choosingHoming
		taitraining=0
		moving
		special
		mapSpecial
		CantWalk
		Gokusamaisou
		SunaNoMayu
obj/var
	gold
	amount=1
	worn
	price
	rare=0
	tradeable=1
	mask=0
	repairCost
	ItemType=""

var
	RebootTime
	GeninExamTime
	ChuuninExamTime
	KonohaInvasionTime