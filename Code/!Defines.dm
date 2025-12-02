#define DEBUGGING 1
#define TESTING 1

#define DAYS    *864000
#define DAY     *864000
#define HOURS   *36000
#define HOUR    *36000
#define MINUTES *600
#define MINUTE  *600
#define SECONDS *10
#define SECOND  *10
#define TICKS   *1
#define TICK    *1
#define MILLISECONDS /100
#define MILLISECOND  /100

#define floor(x) round(x)
#define ceil(x) (-round(-x))

#define CALORIEMAX 5000

//#define CHECK_TICK if(world.tick_usage > 80) sleep(world.tick_lag) //Prevent missed Ticks
#define CHECK_TICK if(world.tick_usage > 80) lagstopsleep() //Prevent missed Ticks
proc
	lagstopsleep()
		var/tickstosleep = 1
		do
			sleep(world.tick_lag*tickstosleep)
			tickstosleep *= 2 //increase the amount we sleep each time since sleeps are expensive (5-15 proc calls)
		while(world.tick_usage > 75 && (tickstosleep*world.tick_lag) < 32) //stop if we get to the point where we sleep for seconds at a time

#define SAVEPATH "saves/[copytext(key,1,2)]/[key]/[Slot]/player.sav"
#define CHATPATH(M) "saves/[copytext(M.key,1,2)]/[M.key]/[M.Slot]/Chat[M.Slot].txt"
#define WCHATPATH "Data/Wipe/WorldChat.txt"
#define DEFAULTSTATS list("Level","Health","Stamina","Energy","Spirit","Strength","Willpower","Charisma","Dexterity","Endurance","Intellect","Perception","PRange","Luck","Crit","AttackSpeed","Reflexes","Unarmed","Knife","Pole","Scythe","Sword","Whip","Throwing","Bow","Spear")
#define RESETICON icon_state=""
//#define SETICON(A) icon_state="[A]"
#define SETICON(A,B,M) if(!M.icon_state)M.icon_state=A;spawn(B)M.icon_state=""
#define SETPICON(A) icon_state=A
#define MAXVISDIST(A) (32*(A))

#define MAXVISDIST(A) (32*(A))
#define PLAYER(M) mob/player/M
#define LIVING(M) mob/Living/M


#define IS ==
#define CVAR(M) M
#define TILE_WIDTH 32
#define TILE_HEIGHT 32
#define CHECK_TICK if(world.tick_usage > 70) sleep(world.tick_lag) //Prevent missed Ticks
#define LAYERME(M) M.layer = text2num("[MOB_LAYER].[world.maxy - M.y][(32-M.step_y) < 10 ? 0 :][32-M.step_y]")
#define SHARINGANVISBILITY 5
#define BYAKUGANVISIBILITY 6
#define LOWINVISIBILITY
#define MIDinvisibility 4
#define HIGHINVISIBILITY 6
#define DEBUG(A) text2file(A,"Data/debug.html")
#define AREADIAG 50

#define DMPREWARD 2
#define CMPREWARD 10
#define BMPREWARD 30
#define AMPREWARD 60
#define SMPREWARD 100

//Commands
#define STATUS_BLANK 0
#define STATUS_FOLLOW 1
#define STATUS_ATTACK 2
#define STATUS_STAY 3
#define STATUS_RESTRAINED 4
#define STATUS_FREEWILL 5
#define STATUS_REVOLT 6
#define STATUS_PACK 7
#define STATUS_MEDITATE 8

//Game Default Lists
//#define HAIRLIST list("","Afro"='Afro.dmi',"Deidara"='Deidara.dmi',"Gaara"='Gaara.dmi',"Hashirama"='Hashirama.dmi',"Hidan"='Hidan.dmi',"Ino"='Ino.dmi',"Itachi"='ItachiHair.dmi',"Jiraiya"='Jiraiya.dmi',"Jiroubou"='Jiroubou.dmi',"Kakashi"='Kakashi.dmi',"Kimimaro"='Kimimaro.dmi',"Konan"='Konan.dmi',"Long"='Long.dmi',"LongCelebrity"='LongCelebrity.dmi',"LongStraight"='LongStraight.dmi',"Madara"='Madara.dmi',"Minato"='Minato.dmi',"Mohawk"='Mohawk.dmi',"Myst"='Myst.dmi',"Naruto"='Naruto.dmi',"Neji"='Neji.dmi',"Orochimaru"='Orochimaru.dmi',"RockLee"='RockLee.dmi',"Sakura"='Sakura.dmi',"Sasuke"='Sasuke.dmi',"Shikamaru"='Shikamaru.dmi',"Short"='Short.dmi',"ShortCombed"='Short.dmi',"Spike"='Spike.dmi',"Spiky"='Spiky.dmi',"Tayuya"='Tayuya.dmi',"Temari"='Temari.dmi',"TenTen"='TenTen.dmi',"Tsunade"='Tsunade.dmi',"Viole"='Viole.dmi')
#define BASELISTICON list("Base_Black"='Base_Black.dmi',"Base_Blue"='Base_Blue.dmi',"Base_Dark"='Base_Dark.dmi',"Base_Green"='Base_Green.dmi',"Base_Lilac"='Base_Lilac.dmi',"Base_Medium"='Base_Medium.dmi',"Base_Pale"='Base_Pale.dmi',"Base_Pallid"='Base_Pallid.dmi',"Base_Pink"='Base_Pink.dmi',"Base_Red"='Base_Red.dmi',"Base_Tan"='Base_Tan.dmi',"Base_White"='Base_White.dmi',"Base_Yellow"='Base_Yellow.dmi')
#define BASELIST list("Base_Black","Base_Blue","Base_Dark","Base_Green","Base_Lilac","Base_Medium","Base_Pale","Base_Pallid","Base_Pink","Base_Red","Base_Tan","Base_White","Base_Yellow")

