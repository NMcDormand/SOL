turf/bookshelf
	icon='Bookshelf.dmi'
	density=1
	name="Bookshelf"
	B01
		icon_state="01"
	B02
		icon_state="02"
	B07
		icon_state="07"
	B08
		icon_state="08"
	B09
		icon_state="09"
	B10
		icon_state="10"
obj/bookshelf
	icon='Bookshelf.dmi'
	density=1
	name="Bookshelf"
	verb
		ReadBook()
			set src in oview(1)
			set name="Read a Book"
			set desc="Study for the Genin Exam"
			switch(input("Which book do you want to read?","Library")as null|anything in list("Experience Points for Dummies","Chakra 101","Training Stamina, for Beginners","Genjutsu, Ninjutsu and Taijutsu Guide","Profession Index","Book of Skills","Elemental Basics"))
				if("Experience Points for Dummies") usr.Book1()
				if("Chakra 101") usr.Book2()
				if("Training Stamina, for Beginners") usr.Book3()
				if("Genjutsu, Ninjutsu and Taijutsu Guide") usr.Book4()
				if("Profession Index") usr.Book5()
				if("Book of Skills") usr.Book6()
				if("Elemental Basics") usr.Book7()
	B03
		icon_state="03"
	B04
		icon_state="04"
	B05
		icon_state="05"
	B06
		icon_state="06"

mob/proc
	Book1()
		src<<browse(null,"window=info"); src<<browse(Book1,"window=info;can_resize=0;size=400x205")
	Book2()
		src<<browse(null,"window=info"); src<<browse(Book2,"window=info;can_resize=0;size=400x200")
	Book3()
		src<<browse(null,"window=info"); src<<browse(Book3,"window=info;can_resize=0;size=400x260")
	Book4()
		src<<browse(null,"window=info"); src<<browse(Book4,"window=info;can_resize=0;size=400x400")
	Book5()
		src<<browse(null,"window=info"); src<<browse(Book5,"window=info;can_resize=0;size=400x230")
	Book6()
		src<<browse(null,"window=info"); src<<browse(Book6,"window=info;can_resize=0;size=400x570")
	Book7()
		src<<browse(null,"window=info"); src<<browse(Book7,"window=info;can_resize=0;size=500x380")

