/*
* Assissin Nins dont trip the alarm if invisible while entering
*


--- FINISH BY THE 31ST --
Add halloween Stuff

Rebirth System - First Stage (Two prof) -- NVM - I want this to come way later...



---- TO FIX -----

--- NEXT UPDATE -------
Crafting System
	Repair From Window
	Upgrade Weapon (Different versions of the same weapon / Elemental Weapon)
Harvesting
	Goes hand in hand with the crafting system.



Fix Dogs so that when killing them it doesn't create a brand new dog with 50 max exp again
Also Fix dogs so that they get soft caps
Jamie stupid thing that you can learn rasengan with and it's dumb. It MAY OR MAY NOT be a good idea. Defs not fantastic though. Not.
Fix death verb to avoid taking kage
Finish Guilds and Guild House system
Trade System - Logs all trades to a file so that we can track trades. Disable the ability to drop certain items like weights & weapons (anything worth a lot)
Update missions
 -NPC should have it's own selection without going through a list
 -Feather mission should have a way to gain more at once.
Flying Rajin Jutsu (Teleport to daggers - up to 3 markers)
Create and connect Database on web server for perma item unlocks for user keys. (I AM SO SMART)
Capture the Flag Tournament
Throw at logs = faster throwing skill gain AND chance to grab back shurikens.
All Homing Jutsus added so that if target, go to that before using a select list (works on stumps)
Bijuu mode = 50x chakra and chakra % punches?
*/


/*
====================================================================================================================================
===========================================================--Update Log--===========================================================
====================================================================================================================================

=================== In Progress =====================================
- Mask feature (Hide identity)
- Guilds / Guild Houses
- Fix Trade Glitches with some items (fishing rod) and trade request timeout not working
- Add shadows to clones (otherwise we can tell who is real and who is fake)
- Changed a few things about Executioner Blade


=================== Live 14/06/17 =========================================
- Dogs can now walk on water until they drop below 20% health. They do have a constant stamina drain while on water though!
- Brands now also reduce players training by 80%. Don't cheat!
- Fixed "RanshinShou" bug where the nerves never healed.
- Fixed dogs placing and unable to attack. Now bases it off your own protection state. (If you aren't in a safe zone, nor are they)
- Dogs can now be numerous colours! Find the colour you want in the world before first taming OR simply pay a fee to change the colour!
- Changed weather settings (Aiming to lessen the annoyance of some colours) and set change timer to 7 minutes


===================== LIVE 12/06/17 =================================
- Dogs now disappear when owner logs off
- Added Trade System
- Added back Guilds with partial update (Can't reuse Guild Names or Tags)
- Added Day/Night System
- Added Dynamic Shadows (Some objects like trees and some NPC like chickens)
- Changed Inside/Outside to be different. Now Removes your shadow and lighting effects when inside!
- Added ability to purchase Multiple Fish from Fisherman
- Fixed ability to be able to start numerous S5 runs before actually going in (Which spawned multiple NPC)

===================== Iono when but it happened =================================

-Fixed ability to stack hair (Maybe I'll let you have it as an option for those that used it)
-Added Target System
	- Shunshin click near target area will go behind target
	- All Homing jutsus will default to target before giving select list
-Dog Stat Window now updates when dog gains stamina and not just when they lose it.
-All Attacks have been updated to "Range" instead of "View" - 1000000x better for cpu
-Fixed bug where dog size would increase too fast (Largest dog by special jounin)
-New Gates opening icon
- Changes mission ninjas (Each unique to their own mission list now)
- Kage House of each village updated to reflect above changes.
===================== LIVE 1/11/16 =================================
- Fixed Target to disable if target goes invisible
- Fixed bugs with target when logging out
- Added Toggle Say/OOC to main window.
- Fixed Large Candy (Was using all at once when eating)

======================= 31/10/16 =======================================
- Can no longer use decimals in weights
- Dogs now change size throughout gameplay.
- Reflex System Rework (Complete upgrade to the old system)
- Shunshin appearance upgrades
- Feather missions - Select how many to hand in at once!
- Delivery missions now have a wait time on successful mission. Abandon Quest/Logging out will proc a longer delay
- Can now spar with your own clones. (Reduced gains)
- Lowered some SP gains (Steps to lower SP impact)
- Extra Dupe Protection Methods.
- Added halloween Items
	- Witch Hat / Pumpkin Mask
	- Red/Blue/Green/Large Candy = Heals stam&wounds

======================--Previous Updates--==================================
- Profession Jutsus can be learnt again for free if lost. (Go to Prof Ninja)
- Fishing Updates
	Auto Fish Feature - This is designed for AFK use as it takes a long time to complete.
	Fishing Rod/Box Price Increased
	Repair Prices work based on the durability. At 0% the rod is considered broken (Higher repair cost)
- Inuzuka
	Fixes for Jutsus (A lot weren't working)
	Skill Cards added
	Stat points fixed, now applies correctly
	Dog Stat Window (Located where your own stats and skills are)
- Suna Bunshin - Re-added with new requirements. (Still easier to get than kage bunshin)
- Rare Items (These items can not be shared & henge won't include them)
	Akatsuki Cloak
	Samehada (New Icon)
	Executioner Blade (New Icon)
- Appearance
	Lots of new hair styles including three expensive styles.
	Two new female clothing items
	Water walking icon updated
- Class Changes
	Kaguya dances no longer give crazy stats
	Hyuuga palms damage lowered
	Uchiha can no longer attack in Tsukuyomi
	Haku Mirrors Icon
- Bug Fixes
	Three different Dupes Fixed
	Shunshin mountain bug (Can no longer be used on mountain)
	Dispel in Meditate is no longer possible.
	Killing students with bunshins (Should be impossible to kill now)
	Mugen self damage caused positive stamina
	A unique bug with bunshins which had the potential to crash the game.
	Lots of others I can't remember at all...
- Chicken Update Phase One
	Chickens Icon updated
	Chickens now move around
- Icon Updates
	Rasengan / Daibakufu / Sawarabi / Mirrors
- Other
	The "?" button allows users to report bugs and suggestions
	New Announcement notification (Appears on screen)
		Level up / Medals / Rank Promotion
	toggleEXP commands - prevents level exp (requested)





<b>Event</b>
*Samehada icon update and new location
 The first person to find it will obtain a unique version of the samehada (this is forever) and something else for being first!
 If you find it, make sure to take a screenshot and submit to the SoL Byond Page ASAP!  <a style='text-decoration: none; color:#9292ff' href='http://www.byond.com/forum/SaucepanMan/ShinobiOfLegend'>Click here!</a>
 Good luck and more to come soon!






*/