#define BASEICONLIST list('Base_Black.dmi','Base_Blue.dmi','Base_Dark.dmi','Base_Green.dmi','Base_Lilac.dmi','Base_Medium.dmi','Base_Pale.dmi','Base_Pallid.dmi','Base_Pink.dmi','Base_Red.dmi','Base_Tan.dmi','Base_White.dmi','Base_Yellow.dmi')
//#define BASELIST list("Black"='Base_Black.dmi',"Blue"='Base_Blue.dmi',"Dark"='Base_Dark.dmi',"Green"='Base_Green.dmi',"Lilac"='Base_Lilac.dmi',"Medium"='Base_Medium.dmi',"Pale"='Base_Pale.dmi',"Pallid"='Base_Pallid.dmi',"Pink"='Base_Pink.dmi',"Red"='Base_Red.dmi',"Tan"='Base_Tan.dmi',"White"='Base_White.dmi',"Yellow"='Base_Yellow.dmi')
#define CLANLIST list("Hyuuga"=1,"Jugo"=1,"Kaguya"=1,"Otsutsuki"=1,"Senju"=1,"Uchiha"=1,"Uzumaki"=1,"Yuki"=1)
#define CLANMULTIS list("Aburame" = list("Stamina" = 1,"Chakra" = 1.2,"Taijutsu" = 0.3,"Ninjutsu" = 1.6,"Genjutsu" = 1.3,"Jutsu" = 1.2),"Akimichi" = list("Stamina" = 1.4,"Chakra" = 1.1,"Taijutsu" = 1.2,"Ninjutsu" = 0.5,"Genjutsu" = 0.5,"Jutsu" = 0.6),"Hyuuga" = list("Stamina" = 1.2,"Chakra" = 0.5,"Taijutsu" = 1.5,"Ninjutsu" = 0.5,"Genjutsu" = 0.8,"Jutsu" = 1.1),"Inuzuka" = list("Stamina" = 1.2,"Chakra" = 1,"Taijutsu" = 1.2,"Ninjutsu" = 0.8,"Genjutsu" = 0.8,"Jutsu" = 1),"Kaguya" = list("Stamina" = 1.4,"Chakra" = 1.2,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.1,"Jutsu" = 0.7),"Nara" = list("Stamina" = 1.2,"Chakra" = 1.3,"Taijutsu" = 0.3,"Ninjutsu" = 1,"Genjutsu" = 1.2,"Jutsu" = 1.2),"Taijutsu Specialist" = list("Stamina" = 2,"Chakra" = 0.5,"Taijutsu" = 2.2,"Ninjutsu" = 0.1,"Genjutsu" = 0.1,"Jutsu" = 0.5),"Uchiha" = list("Stamina" = 1,"Chakra" = 0.8,"Taijutsu" = 1.2,"Ninjutsu" = 1,"Genjutsu" = 1.5,"Jutsu" = 2),"Uzumaki" = list("Stamina" = 2.5,"Chakra" = 3,"Taijutsu" = 1.2,"Ninjutsu" = 1.2,"Genjutsu" = 0.2,"Jutsu" = 0.7),"Yuki" = list("Stamina" = 1,"Chakra" = 1.4,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.7,"Jutsu" = 1.6),"Sand" = list("Stamina" = 1,"Chakra" = 1.7,"Taijutsu" = 0.9,"Ninjutsu" = 1.6,"Genjutsu" = 0.2,"Jutsu" = 1.2),"Clay" = list("Stamina" = 1,"Chakra" = 1.4,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.7,"Jutsu" = 1.2),"Sarutobi" = list("Stamina" = 1,"Chakra" = 1,"Taijutsu" = 1,"Ninjutsu" = 1,"Genjutsu" = 1,"Jutsu" = 1.8),"Senju" = list("Stamina" = 1.8,"Chakra" = 1.6,"Taijutsu" = 1.3,"Ninjutsu" = 1.3,"Genjutsu" = 1.3,"Jutsu" = 3),"Otsutsuki" = list("Stamina" = 0.3,"Chakra" = 0.3,"Taijutsu" = 0.3,"Ninjutsu" = 0.3,"Genjutsu" = 0.3,"Jutsu" = 3))