var/const/Book1={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Experience Points for Dummies</title></head>
<body scroll=no><i>Experience Points</i> are earned by attacking/killing other players (including most NPCs).   The amount of Experience earned depends on the the amount of damage you cause, and the average stats of each player (yours and theirs).<br><br>
Upon Levelling Up, a slight stat increase occurs; also, <i><u>Stat Points</u></i> are awarded.  Stat Points can be exchanged for numerous things, including upgrading your clan jutsu.
</body>"}

var/const/Book2={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Chakra 101</title></head>
<body scroll=no><i>Chakra</i> is needed to create almost all jutsu.  In Shinobi of Legend, chakra is trained whenever you <i>use</i> chakra or by <i>Meditating</i>.<br>
By far, the most effective way is to actively move around on the surface of water.  Anything that trains Chakra (except meditation), also trains a player's <u>Chakra Control</u>(CC).  CC represents the chance, as a percent, that a jutsu will be successfully performed.<br>
Players must <u>rest</u> to restore their Chakra.
</body>"}

var/const/Book3={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Training Stamina, for Beginners</title></head>
<body scroll=no><i>Stamina</i> determines how long someone can survive in a combat situation, for all intents and purposes it is your health meter. It is also worth pointing our that Stamina is closely linked with Taijutsu.  There are multiple ways to improve Stamina; they are listed here:<br>
<ul>
  <li>Tree Stump training</li>
  <li>Wearing weights, which you can wear and/or clip-on more</li>
  <li>Sparring (either with/without using spar arenas)</li>
  <li>Climbing particular <u>mountains</u> (it is not a bad idea to combine this method with the <i>weights</i> method).</li>
</ul>
Players must <u>rest</u> to restore their Stamina.
</body>"}

var/const/Book4={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title> Genjutsu, Ninjutsu and Taijutsu Guide</title></head>
<body scroll=no>
<i>Genjutsu</i> are illusionary techniques, designed confuse and/or mentally injure the enemy. Higher forms of Genjutsu are capable of causing death.<br>
Can be trained by simply using Genjutsu techniques (e.g. Bunshin no Jutsu).<p>

<i>Ninjutsu</i> are usually ranged techniques. Almost all Ninjutsu techniques do damage, many are capable of dealing heavy blows to an opponent.<br>
Ninjutsu, like Genjutsu, is trained by using Ninjutsu techniques (e.g. Kage Bunshin no Jutsu).<p>

<i>Taijutsu</i> is the art of using your body in combat and is closely linked with <u>Stamina</u>.  In close-quarters, Taijutsu undoubtedly decides the outcome.<br>
Training methods include:
<ul>
  <li>Tree Stump training</li>
  <li>Wearing weights, which you can wear and/or clip-on more</li>
  <li>Sparring (either with/without using spar arenas)</li>
  <li>Climbing particular <u>mountains</u> (it is not a bad idea to combine this method with the <i>weights</i> method).</li>
</ul>
</body>"}

var/const/Book5={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Profession Index</title></head>
<body scroll=no><i>Professions</i> bestow players with special skills (passive/active) and unique jutsu.<br>
In order to attain a <i>profession</i>, you must locate and talk with the <i>Profession-Nins</i> located throughout the world.  They are marked by purple flags, so keep your eyes peeled.<p>
<b>Assassin-nins</b> are masters of stealth.  The Assassin-nin can be found in between Sound and Cloud villages.<br>
<b>Medical-nins</b> are masters of anatomy and highly skilled healers.  The Medical-nin is located in Sound Village.<br>
<b>Sand-nins</b> control sand with their chakra. The Sand-nin is in Sand Village.<br>
<b>Sword-nins</b> have a mastery of the sword, and only Sword-nins can wield <i>Legendary Swords</i>.  The Sword-nin is somewhere South of Leaf Village.<br>
<b>Hand to Hand-nins</b> are able to deal tremendous damage with their bare hands.  The Hand to Hand-nin is located somewhere near Rock Village.<br>
<b>Fand-nins</b> utilise the <i>Wind</i> and can blow away opponents and weapons with their jutsu.  The Fan-Nin is located South-East of Mist Village.
</body>"}

var/const/Book6={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Book of Skills</title></head>
<body><i>Skills</i> are abilities that can give you an advantage over an opponent or help make your life easier.<p>

<b>Knife Skill</b> increases damage dealt when a Kunai is <i>equipped</i> or <i>thrown</i>.<br>
This skill is increased when a Kunai is used, either from throwing or slashing with it.<p>

<b>Shuriken Skill</b> improves the damage done from your Shurkien (both regular and Windmill forms).<br>
Throwing Shuriken trains your Shuriken Skill.<p>

<b>Sword Skill</b> increases your damage with Swords (and some Kaguya bone weapons).<br>
It is trained by equipping a Sword and attacking.<p>

<b>Fishing Skill</b> helps you <i>catch fish</i> with a <u>Fishing Rod</u>.<br>
The quality of rod you can use, and the fish you're able to catch is dictated by the player's Fishing Skill.
There are 3 types of rod, and 5 types of fish.  Regular fish restore the eater's <i>Stamina</i> (the bigger the fish, the more Stamina restored); <u>Lava Fish</u> restore upto half of the eater's <i>Stamina</i> in one go.  And <u>Shadow Fish</u> restore the eater's <i>Chakra</i> instead.<br>
In order to catch higher quality fish, players need <i>both</i> higher skill, and better rods.<p>

<b>Crafting Skill</b> allows you to create weapons and items out of <i>Feathers</i> and <i>rocks</i>.
With crafting, chance of success is determined by your <i>Chakra Control</i>, and quality is decided by your Crafting Skill.  As your Crafting Skill improves, more types of items become available to craft and more items of lesser skill requirement are made in one go.<p>

<b>First Aid Skill</b> helps you apply <i>Bandages</i> more efficiently.<br>
Everytime you use your bandages, you are training this skill.  Over time, your First Aid skill will increase and you will heal more wounds per bandage.<br>
Medic Nins get a boost in this skill and have a better learning curve whilst a Medic Nin.
</body>"}

var/const/Book7={"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 12px}</STYLE>
<head><title>Elemental Basics</title></head>
<body>Certain jutsu not only draw their power from your Ninjutsu/Genjutsu/Taijutsu and/or Chakra, but <i>also</i> from an Element (sometimes from two combined).<br>
As well as influencing damage done, Elemental power also offers a defence (e.g. your water element will act as a defence against fire attacks).

<p>Furthermore, in order to train these attributes, a ninja must use an <i>elemetal release</i> technique (as listed below).

<p><font color=red> <i>Katon</i></font>: Fire release.<br>
<font color=blue><i>Suiton</i></font>: Water release.<br>
<font color=silver><i>Fuuton</i></font>: Wind release.<br>
<font color=brown><i>Doton</i></font>: Earth release.<br>
<font color=blue><i>Raiton</i></font>: Lightning release.<hr>
<font color=blue><i>Hyouton</i></font>: Ice release.<br>
<font color=green><i>Mokuton</i></font>: Wood release.<p>

<font color=red><i>Katon</i></font> beats <font color=silver><i>Fuuton</i></font> beats <font color=brown><i>Doton</i></font> beats
<font color=blue><i>Raiton</i></font> beats <font color=blue><i>Suiton</i></font> beats <font color=red><i>Katon</i></font>.<br>
<font color=blue><i>Hyouton</i></font> will either beat, or be beaten by <font color=red><i>Katon</i></font>, depending on elemental strength.<br>
<font color=green><i>Mokuton</i></font> is weak against <font color=red><i>Katon</i></font> but strong against <font color=blue><i>Suiton</i></font>.
</body>"}