//#define HAIRLIST list("","Afro","Deidara","Gaara","Hashirama","Hidan","Ino","Itachi","Jiraiya","Jiroubou","Kakashi","Kimimaro","Konan","Long","LongCelebrity","LongStraight","Madara","Minato","Mohawk","Myst","Naruto","Neji","Orochimaru","RockLee","Sakura","Sasuke","Shikamaru","Short","ShortCombed","Spike","Spiky","Tayuya","Temari","TenTen","Tsunade","Viole")
//#define BASELIST list("Base_Black","Base_Blue","Base_Dark","Base_Green","Base_Lilac","Base_Medium","Base_Pale","Base_Pallid","Base_Pink","Base_Red","Base_Tan","Base_White","Base_Yellow")
#define CURSELIST list(" rape", " raping", " arse"," ass ","vagina","penis","piss","pussy","bastard","skank","motherfucker","fuck","fuk","fuc","cock","cok","dick","dik","dic","cunt","asshole","arsehole","shit","slut","whore","bitch","sloot","vagoo")
#define RACISTLIST list("raghead","nigger","nigga","nig-nog","niglet"," nig "," coon","spic","beaner","chink","wetback","porchmonkey","porch monkey","chinaman","kike","jiggaboo","gook")
#define DISCRIMLIST list("homo ","faggot","fagot","faget","fagit","fag","queer","dyke","dike","fag","tranny","retard","tard","autist")
#define SYMBOLSLIST list(" ","-","=","_","~",",",".","!","#","$","%",">","<","%","&","*","(",")","+","`",":",";","{","}","\[","]","\\","|","\"")
#define INDEXLIST list("PlayerContents" = PlayerContents,"Players" = PlayerList,"ChatNames" = ChatNames,"Curse"=Curse,"Racist"=Racist,"Discrim"=Discrim,"Hair"=HairList,"Base"=BaseList)
#define EDITIGNORELIST list("EditVar","Editing","InEdit","locs","glide_size","screen_loc","animate_movement","pixel_step_size","see_infrared","client","maptext_x","maptext_y","color","blend_move","appearance","alpha","transform","maptext_height","maptext_width","vars","verbs","maptext","override","pixel_z","pixel_y","pixel_x","mouse_opacity","mouse_drop_zone","mouse_drop_pointer","mouse_drag_pointer","mouse_over_pointer","luminosity","text","suffix","tag","desc")
#define KILLLIST list("Total" = 0,"Human" = 0,"Players" = 0,"NPC" = 0,"Animals" = 0,"LargeAnimals" = 0,"Criminals" = 0,"CurLargeAnimals" = 0,"CurCriminals" = 0,"CurAnimals" = 0)
#define SPSLIST list("Total"=0,"Owned"=0,"MisReward"=0,"Spent"=0,"Health"=0)
#define MISSIONSDONELIST list("D"=0,"C"=0,"B"=0,"A"=0,"S"=0, "Points" = 0)

//OUTPUT
#define ADDCHAT(A,B,C,D,E) var/ChatAdd = {"<div class="[B]" style="display:[A.ChatToggles["T[B]"] ? "block":"none"]">[C]</div>"};A.ChatUpdate+=ChatAdd;
#define ADDPCHAT(A,B,C,D,E) A << output(list2params(list(B,C,D,E)),"Panel1:AddChat");A << output(list2params(list(B,C,D,E)),"Panel2:AddChat");text2file({"<div class="[B]">[C]</div>"},CHATPATH(A))

//Settings
#define SHUNSHINRANGE 5 //Base range of shunshin
#define SHOSENHEALDELAY 50 //How quickly Shosen heals
#define TAIMINEXP 20
#define TAIMAXEXP 50

//Locations
#define STARTTILE locate(1,1,1)

//Colors
#define SOUND_CLR "FFB643"
#define EMOTE_CLR "17E826"
#define SPIRIT_CLR "17E6E8"
#define PERCEP_CLR "77E6E8"
#define INIT_CL_CLR "#202020"

//Villages
#define CLOUDCLR "#dbef7f"
#define LEAFCLR "#e92106"
#define MISTCLR "#1048ff"
#define ROCKCLR "#85663d"
#define SANDCLR "#dea700"
#define GRASSCLR "#91aa33"
#define RAINCLR "#77DDFF"
#define SOUNDCLR "#800040"
#define WATERFALLCLR "#1060a2"

//NPC Colors
#define HEADON_CLR "#7E5381"
#define DANA_CLR "#fa8072"
#define ACTION_CLR "#BBBBBB"

//Layers
#define WEAPON_LAYER FLOAT_LAYER-1
#define HAT_LAYER FLOAT_LAYER-2
#define FACE_LAYER FLOAT_LAYER-2.1
#define HAIR_LAYER FLOAT_LAYER-3
#define EYE_LAYER FLOAT_LAYER-3.1
#define OVER_LAYER FLOAT_LAYER-4
#define GLOVE_LAYER FLOAT_LAYER-5
#define SHIRT_LAYER FLOAT_LAYER-6
#define PANTS_LAYER FLOAT_LAYER-7
#define SHOE_LAYER FLOAT_LAYER-8
#define UNDER_LAYER FLOAT_LAYER-9
//#define _LAYER FLOAT_LAYER-1