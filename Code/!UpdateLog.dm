/*
<b>Facebook</b>
Can you Icon? Want to help SoM development?
<a style='text-decoration: none; color:#9292ff' href='https://www.facebook.com/ShinobiOfLegend'>Leave a Message!</a>

<b>Updates</b>
<a style='text-decoration: none; color:#9292ff' href='http://mysting.net/updates.php'>Click here!</a>

<b>Note from Mystery</b>
What do you want to see in SoM? <a style='text-decoration: none; color:#9292ff' href='http://www.byond.com/forum/?post=2215959'>Click here to let me know!</a>

*/


//Update Log Notes

//NOTE TO SELF - ADD A THING IN THE CODE TO DISABLE SAVE IF THE FILE IS NOT FULLY LOADED. MAYBE GIVE IT A MINUTE AFTER LOGGING IN IN CASE OF CRASH!!!
//BUT WE ALSO NEED TO MAKE SURE THAT ITEMS.. well I guess if they have items

//READ ABOVE NOTE
//READ ABOVE NOTE
//READ ABOVE NOTE
//READ ABOVE NOTE
//READ ABOVE NOTE

/*
- Fix for Giant form being instant, now requires chakra control & SS
- Fix for giant form disabling attacking
*/


var/updateLogNotes = {"
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Shinobi of Myth Chanegelog</title>
<style>
	body {font-family: 'Arial'; font-size: 10pt; background: #222; color: #c0c0c0; font-weight: Bold;}
	a:link {color: #0000ff; text-decoration: underline}
	a:visited {color: #ff00ff}
	img.icon {width: 16px; height: 16px;}
	li {margin:10px 10px;color:#ddd}
	dd {position:relative;left:20px;margin:5px 20px;color:#999;font-weight: normal;}
	b {color: #ff99ff;}
	div button
		{
			color: #999999;
			margin: 10px 0px;
			background: #101010;
			font-weight: Bold;
			border: 0px;
			padding: 5px 5px;
			width:100%;
		}
</style>
<script type="text/javascript">
	function showReport(el){
	  var inner = el.nextSibling.nextSibling;
	  var outer = el.parentNode;
		if (inner.style.display == "none")
			{
				inner.style.display = "";
			}
		else
			{
				inner.style.display = "none";
			}
	}
</script>
</head>
<body>
<div>
	<button onclick="showReport(this)">Update 4.05B The Fix of the Titan</button>
	<div>
		<ul>
			<li>Shunshin cooldown has now been lowered to 1 second, not quite the zero you wanted i know</li>
			<li>Shunshin now functions off 1 click not 2</li>
			<li>ActionVerb has been changed to Action for easier Macros</li>
			<li>Hot Bar & Skill Window Updates
				<ul>
					<li>The Hotbar will now automatically set a starting set of skill cards on creation</li>
						<dd>* You now also have an option to reset to this initial setup and empty the entire bar</dd>
					<li>The Skill Window has been fixed as it was not showing all the skills or in the correct locations</li>
					<li>Skill Card icons have received some updates to colours and icons</li>
						<dd>* <font color="#0099FF">Light Blue</font> is now for action cards (ie. Action, Craft, Climb)</dd>
						<dd>* <font color="#FF9933">Orange</font> is now for Commands (ie. Bunshin Commands)</dd>
						<dd>* <font color="#CC00CC">Pink</font> is now for S-Rank and Forbidden Skills (ie. Hiraishin, Edo Tensei)</dd>
						<dd>* <font color="#101010">Black</font> will remaind as Clan Jutsu</dd>
						<dd>* <font color="#FF0000">Red</font> is Ninjutsu</dd>
						<dd>* <font color="#00ff00">Green</font> is Taijutsu</dd>
						<dd>* <font color="#4C209D">Purple</font> is Genjutsu</dd>
				</ul>
			</li>
			<li>Fixes
				<ul>
					<li>Soutourou now correctly trains past 31, and correctly works</li>
					<li>Juujin Bunshin would not be recognized as in use under specific situations, thats now been fixed</li>
					<li>Kaiten now has a correct upgrade choice and no longer locks you from other skills if failed</li>
					<li>Backend fix for AI tai checks, this should help with the NPC not attacking correctly</li>
					<li>NPC no longer trigger the hospital protection</li>
					<li>Players can no longer punch Academy Students</li>
					<li>Candy can once again be picked up by players</li>
					<li>Mikazuki no correctly applies weapons bonuses</li>
					<li>Inuzuka Infinite Stam bug hopefully fixed</li>
					<li>Edo Spam bug fixed</li>
					<li>Madara and Viole are no longer affected by Tsukuyomi</li>
					<li>You can now correctly attack NPC and their clones</li>
					<li>\[REDACTED] will now correctly damage the player on the tile it hits</li>
					<li>\[REDACTED] movements are no longer able to be stopped by moving</li>
					<li>Shunshin movements are no longer cancelled by moving</li>
					<li>Shunshin is now toggled correctly by clicking the card or using the shunshin verb</li>
					<li>Water drowning damage should actually work this time, please report if it still doesnt</li>
				</ul>
			</li>
		</ul>
	<div>
</div>
<div>
	<button onclick="showReport(this)">Update 4.05 The Intro of the Titan</button>
	<div style="display:none;">
		<ul>
			<li>Rule Change
				<ul>
					<li>AFK training is no longer allowed</li>
						<dd>* Players will once again be subjected to AFK checks by GMs</dd>
						<dd>* Players are now allowed to log out during and afk check</dd>
						<dd>* AFK checks must be responded to by the character that is being checked</dd>
				</ul>
			</li>
			<li>Generic Changes
				<ul>
					<li>Mission man mistakenly allowed Rock Ore for missions, i have removed that</li>
					<li>The Skill bar is now a floating bar that will auto center itself vertically</li>
					<li>I have slowed down the Skill training to make it more rewarding but have increased the transfer rate for their seeds</li>
				</ul>
			</li>

			<li>Clan Updates
				<ul>
					<li>Uchiha
						<ol>
							<li>Mangekyou no longer requires friendship to unlock, just be on the same team</li>
						</ol>
					</li>
				</ul>
			</li>

			<li>Additions
				<ul>
					<li>Madara Uchiha is the next Boss Fight</li>
						<dd>* He will be the most dificult NPC to beat to date, this is not because of his states or any protections like the former bosses</dd>
						<dd>* As he is this this hard, he will have the biggest reward thus far</dd>
						<dd>* He is not a secret NPC, dont be worried about not finding him at first. He will present himself when the time is right</dd>
						<dd>* Tip, when he presents himself you should team up</dd>
					<li>5 New Jutsu have been added</li>
						<dd>* These are Clan Level jutsu that i have decided to make into something special instead</dd>
						<dd>* Again not a secret but you will get these when you get them</dd>
				</ul>
			</li>
		</ul>
	<div>
</div>
<div>
	<button onclick="showReport(this)">Update 4.0 the grail edition</button>
	<div style="display:none;">
		<ul>
			<li>Generic Changes
				<ul>
					<li>Player Caps will now be affected by the global experiene multipliers</li>
					<li>Chuunin Entrant weakened based on response from players</li>
					<li>NPC AI updated for efficiency</li>
					<li>Friendship Stat Added</li>
						<dd>* While standing near your Guild Mates or Squad Members you will slow grow their friendship</dd>
						<dd>* Will be expanded to have negatives in next build</dd>
					<li>You will now train your stats faster by actually fighting</li>
					<li>Most Doorways no longer block your usage if you have been damaged recently. This doesn't apply to doors that bring you inside of buildings**

					<li>Changed how the game checks if you are able to acquire a skill**
					   <li>This is actually a very big weight reduction though it may not seem so

					<li>Rebirth will transfer Mission Points based on rebirth percentage**

					<li>You shouldn't repeatedly unlock skills anymore**
					   <li>Let me know if you still see any

					<li>Team and Rebirth buttons have been moved and renamed</li>
						<dd>* Rebirth is now in the ?</dd>

					<li>Team Button will now adjusts itself accordingly to your current team code</li>

					<li>A Timer will now appear for specific skills to designate how much time remains on their effects</li>
					   <dd>* At the moment this only applies to Hachimon and Izanagi</dd>
					   <dd>* Please make suggestions for anything else you feel it should be used for</dd>
					<li>a + has been added to the Skill Stats to allow to view them all in one place</li>
						<dd>* This window will not update until you close and reopen it</dd>
					<li>The OOC toggle has been moved to the left side of the input</li>
					<li>A new On/Off button has been added to toggle the OOC chat to the right of the input</li>
				</ul>
			</li>

			<li>Kage Changes
				<ol>
					<li>The Village will now be given Village Points for more things</li>
					  <dd>* All missions now hand out Village Points, including Bounty Captain missions</dd>
					<li>You can now steal Village Points from the players you Kill from other villages above Chuunin Rank</li>
					 <dd>* This does not apply while you are within your own village</dd>
					 <dd>* Extra points will be given if they have a bounty</dd>
					<li>You can only have True Kage once per save</li>
					<li>you can lose kage in a few ways</li>
					   <dd>* Being Killed by a player 5 or more times while outside of your village(Can be changed by host)</dd>
					   <dd>* Killing a Player from your same village while you are the leader 3 or more times. You will be pardoned if you were attacked first (Can be changed by Host)</dd>
					   <dd>* Killing yourself while you are the Kage</dd>
					   <dd>* Logging off the game for more than 48 Hours</dd>
					   <dd>* Logging off before first acquiring enough Village Points</dd>
					   <dd>* Rebirth</dd>
					<li>After losing your Kage Ranking you will become a "Former Kage"</li>
					<li>When a Kage logs off the game, a Former Kage will take temporary command</li>
					   <dd>* Interim Kages will lose their title the same ways a true kage will lose it minus the 2 day timeout</dd>
					   <dd>* Interim Kages will lose this title the moment they log off, relogging will not give it back unless no other Interim was chosen</dd>
					   <dd>* Interim Kages cannot use Village Points, Invite other Villages Players, and cannot boot any players from the Village</dd>
					<li>If you Killed yourself or Murdered your villagers you will not be able to obtain Interim Kage</li>
					<li>The Chosen True Kage is selected based on your "Kage Score" this score currently is only affected by your S Rank score **after** you are eligible to be a Kage</li>
					   <dd>* This score will be affected by your mission count from both current and past lives</dd>
				</ol>
			</li>

			<li>Village Boost Changes
				<ol>
					<li>Village Points no longer reset between Kages, they will follow the village for the entire Wipe</li>
					<li>Village boosts are now permanent, you will no longer be able to lower the boost after it has been applied</li>
					   <dd>* The cost to boost a stat grows exponentially for each boost you have done (i.e. the Final Boost may cost 50 Village Points, while the First Boost was 1 Village Point)</dd>
					<li>Village Boosts have been heavily buffed</li>
					   <dd>* You will get a stronger boost regardless of where you are on the map</dd>
					   <dd>* You will get a stronger boost if your Kage is in the village</dd>
					   <dd>* You will get a stronger boost if you are in the village</dd>
					   <dd>* You will get a stronger boost if your Kage or Interim Kage is logged in</dd>
				</ol>
			</li>

			<li>Skill Cards 2.0
				<ol>
					<li>All Skills have been updated to new backend systems</li>
					<li>Most Skills will now Level up as they are used</li>
					<li>As they increase in Level you will unlock up to 3 available upgrades</li>
					<li>Skills can fail even with full Chakra Control until they reach a sufficient level</li>
					<li>Skills can potentially cost more Chakra until they reach a sufficient Level</li>
					<li>Skill Cooldown will naturally go down as they Level up</li>
					<li>Skills now properly adhere to Practice Mode</li>
					<li>Your skills train faster while fighting with anyone</li>
				</ol>
			</li>

			<li>Clan Updates
				<ul>
					<li>Inuzuka
						<ol>
							<li>All Skills that require others to be used first will automatically fulfill the requirements</li>
							<li>The Clan should actually work this time, but requires a Buff to the dog training</li>
						</ol>
					</li>
					<li>Hyuuga
						<ol>
							<li>Byakugan upgrades removed from SPS Window as they now use the new system</li>
						</ol>
					</li>
					<li>Kaguya
						<ol>
							<li>Sawarabi will drain Stamina while active</li>
							<li>Sawarabi Bones now have lower Stamina</li>
							<li>Sawarabi-Attack has been renamed to "Warabi No Skill" to make it easier for Commands</li>
							<li>Sawa now has a dedicated release card</li>
						</ol>
					</li>
					<li>Tai Spec
						<ol>
							<li>Hachimon Will now ignore Wounds</li>
							<li>Hachimon no longer buffs Chakra, NinSkill, and GenSkill</li>
							<li>Hachimon Taijutsu and Stamina buff has been increased</li>
							<li>Hachimon Cooldown is much higher initially</li>
							<li>Hachimon Duration is initially halved</li>
							<li>Shoufuu can disarm any weapon</li>
							<li>Shoufuu no longer drops bone and rare weapons</li>
						   <li>Gates has been renamed to Hachimon</li>
						   <li>Reduced the Stamina drain when using Hachimon</li>
						</ol>
					</li>
					<li>Nara
						<ol>
							<li>Kage Arashi Upgrade removed from Stat Point Screen and moved to Skill Upgrades</li>
							<li>Neck Bind will no longer freeze the victim when the user logs out</li>
						</ol>
					</li>
					<li>Uchiha
						<ol>
							<li>Amaterasu now leaves a trail of fire on every tile except water</li>
							<li>Any skill that requires Mangekyou Sharingan potentially blinds your vision dependant on its skill level</li>
								<dd>* Blind Time grows each time you are blinded, example first time being will be 1 second, on the 5th time being blinded it might be 6 seconds</dd>
								<dd>* Uchiha will not be affected by standard Genjutsu while blinded</dd>
							<li>Kyouten Chiten now correctly works with the newer Genjutsu Skills and now has a cooldown</li>
							<li>Tsukuyomi initial Cooldown has been greatly increased to compensate for usage buffs</li>
							<li>Tsukuyomi Chakra cost has been significantly increased</li>
							<li>Sharingan upgrades removed from SPS Window as they now use the new system</li>
						   <li>You now have potentially 5 different Mangekyou you can get</li>
						   <li>The Sharingan you have will determine your Skill obtained</li>
						   <li>Each Sharingan level is now displayed in the skillcards</li>
						   <li>Each Mangekyou type is now correctly displayed on the skillcard</li>
							<li>Mangekyou has a new method of being obtained</li>
								<dd>* You must bear near a Team Member for enough time and witness them die</dd>
								<dd>* This is only applicable if you are capable of getting the Mangekyou Sharingan</dd>
								<dd>* They must die by someone who is not part of your team or you</dd>
						   <li>Clan will no longer get both Amaterasu and Tsukuyomi</li>
						   <li>Izanami, Izanagi, and Kamui have been introduced</li>
						   <dd>* Izanami and Izanagi will forcibly close your sharingan and prevent its usage for a time</dd>
						   <li>You will be able to swap eyes with one other Uchiha member per rebirth</li>
							   <dd>* Swapping your eyes will allow access to their Uchiha Skill</dd>
							   <dd>* Forcibly swaps your eye colour, and skill level with the sharingan</dd>
							   <dd>* Prevents blindness when using any skill that requires Mangekyou Sharingan</dd>
							   <dd>* Only able to do this once per rebirth</dd>
							<li>Removed the chakra point visual from sharingan</li>
						</ol>
					</li>

					<li>Yuki
						<ol>
							<li>Sukui no Mado actually can be disabled now</li>
							<li>Sensatsu Damage is buffed</li>
							<li>Can now use Most water elemental techniques outside of water from creation</li>
						</ol>
					</li>
				</ul>
			</li>

			<li>Class Updates
				<ul>
					<li>Hand 2 Hand Class
						<ol>
					   <li>Oukashou now slowly gathers chakra on activation. on your next punch after activation it will use all gathered chakra and inflict more damage
					   <li>Tsuuten Kyaku now slowly gathers chakra on activation. on your next kick after activation it will use all gathered chakra and inflice more damage

					<li>Medical Class
						<ol>
					   <li>Regenerate has been removed as Shousen will now be able to heal the user

					<li>Sand Class
						<ol>
					   <li>Sabaku Kyou and Sabaku Soso have updated icons

					<li>Sensory Class
						<ol>
							<li>Sensory Nin will only have Sense Area
						</ol>
					</li>
				</ul>
			</li>

			<li>Skill Updates
				<ul>
					<li>Country
						<ol>
							<li>Zankouha, Zankoukyokuha, and Kyomeisen all have cards and are once again Sound exclusive</li>
						</ol>
					</li>
					<li>Earth Element
						<ol>
							<li>Dorou Doumu will now allow the user and any members of the same group or guild pass through its walls</li>
							<li>Yomi Numa now has a separate card to release the swamp</li>
							<li>Doton on water Earth Elemental requirement has been raised to 4000</li>
						</ol>
					</li>
					<li>Fire Element
						<ol>
							<li>Katon Housenka is no longer a direct homing, it will now track towards anything that is hit by one</li>
						</ol>
					</li>
					<li>Wind Element
						<ol>
							<li>Fujin Heki now has a separate card to release</li>
						</ol>
					</li>
					<li>Water Element
						<ol>
							<li>Daibakufu is now a 1 tile wide to start</li>
							<li>Goshokuzame can now be used outside of water with 16,000 Water Elemental</li>
							<li>Water Prison can now be used outside of water with 12,000 Water Elemental</li>
							<li>Goshukuzame and Water Prison no longer require the target to be on water</li>
						</ol>
					</li>
					<li>NinSkill
						<ol>
							<li>Bunshin Daibkuha, Kage Shuriken, and Shuriken Kage Bunshin have now been updated to skillcards</li>
							<li>Kage Shuriken no Skill and Shuriken Kage Bunshin no Skill have both been updated</li>
						</ol>
					</li>
					<li>GenSkill
						<ol>
							<li>Dispel now has a cooldown</li>
							<li>Senshoku Kaze can now be reversed</li>
							<li>Senshoku Firudo can now be reversed, if done the original user is hit by Senshoku Kaze</li>
							<li>Senshoku Firudo can now be Dispeled, if done the Invisible Clones will target a different victim if any exist</li>
						</ol>
					</li>
				</ul>
			</li>

			<li>Skill Seeds</li>
				<dd>* When a Skill is obtained for the first time, it will grant you its skill seed</dd>
				<dd>* Skill Seeds will transfer a portion of the Skill's level on rebirth</dd>
				<dd>* Skill Seeds save your primary stats at the exact moment you obtained them</dd>
				<dd>* On rebirth the requirements for the Skill will go down by 30% based on the saved stat</dd>
				<dd>* This means that the more Skill you obtain and the higher it's level, the better your next rebirth will be</dd>
				<dd>* You can still earn skills the regular way if your skill seed is somehow magically higher than the standard requirement </dd>
		</ul>
	<div>
</div>
<div>
	<button onclick="showReport(this)">3.915 91.5 FM, Konohas greatest station for hard rock</button>
	<div style="display:none;">
		<ul>
			<li>NPC Backend has been updated to further reduce game weight</li>
				<dd>* NPC should only move when a player is in sight or if they have something to attack</dd>
				<dd>* Hopefully i found the crash bug with Village Nin</dd>
			<li>Your Window will now flash once you are pulled in for the S Rank</li>
			<li>Fishing has seen a backend rework</li>
				<dd>* You only need to click Fish once, it will continue fishing for you until you move</dd>
				<dd>* It will stop if you have no Rods left to use as well</dd>
				<dd>* This will work as quick as possible, this is an improved speed even to manual fishing in past</dd>
				<dd>* It will Auto Select the best rod you are capable of using and continue to use this Rod</dd>
				<dd>* It will switch to the next rod if broken</dd>
				<dd>* It will select the Rod with the lowest durability of the available rods in its ranks</dd>
				<dd>* Fishing should be much more efficient both for players and the game</dd>
				<dd>* Fishing Box will also be more efficient for the game</dd>
				<dd>* The auto fishing now functions for all rods</dd>
			<li>Viole won't give duplicate skills</li>
			<li>You won't get the thorn message everytime you login</li>
			<li>Multipliers are fixed and everyone will get a reset on their next login</li>
				<dd>* We will be giving everyone 1 more rebirth to compensate</dd>
			<li>You will now get extra bounty mission completions for killing</li>
				<dd>* 50 Animals kills will count as 1 C rank Mission</dd>
				<dd>* 10 Large Animal Kills will count as 1 B Rank Mission</dd>
				<dd>* 5 Criminals, of any kind, will count as 1 B Rank Mission</dd>
			<li>Mission Descriptions from the Bounty Man have been rewritten to make sense</li>
			<li>Skin Reset added to ? menu, no longer needs a restart to complete</li>
			<li>Tsukuyomi freeze on death has been fixed</li>
		</ul>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hot Fix TY @Everyone Edition</button>
	<div style="display:none;">
		<ul>
			<li>Fixed Bunshin applying new weapon stats</li>
			<li>Fixed Map errors</li>
			<li>Bottom of waterfall is correctly placed as water now</li>
			<li>Attempted to reduce lag from picking up Materials</li>
			<li>Every single stat gain has been restructured in the back end</li>
				<dd>* None of the gains should be horribly different</dd>
			<li>Rebirth will now Morph further with each clan</li>
				<dd>* Aka Its not just your stats now, your clan affects your next life</dd>
				<dd>* Reminder, the Rebirth profile is an estimate</dd>
			<li>Rebirth Skills will now transfer on creation</li>
				<dd>* Stats will still transfer on Chuunin</dd>
			<li>Chickens once again correctly Spawn</li>
			<li>Cats reduced to 3 on the map, also actually spawn again</li>
			<li>Other Reports from the bug section</li>
			<li>NPC, Animals, and Mineral Deposits will now begin respawning after 15 minutes</li>
				<dd>* Was every 30 prior</dd>
				<dd>* Restructured how it spawns to ensure its not missed</dd>
			<li>Spawning areas will now advise nearby players once all have been killed/mined</li>
				<dd>* This only applies for that specific group</dd>
				<dd>* example if you kill all the rabbits it will apply to just them even if toads are still in view</dd>
			<li>Raised night brightness, so it shouldnt be as dark</li>
		</ul>
	</div>
</div>
<div>
	<button onclick="showReport(this)">3.91 - the 91 Construction Tips to Lie</button>
	<div style="display:none;">
		<ul>
			<li>Bounty Captain missions are now Item based</li>
				<dd>* This means the NPC you kill will have a chance of dropping items that will be used for the missions instead of your kill count</dd>
			<li>Village NPC actually attack the criminals now</li>
			<li>S5 NPC now attack back</li>
			<li>Clay actually works this time</li>
			<li>Rebirth now transfers a percentage of your skill stats (Mining, Fishing, Sword, etc)</li>
				<dd>* Transfer rate is half of the regular rebirth rate</dd>
			<li>Mission Man Items properly Checking</li>
			<li>Bug Fixes</li>
			<li>NPC will now have a bigger variance in stats</li>
				<dd>* The weakest have gotten weaker</dd>
				<dd>* The Strongest have gotten Stronger</dd>
				<dd>* All have seen a restructure to fit, hopefully, better</dd>
			<li>S Rank NPC have gotten a nerf</li>
		</ul>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hotfix 2 Lets Go @Felipin Edition</button>
	<div style="display:none;">
		<ul>
		<li>Criminals have all seen a roughly %40 reduction in stats, the defined steps in power per type</li>
		<li>Missions have been reorganized to reflect changes.</li>
		   <dd>* Animals are now all worth D Ranks</dd>
		   <dd>* Large Animals, Prisoners, and Ravagers are worth C Ranks</dd>
		   <dd>* Thieves and Missing Nin are worth B Ranks</dd>
		   <dd>* Murderers are A Ranks</dd>
		   <dd>* Villains, when they are enabled, will be S Ranks</dd>
		<li>Mining Skill has been buffed, you will now start with 20 it was 10</li>
		   <dd>* The chance of success has been buffed as well. you will now start with an 8% success rate</dd>
		<li>Village Nin will now attack all Aggressive NPC and Criminals</li>
		   <dd>* Aggressive NPC are any that attack you without provocation</dd>
		<li>Clay can now be collected on all dirt tiles as originally intended</li>
		<li>You should auto respawn if in sound 5 on login again</li>
		<li>Jail Checks currently disabled for Village bounties, as it needs more time to make it function</li>
		<li>NPC should now fully walk on water as intended</li>
		</ul>
	</div>
	<button onclick="showReport(this)">Hotfix 1 Thank You @Velociraptured Edition*</button>
	<div style="display:none;">
		<ul>
		<li>Handful of tweaks and bug fixes</li>
		<li>NPC can waterwalk again, seems this may still be spotty</li>
		<li>NPC will only attack as necessary, also seems spotty here</li>
		<li>Trees now drain stamina when you punch them</li>
		<li>Delivery mission reward buffed, 1k gold, 9 sps every 3 missions</li>
		</ul>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Update 3.90 - the 90 Myths of Success</button>
	<div style="display:none;">
		<li>New Map</li>
			<dd>* Visually looks the same</dd>
			<dd>* Areas function better</dd>
			<dd>* icons have seen some updating</dd>
			<dd>* The Entirety of Space between Rain and Rock is updated</dd>
			<dd>* New walk way from the back of Rain to Rock now Exists</dd>
			<dd>* All the side Villages have received Chuunin Buildings</dd>
			<dd>* Mist village now covered in fog</dd>
			<dd>* Samehada Moved</dd>
			<dd>* Executioner currently unavailable</dd>
		<li>Day and Night Cycle is back</li>
		<li>Destructible Trees are back</li>
			<dd>* Trees cannot be targeted by Jutsu or Bunshin</dd>
			<dd>* Can be punched, and hit by jutsu that don't require targets</dd>
			<dd>* Will create wood when destroyed</dd>
			<dd>* After being chopped down they will become regular Stumps until they respawn</dd>
		<li>Toggle_Practice_Mode verb has been added</li>
		<li>Minimap updated to include changes</li>
			<dd>* Minimap is now lighter and more accurate</dd>
			<dd>* Trees no longer show on the minimap</dd>
			<dd>* World Map also updated to reflect changes</dd>
		<li>New NPC</li>
			<dd>* Animals vave been added</dd>
			<dd>* Prisoners, Ravagers, Murderers, and Thieves</dd>
			<dd>* They will all spawn randomly accross the map</dd>
			<dd>* Stats for the human NPC varying based on their rank and age</dd>
			<dd>* Stats for Animals varies depending on their size</dd>
			<dd>* All randomly pawned NPC will attack you within view if attacked</dd>
		<li>Village NPC have received a visual update and new stats</li>
		<li>New Mission Man and Bounty Captain</li>
			<dd>* New Missions added for Item Collections</dd>
			<dd>* New Bounty Missions specifically for killing different NPC</dd>
			<dd>* Cat Mission has been updated, with 8 cats being on the map</dd>
			<dd>* Missions now provide Experience for leveling</dd>
			<dd>* Missions now provide SPS for every 5th Mission</dd>
		<li>Mining has been added</li>
			<dd>* Different levels of Ore have been added</dd>
			<dd>* Can be found across the map and punched to obtain</dd>
			<dd>* The better your skill the higher likelihood of finding ore</dd>
			<dd>* A Pick Axe improves your chances</dd>
		<li>Icons on players are handled in a new way</li>
			<dd>* This makes your saves immensely lighter and smaller</dd>
			<dd>* This means less lag on loading and throughout the game</dd>
		<li>Crafting Update</li>
			<dd>* Crafting is no longer using Feathers and Rocks</dd>
			<dd>* Now uses Ore, Ingots, and Wood for crafting</dd>
			<dd>* Crafting with different Ore will produce stronger weapons</dd>
			<dd>* Crafted items will be more valuable that found items</dd>
			<dd>* Fishing Rods can now be produced based on your crafting skill</dd>
			<dd>* Mission Man may request a specific crafted weapon</dd>
		<li>Gold gains have been nerfed</li>
		<li>Rebirths now support a Cap to how many are allowed within a wipe</li>
			<dd>* Currently set to 10</dd>
		<li>Updated Clan Creation images</li>
		<li>Kills are now tracked, Kills follow you through rebirth</li>
		<li>Swimming now trains Stamina</li>
		<li>Explosive Notes ground placement updated and damage Buffed</li>
		<li>Thrown Weapons Damage Buffed</li>
		<li>Literally hundreds of background changes</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hotfix Backlog</button>
	<div style="display:none;">
		<button onclick="showReport(this)">Hotfix 3.85 First of Many Edition</li></button>
		<div style="display:none;">
			<li>Goukakyuu properly travels through the owner</li>
			<li>Akimichi Stam should actually work this time</li>
			<li>Akimichi Bounds are adjusted now, this may not play well with punches</li>
			<li>New Layering for movement, this should allow for the players to properly hide behind objects even if oversized aka Akimichi growth</li>
			<li>Sound 5 Bug reported by Miroku</li>
			<li>New New Save failsafes, should help even further with rollbacks</li>
			<li>Mei Mei now properly tells you its actually running</li>
			<li>fixed from bug list</li>
		</div>

		<button onclick="showReport(this)">Hotfix 3.85 Rui Sucks Edition</button>
		<div style="display:none;">
			<li>Samehada door fixed</li>
			<li>Sharingan Dispel Fix</li>
			<li>Fish Freeze Fix</li>
			<li>Uzumaki Clan Caps fixed for VK (ask a gm to apply them if you have been a VK already)</li>
			<li>Saves Fixed</li>
		</div>

		<button onclick="showReport(this)">Hotfix @Rui the Majestic is not bad Edition</button>
		<div style="display:none;">
			<li>Reaper Changes</li>
			  <dd>* command is now shiki fujin</dd>
			  <dd>* Only damages the enemy immediately in front of you and your bunshins</dd>
			<li>Death should be back to 1, but who knows</li>
			<li>Parchment wont freeze you now</li>
			<li>Sharingan RFX shouldnt stack</li>
			<li>raiton armour RFX boost been nerfed, you will still get up to 50 but you need more lightning to get that now</li>
			<li>Fixed a problem with an unannounced technique being able to be used without a limit, glad no one found it too fast</li>
			<li>other things</li>
		</div>

		<button onclick="showReport(this)">Hotfix Welcome back @GhostDragon Edition</button>
		<div style="display:none;">
			<li>Death should be fixed, if not scream at Zac</li>
			<li>removed the save verb because players were spamming it</li>
			<li>created a method to test icons via subshop before purchasing them</li>
			<li>S rank bounties will now be announced globally</li>
			<li>Goukakyuu had its speed slightly increased to allow the gouk+renk combo</li>
			<li>whatever other small things I did</li>
		</div>

		<button onclick="showReport(this)">Hotfix Thank you @Felipin Edition</button>
		<div style="display:none;">
			<li>Hiraishin has a lot more restrictions now placed on it</li>
			<li>You can now delete Hiraishin marked locations</li>
			<li>A big list of small bugs reported either directly or indirectly</li>
			<li>Whatever else im forgetting</li>
		</div>

		<button onclick="showReport(this)">Hotfix I needed to drink to get past my not wanting to do this now edition</button>
		<div style="display:none;">
			<li>Hiraishin Mark should work</li>
			<li>Hiraishin Danmaku works again</li>
			<li>Movement should be better</li>
			<li>Added the AFK<li>Stam<li>Train verb</li>
		</div>

		<button onclick="showReport(this)">Hotfix Thank you @Qyuin Edition</button>
		<div style="display:none;">
			<li>Firudo and Kaze have a substantially raised timer</li>
			<li>Fan nin cooldowns have been lowered</li>
			<li>Minato had a lag creating bug from ryuuka that would infinitely speed him up</li>
			<li>other hidden thingamabobs</li>
		</div>

		<button onclick="showReport(this)">Hotfix @ImDuress Edition</button>
		<div style="display:none;">
			<li>Kagemane Freeze should be fixed</li>
			<li>Fixes for unannounced things</li>
			<li>Bug fixes from the list</li>
			<li>Reduced weight of some back end things to help with lag</li>
			<li>Mirrors should now delete correctly</li>
			<li>Adjusted things with the new Genjutsu to attempt to reduce stupidity</li>
			<li>Buffed Uchiha Gains</li>
		</div>

		<button onclick="showReport(this)">Hotfix Didnt do enough Edition</button>
		<div style="display:none;">
			<li>Significant backend update to Named NPC (Expect some bugs) This will be moved over to the Village npc as well in one of the next updates. They will behave lighter but may be a bit wonky</li>
			<li>Rasengan fix for blocked rest after usage</li>
			<li>Senshoku Fixes</li>
			<li>Meisaigakure no longer leaves you invisible</li>
			<li>Byakugan no longer stacks reflexes</li>
			<li>Tatsu no Ooshigoto counts uses correctly</li>
			<li>Afk stam wont be interrupted by Auto afk</li>
			<li>as always theres things i didnt note down</li>
		</div>

		<button onclick="showReport(this)">Hotfix Thank you @Canxio Edition</button>
		<div style="display:none;">
			<li>Palms Chakra training fixed</li>
			<li>Kakuremino Fixed</li>
			<li>Mirrors Fixed</li>
			<li>Sawa forest improved</li>
			<li>Sawa and Mirror porting fixed</li>
			<li>Kage Arashi properly now stuns</li>
			<li>Doumu and Air Palm no longer affect academy student</li>
			<li>Minato now respawns every 30 minutes</li>
			<li>Kagemane should disallow punches and bunshins </li>
			<li>You must now have a minimum of 70% of the users Genjutsu to dispel the new moves</li>
			<li>Inuzuka updates stats as necessary on the stat panel</li>
			<li>Potential fix done for the dog stats resetting</li>
		</div>

		<button onclick="showReport(this)">Hotfix Late night Adjustments</button>
		<div style="display:none;">
			<li>Hiraishin Dodge now costs 3x as much, both chakra and flashes</li>
			<li>Hiraishin auto punch now costs 2x as much</li>
			<li>Sawa fixed</li>
			<li>Mirrors not letting you rest Fixed</li>
		</div>

		<button onclick="showReport(this)">Hotfix Later Night Adjustments</button>
		<div style="display:none;">
			<li>Hiraishin Marks landmarks in a way that not longer create live references, what this means is that you wont get kicked out whe nsomeone logs in</li>
			<li>Oro will no longer perm freeze you if you kill him while your scared</li>
			<li>Finish Messages wont display garbage</li>
		</div>

		<button onclick="showReport(this)">Hotfix Even Later Night Adjustments</button>
		<div style="display:none;">
			<li>the standard trees have all been updated</li>
			<li>a second itachi was added</li>
			<li>the Saito verbs have been removed</li>
			<li>one of the new things has an updated unlock path</li>
		</div>

		<button onclick="showReport(this)">Hotfix @Kino Edition</button>
		<div style="display:none;">
			<li>S5 Fixed</li>
			<li>Bug Reports Fixed</li>
			<li>Added back end support for a new move coming in the next update</li>
			<li>i know i did more stuff today</li>
		</div>

		<button onclick="showReport(this)">Update 3.855 We are a little smarter edition</button>
		<div style="display:none;">
			<li>All the NPC now run off the new backend, this took a very very long time, expect problems</li>
			<li>A New Event has been added, 1 of you is very close to finding it</li>
			<li>Bug Fixes</li>
			<li>Added ability for GM to fix blind mobs</li>
			<li>Added ability for higher level GMs to delay auto reboot</li>
		</div>

		<button onclick="showReport(this)">Hotfix @Wizzy Edition</button>
		<div style="display:none;">
			<li>AI logic for attacking bunshins improved</li>
			<li>Viole now will counter if he's cornered</li>
			<li>improved logic for targeting further </li>
			<li>fixed ability for Viole to be summoned twice</li>
			<li>bunshin reflexes now behave differently</li>
		</div>

		<button onclick="showReport(this)">Hotfix @(c) fouette moi plus fort papa 's Fault</button>
		<div style="display:none;">
			<li>A handful of fixes for NPC targeting and response</li>
			<li>Boss NPC range drastically increased</li>
			<li>Jubaku avoids dense tiles now, but it looks ugly</li>
			<li>Kana is 1.5 second stun now</li>
			<li>The missing scroll jutsu will actually come back after relog now</li>
			<li>Hospital Revenge Stun no longer procs if you attached first</li>
			<li>Bounty Missions are now not possible on the same player repeatedly</li>
			<li>Cant enter or leave doors if you attack viole or minato</li>
			<li>Viole now correctly drops his Robes instead of the Kage Cloak</li>
		</div>

		<button onclick="showReport(this)">Hotfix Why Am I Up Edition</button>
		<div style="display:none;">
			<li>More Viole Fixes</li>
			<li>Example he wont damage himself anymore</li>
			<li>Hiraishin cant port to blank spots anymore</li>
			<li>Super new ultra great fantastic Layering for clothes and weapons, report the many bugs you find.</li>
			<li>You can set a custom layer for the Clothes if you want to set a specific outfit, the lower the number the higher it is displayed. Example 1 will display over 2</li>
			<li>Shinsu wont destroy trees and random objects, it also wont permanently leave you doing seals</li>
			<li>Fishing has been renamed to "Fishing: Type-of-Rod" to allow better macroing @salfic thanks for the report</li>
			<li>Names will properly delete on rebirth</li>
			<li>You will correctly lose kage on rebirth as well</li>
			<li>Removed that stupid sound test verb</li>
			<li>Boilerplate: i fixed more than whats on this list</li>
		</div>

		<button onclick="showReport(this)">Hotfix Actually Thank you @everyone Edition</button>
		<div style="display:none;">
			<li>Banking is updated to be Key Based, it will need to be purchased once on the key and function between the slots and rebirths, mostly thanks to Zac</li>
			<li>Safety Deposit Box has been re added, it also function cross slots and rebirths</li>
			<li>All unfound secrets have been disabled as i need a break right now, and more bugs will be found if they are.</li>
			<li>Hair layers correctly and removes as necessary</li>
			<li>Items on ground will layer correctly</li>
			<li>Weapons layer repaired</li>
			<li>Shinwonryu fixes, it now slows down the victim, doesn't last forever, has a real Cooldown, counts uses, and more</li>
			<li>GMs have been given an event creation verb for summoning players to an area for said event</li>
			<li>Hospital protection is cleared if you punch first</li>
			<li>Chat Height raised slightly for full screen view</li>
			<li>Ability to reset icons on the custom copies you have made</li>
			<li>Executioner Sword Skill damage gains have been doubled</li>
			<li>Viole is now further improved and shouldn't mass spam techniques as much as he did before</li>
			<li>Drastic, Massive, Super big changes to the back end. Bugs are potentially on tap here, All NPC have had their definitions updated among other things. Mark my words this is the biggest change ive done to the game even if you don't feel it while playing</li>
		</div>

		<button onclick="showReport(this)">Hotfix You're Welcome @Rui the Majestic</button>
		<div style="display:none;">
			<li>Added back the 4 missing villages (Let me know of any issues)</li>
			<li>Added ability for Village leaders to invite other players to their village, this will only work on Jounin and down players(this is preparation for missing nin)</li>
			<li>Added Rank protection that can be toggled by high level GMs, Currently set to 3 (This means a genin cant be damaged by a ANBU or higher) <li>By Request of @Rui the Majestic </li>
			<li>Fixed Viole so he doesnt crash the server</li>
			<li>Taget Select can once again target Players</li>
			<li>Other things as usual</li>
		</div>

		<button onclick="showReport(this)">Hotfix Thank you @Nyo Edition</button>
		<div style="display:none;">
			<li>Damage fixed for some NPC</li>
			<li>New Logic applied to jutsu collision that may or may not cause issues</li>
			<li>Tajuu Kage Bunshin Added for Uzumaki</li>
			<li>Bunshin can now rarely use some Ninjutsu</li>
			<li>Added a command to check how much SPS you have spent and on what (Check<li>SPS<li>Usage)</li>
			<li>Rebirth Estimates should now be more accurate</li>
		</div>

		<button onclick="showReport(this)">Hotfix the @Nyo errors</button>
		<div style="display:none;">
			<li>Village invite now correctly asks the person receiving the invite</li>
			<li>Bunshin Jutsu now correctly come from the bunshin</li>
			<li>Jutsu Clashes now shouldnt go through things they should and correctly damage those that should</li>
			<li>Bunshin now receive 40% of your Ninjutsu</li>
			<li>They also Receive slightly slower seal speed than the user</li>
		</div>

		<button onclick="showReport(this)">Hotfix I'm sorry @Kino</button>
		<div style="display:none;">
			<li>Grass, Sound, Rain, Waterfall all now give proper VK caps (Ask Wizzy or Zac to "Give Caps" "Kage" you if you were affected by this)</li>
			<li>They also now have their own Villagepoint screens</li>
			<li>They now apply the OOC badge as well</li>
			<li>Cant finish in S Rank anymore</li>
			<li>Henge on Giant and Shifo removed</li>
			<li>Tsunade GS attack frequency increased</li>
			<li>Bunshin Toggle Added for Nin (Toggle<li>Bunshin<li>Nin)</li>
			<li>Village invite Toggle aded (Toggle<li>Village<li>Invites)</li>
			<li>Multiple Layering issues repaired (Fan, Sand Gourd, Items dropped)</li>
			<li>Further Bank improvements</li>
			<li>NPC Rairyuu usage repaired</li>
			<li>Thorn requirement lowered (there is more than one requirement here)</li>
			<li>boiler player "Im sure im missing things"</li>
		</div>
</div>
<div>
	<button onclick="showReport(this)">Update 3.85 - 85th's lethal weaponry</button>
	<div style="display:none;">
		<li>Clay Class has been added</li>
		<dd>* Coolect Clay from dirt tiles, like in caves or near Rock Village</dd>
		<dd>* Each tiles has a chance to give you some until its depleted then it will recover over time</dd>
		<dd>* You will then need to infuse clay using <b>Kibaku Nendo</b> before it can be used</dd>
		<dd>* As you use more clay you will be able to carry more</dd>
		<dd>* Currently no Skin element shows the amount (mid wipe update will fix this)</dd>
		<dd>* <b>Kibaku Jirai</b> - Creates clay mines that can either be placed or Thrown, also can be set to auto trigger within range</dd>
		<dd>* <b>Shi Fo</b> - A Clay clone is created that slowly grows and walks towards target, user can then detonate for stead damage over time</dd>
		<dd>* <b>Kyukyoku Geijutsu</b> - Ingest your own clay, will use the remainder of your clay and self destruct</dd>
		<li><b>New Jutsu</b></li>
		<dd>* <b>Doton: Retsudo</b> - Damage everyone withing a radius with earth damage</dd>
		<dd>* <b>Doton: Yomi Numa</b> - Creates a large Swamp that slows down enemies and causes wounds over time</dd>
		<dd>* <b>Fuuton: Fusaijin</b> - Causes a stream of air to barrage everyone in front of you</dd>
		<dd>* <b>Fuuton: Fujin Heki</b> - Creates a wall of Tornados to reflect most damage, the user cannot leave its territory with walking</dd>
		<dd>* <b>Raiton: Tsuiga</b> - A tracking lightning panther</dd>
		<dd>* <b>Raiton Yoroi</b> - Raiton Cloak that helps you move faster and partially protects you, nullifies Shi Fo damage</dd>
		<dd>* <b>Raiton: Shibari</b> - Damages and stuns everyone within range</dd>
		<dd>* <b>Sutendomira</b> - Stuns the enemy, but to them it appears they are still able to move</dd>
		<dd>* <b>Tobenai Boko</b> - Creates a fake enemy that attacks the target, any damage to this enemey by the victim will be reflected fully on them</dd>
		<dd>* <b>Senshoku Kaze</b> - Creates 10 illusionary clones to only the victim can see. like tobenai they reflect damage and cant be dispelled</dd>
		<dd>* <b>Senshoku Firudo</b> - Creates 10-20 illusionary clones in range affects all in range but can be dispelled</dd>
		<dd>* <b>Kirabiyakana Kibarashi</b> - Creates 10-20 Clones that move, you will be invisible during this time</dd>
		<li>New Invisibiltiy across the board, this means that even if you invisible you will still see yourself. Eventually i will add a visual representation</li>
		<li>Fixed a gigantic memory leak with the npc AI, this will hopefully help with late boot lag</li>
		<li>Fixed a Save bug that would at times prevent the save prior to logging off</li>
		<li>Kagemane wont freeze you if it misses</li>
		<li>Renkoudan properly works with Fire jutsu</li>
		<li>Renkoudan can be fired diagonally</li>
		<li>Goukakyuu has a new icon and is 1 large object</li>
		<li>Mugen, and a few others, will now start on your tile instead of infront of you</li>
		<li>Minato will cause much less lag</li>
		<li>Minato's Hiraishin ability has been improved</li>
		<li>Raiton actually has something a Genin can obtain now</li>
		<li>Updated Jutsu without cards, i havent gotten them but im working on the rest</li>
		<li>Class back end has been renovated, now support much more</li>
		<li>Fan Nin Class updated to skill cards</li>
		<li>Endless amounts of back end changes to help the Quality of Life while playing</li>
		<li>6 Secrets</li>
		<li>This is an abbreviated list, i have added just a lot with this update that isnt listed</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Update 3.81 - The brickwork of 81</button>
	<div style="display:none;">
		<li>Furter fleshed and repaired the Rebirth structure</li>
		<dd>* You will now only gain rebirth stats for anything above your initial Academy Caps</dd>
		<dd>* GMs can now clear and wipe your rebirth profiles</dd>
		<dd>* A Mini wipe can be done by a Host where all rebirths are wiped and players are granted 300 Stat points</dd>
		<dd>* Catch up rates are only updated when a rebirth is completed
		<li>Caps are now functional and adding correctly for all Ranks and Villages</li>
		<li>Inuzuka icon has been repaired</li>
		<li>Kogeki will no longer crash the server if only 1 mirror exists within range</li>
		<li>Weights will no longer freeze you, and now apply correct move speed</li>
		<li>Sound 5 Mission should behave more appropriately when doing them in quick succession</li>
		<li>Renkoudan has an updated icon and function</li>
		<dd>* If the new underlying code is well received it will then be moved to all large projectile jutsu</dd>
		<li>Daitoppa and Renkoudan now both go through objects and living things</li>
		<dd>* Cannot go through dense map tiles</dd>
		<li>More backend things have once again been refined to improve stability further</li>
		<li>As always more things are fixed but not listed</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Update 3.80 - The might of 80</button>
	<div style="display:none;">
		<li>Hace completely changed the Stat caps</li>
		<dd>* Ranking up will adds to your current cap instead of changing it</dd>
		<dd>* Using Stat points increases your caps live</dd>
		<li>Completely remade Rebirth from the ground up</li>
		<dd>* Rebirth is now based on stats gained during your life</dd>
		<dd>* Host has the option to enable forced rebirths</dd>
		<dd>* You will be offered a rebirth every so often when you die</dd>
		<dd>* You can rebirth literally whenever you like</dd>
		<li>Itachi has been moved and his icon updated</li>
		<li>More Missing Nin added around the map</li>
		<li>Movement is now working off a Global system again</li>
		<li>Rank up Requirements are completely different</li>
		<li>Tourneys have been redone - Zaccur</li>
		<dd>* At this time only One on One and Battle Royale are present</dd>
		<li>Added the ability to see GM Logs even while they are offline</li>
		<li>Criminal History has been readded</li>
		<li>Grass Cliffs had a slight icon update</li>
		<li>Sand village has had a visual upgrade</li>
		<li>Mirrors will no longer let you Access off limit areas</li>
		<li>Skin updates to refine not change</li>
		<dd>* Damage Messages is now within settings</dd>
		<li>An ungodly amount of bug fixes</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hotfix 3.775 - The Redemption of 77</button>
	<div style="display:none;">
		<li>Fixed Sound 5 at large message</li>
		<li>Skin will now correctly position elements on changes</li>
		<li>Map will now grow based on screen size</li>
		<li>Max exists to prevent larger resolution advantage</li>
		<li>Negative SPS bug fixed</li>
		<li>Bug Explode does 10k per bug, no longer percentage based</li>
		<li>Minato no longer hits with Barrage while KO</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hotfix 3.77 - The Tweaks of 77</button>
	<div style="display:none;">
		<li>Removed cmd line and damage message toggle</li>
		<dd>* click the ooc button on skin to switch to cmd</dd>
		<li>Minimap can now be hidden by clicking the button on the bottom</li>
		<dd>* further improvements needed to support resizing</dd>
		<li>the skin as seen minor improvements</li>
		<li>Minato lag should be gone</li>
		<li>Login should be significantly faster and less laggy</li>
		<li>You can now choose how many SPS to give for the primary choices - Zaccur</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Hotfix 3.76 - Damages of 76</button>
	<div style="display:none;">
		<li>Visual Damage Messages are updated and are now toggleable</li>
		<dd>* Setting can be found in general settings</dd>
		<li>Move got another slight update</li>
		<li>Lag should be gone from logging in and NPC</li>
		<li>Sound 5 Kill Count should correctly Reset</li>
		<li>Air Palms, and Dai Senpuu will no longer move Mirrors and Bones</li>
		<li>Movespeed shouldnt reset on login</li>
	</div>
</div>
<div>
	<button onclick="showReport(this)">Update 3.75 - The Blizzard of 75</button>
	<div style="display:none;">
		<li>Yuki Mirrors have been revamped - 100% by GhostDragon & Zaccur</li>
		<dd>* - Mirror Cross quick attack has been added</dd>
		<dd>* - They can now manually create individal mirrors</dd>
		<dd>* - You can now create the mirror dome to trap your target</dd>
		<dd>* - Mirror dome can be used as a defensive technique</dd>
		<dd>* - You will now need to manually use the mirror attack command</dd>
		<dd>* - it will choose the dome as the primary or individual mirrors if no dome exists</dd>
		<dd>* - You can hide in your mirrors by clicking or walking into them</dd>
		<li>Carriage Driver has been revamped - by Zaccur</li>
		<li>You will now see yourself even if invisible</li>
		<dd>* - An indicator will be added in the next update to make it obvious</dd>
		<li>Inuzuka Dogs will match the user's reflexes</li>
		<li>Inuzuka players can now use Dispel while in Soutourou</li>
		<li>Nehan and Kana will no longer affect your own dog</li>
		<li>Juujin Bunshin should work whie dog is in inventory</li>
		<dd>* - Due to the code, i need support with this; let me know if any issues exist</dd>
		<li>The respawn timer has been flattened to 10 seconds regardless of rank</li>
		<li>Minato death Rewards have been repaired</li>
		<li>Will no longer double spawn from S5</li>
		<li>S5 Timer now resets on completion</li>
		<li>Anyone can get drunk now</li>
		<li>You should sober up without logging out</li>
		<li>Can once again use Shunshin in Sound 5</li>
		<li>Spy now alerts the player who is being watched</li>
		<li>Spy is now more organized to make spying a player easier</li>
		<li>Mute will now announce who did the mute</li>
		<li>Mission Tally verb informing you how many feather and B ranks you can turn in - GhostDragon</li>
		<li>I know i say this in most logs but there is a ton of Bugs fixed in this buil</li>
		<dd>* - With your help we have gotten so much resolved</dd>
	</div>
</div>

<div>
	<button onclick="showReport(this)">Hotfix 3.73 - The bug massacre of 73</button>
	<div style="display:none;">
		<ul>
			<li>Omg the bugs that are gone are endless</li>
			<li>Cloud no longer gets a speed boost just for existing</li>
			<li>Bandage and Explosion Note inventory Limits removed</li>
			<li>Removed limit on cats in inventory</li>
			<li>Removed Sword nin requirement to use Mist Swords</li>
			<li>Handful of Quality of Life fixes (example, Gourd will alert you when its full)</li>
			<li>Meditation Awareness disabled until next wipe</li>
			<li>Massively Lowered Gates Cooldown</li>
			<li>Minato only rewards you if you do more than 1 Million damage on him</li>
			<dd>* - If you allow him to heal himself your damage total gets reset</dd>
			<dd>* - His SPS reward has been raised to 100 and item reward chance is now 50%</dd>
			<li>The Get verb for all Items has been centralized, please report any bugs when attempting to pick up anything</li>
			<li>Eat verb has been organized where each type of object that can be eaten has a separate verb to allow for macros</li>
			<li>Sharingan and Byakugan drain now gives Chakra XP</li>
			<li>Adjust Soft caps to be softer past the cap</li>
		</ul>
	</div>
</div>

<div>
	<button onclick="showReport(this)">Pre 73</button>
	<div style="display:none;">
		============= Hotfix 3.72 The fishing pandemic of 72 =================
		<ul>
			<li>All commands revolving around fish have been revamped on the back end</li>
			<li>Equip Max and Cooldown reset Verbs - GhostDragon </li>
			<li>"Im Stuck" can no longer be used in village jail</li>
			<li>Sensory Ninja can no longer be sensed by others using sense area</li>
		</ul>
		=============Update 3.71 Colour Guilds Edition =================
		<ul>
			<li>Guilds are now updated with Guild Html</li>
			<li>Slot 2 now works again</li>
		</ul>
		=============Update 3.703 Lose Myst edition =================
		<ul>
			<li>Myst has been removed</li>
		</ul>
		=============Update 3.702=================
		<ul>
			<li>Moved S Rank Ninja to permanent new location</li>
			<li>Allowed the blue and red armour to be purchased</li>
			<li>Buffed Itachi, Sound 5, and village nin stats</li>
			<dd>* - * Itachi will now counter Kana, Ice blast, and Jubaku
			<li>Fixed coffin to not bug if user relogs</li>
			<li>Fixed Kagemane to allow multiple targets</li>
			<li>Fixed Akimichi Expansion stam bug</li>
			<li>Fixed Akimichi Shousen usage</li>
			<li>Fixed Mushi Swarm</li>
			<li>Changed Rebirth Requirements</li>
		</ul>
		=============Update 3.701=================
		<ul>
			<li>Removed Jutsu Cooldown after activating sawa forest</li>
			<li>Added new clothes, and hair</li>
			<li><b>Added an S rank level npc Go find them</b></li>
			<li>Adjust inuzuka to allow techniques on water</li>
			<li>Allowed Juujin Bunshin from inside Inventory</li>
			<li>Fixed Bug Explode</li>
			<li>Mushi swarm only drains 5% of the victims chakra, but places a tracking insect</li>
			<li>Added Jounin vests given on rank up</li>
			<li>Added varying Chuunin Vests</li>
			<li>Added 4 more Akatsuki Cloaks</li>
			<li>other things im sure ive forgotten</li>
		</ul>
		=============Update 3.7=================
		<ul>
			<li>Added Sawarabi Forrest</li>
			<dd>* - At max level, Buffs tai 80%, Reduces Damage 50%, Bones health is 90% and 45% respectively</dd>
			<li>Amaterasu has a much lower Cooldown, buffed damage, and causes wounds to the user</li>
			<dd>* - * Upgraded using SPS - Its XPensive</dd>
			<li>Added KageArashi for Naras</li>
			<dd>* - * Upgraded using SPS to a max of 3</dd>
			<li>Added Bakuhats uMushikui for Aburame</li>
			<dd>* - * Damage is based on the amount of bugs on the victim - probably really buggy</dd>
			<li>Changed Sawarabi, only works while forest is active</li>
			<li>Rebalanced Clan Gains</li>
			<li>Nara can no longer use techniques while in Kagemane</li>
			<li>Temporarily fixed the Rasengan spam</li>
			<dd>* - *Needs more work</dd>
			<li>Altered Shunshin to take real steps, range will increase with uses</li>
			<dd>* - * This should fix the shunshin speed bugs</dd>
			<li>Updated Cactus Icons</li>
			<li>Removed bandage purchase/get limit</li>
			<li>Made it so NPC dont attack you while moving around</li>
			<li>Adjusted Wind jutsu to not damage the user</li>
			<li>Alterered Yanagi to try and alleviate some bugs</li>
			<li>Expanded Forest of Death and removed static spawn points, spawn is now completely random in chuunin</li>
			<li>D mission man can no tell you your Stat Caps</li>
			<li>SPS now raise your caps as well as your stat</li>
			<li>You no longer do anything else while in the Stat point window</li>
			<li>Raised level limit to 600</li>
			<li>Raised SPS Gold gains to 600</li>
			<li>Lowered Kage mission requirements to 180</li>
			<li>Increased Kage level and Village Kage caps</li>

			<li>Level up gives you 4 without medition and 8 with</li>
			<li>Fixed Cursed Seal showing incorrect name when given</li>
			<li>Fixed Gold amount given from S Rank</li>
			<li>Fixed Clan Tournaments now counting No Clan</li>
			<li>Fixed Anbu Rebirth Stam Cab</li>
			<li>Fixed Chuunin Scrolls not dropping from NPC</li>
			<li>Fixed Akimichi Giant retained after logging out</li>
			<li>Fixed empty boxes for some clans in the Stat point window</li>
			<li>Fixed Targeting Bug</li>
			<li>Fixed world Status to save post reboots</li>
			<li>I know im missing a bunch of things</li>
		</ul>
		=============Update 3.6.12================
		<ul>
			<li>Changed to a global move engine</li>
			<dd>* - Work in progress</dd>
			<dd>* - Stam mountain now works</dd>
			<dd>* - Rocks now fixed</dd>
			<li>Rebirth Fixed</li>
			<dd>* - Needs more but good enough for now</dd>
		</ul>
		=============Update 3.6.10================
		- Removed heaven & earth scrolls from being on the map at start of each reboot

		=============Update 3.6.10================
		- Rebirth Fixed (and new save file system)
		- Fishing box fixed, can now get at any time after 100 fishing skill
		=============Update 3.6.9================
		- Chuunin exam time can now be customised. (Admin Feature)
		- All entrants of the Chuunin go to FoD even if only one person. (Must pass exam still)
		- The NPC in the chuunin exam will now give a timer for how long is left when waiting.
		- Fixed a massive lag issue on connection
		- S Rank door no longer procs twice
		- Changes to rebirth caps (Harder starts, better late game)
		- Added a message on rebirth


		=============Update 3.6.8================
		- Updated the NPC look description in the Acad (This was last patch but forgot to log it)
		- Fixed a bug with non clan creation showing earlier than XPected. (If you are a non clan before rebirth you'll get no gains after chuunin)

		=============Update 3.6.7================
		- Did some stuff and cant remember what.
		- Some version of rebirth system introduced. Probs glitchy
		- Hard(er) caps? (There is no limit ever, but the further away from your soft cap the less xp you get)
		This is an incentive to rebirth btw, higher caps each time. Wow! Amazing! So skilled!
		- Added Jamie to cont list. Sorry Jamie you were supposed to be there from the start <3
		- Nerfed no clan base gains (increased chakra for them though)
		- Buffed Aburame Nin gains
		- Buffed Uchiha Gen Gains
		- Buffed Tai Spec Tai/Stam (Lowered Nin/Gen)
		- Fixed a bug where some Genjutsu and Ninjutsu clan bonuses were incorrect.
		- Fixed a bug with world FPS (should change the speed of things... this'll be interesting)
		- Lots of soft cap changes... too many to list but they are there.
		- It's shitty but you can XPand the window more now, enjoy.
		- Warning provided if you have a character and try to create a new one
		- Can no longer log in with no character if you haven't yet created one
		- No Clan requires at least one rebirth
		- Can now customise FPS in game (admin feature)


		=============Update 3.6.6================
		- Fixed issue with sharingan saying 4 tomoe
		- Death Verb Added. I'll fix this later I guess


		=============Update 3.6.5================
		- Added ability to disable guild creation
		- S5 bridge no longer counts as water
		- Anbu masks are now masks again
		- Can now use the im stuck thing in ?
		- Fixed Rules in ?
		- Fixed player criminal history
		- Added extra security to special chicken area :)
		- Extended Tsukuyomi range by 1 tile & increased max time you can hold someone
		- No Clan updates (Lowered caps throughout all ranks, they were too OP)
		- Added warning to creating a character.
		- Added failsafe for no name
		- Fixed a lag issue with dogs and movespeed 0
		- Dog tai training increased at later stages of the game
		- Report a Bug / Give Suggestion buttons now work again
		- When you auto AFK, you will now also meditate if possible. (Thanks Jamie)

		=============Update 3.6.4================
		- Added ability to perma mute.
		- Just some minor admin stuff.
		- Ability to take skills away added

		=============Update 3.6.3================
		3/07/19
		- Updated damage text to appear above chickens and village nins
		- Damage text slightly adjusted.
		- Can actually learn sexy jutsu now
		- You can no longer spam rest your dog to instant health. (Sons of bitches...)
		- Added ability to toggle water effects
		- Other Admin Changes that I can't reveal xoxo
		- Changed double hit logic with stumps / cactus
		- Can no longer knock back admins. Sorry.
		- Visuals to show when wounds are being healed. Has science gone too far??

		=============Update 3.6.2================
		1/07/19
		- Fixed notice when joining guilds (No longer says you joined non-member)
		2/07/19
		- Fixed an issue with new clone count (for rank up) resetting each time you rest
		- Due to above issue, means people no longer get an additional clone. Sorry <3
		- Added damage text above players
		- Added unique damage text for cactus / stumps
		- DMG txt should also apply to clones.
		- Mute whispers by hitting the little chat button in the whispers tab

		=============Update 3.6.1================ (The actual 3.6)
		21/06/19
		- Added Fry to a login list (he knows what this is)
		- Added new countdown timer for reboots / adjusted logic a bit.
		- Can no longer walk on clones while wearing weights.
		- No longer lose icon when changing skin.
		24/06/19
		- Nerfed chakra gains for higher chakra (Still possible to get faster if you REALLY push for chakra but a LOT harder)
		- The higher you are up the waterfall when falling the more damage you'll take. (Less damage for lower regions now though)
		- Stats should update when waterfall climbing
		- Stats should update when sparring your clone (sorry forgot)
		- I think you can still do the punch animation when in giant form but it won't actually hurt yourself anymore on diag punches.
		- Change guild tag colour... (type Guild down the bottom right.. I CBF making skin changes sorry)
		- Oh regarding the colours, tag will always stay the same but the colour can be individual. Represent your guild however you like.
		- Guild tags can be 5 characters now. (Up from 4)
		26/06/19
		- Jiraiya will say pervy things again once you learn rasengan
		- Changed Rasengan Input (Now allows you to use all your chakra, the input is what % you want to use)
		- Changed damage numbers of Rasengan to reflect this change.
		- Fixed BunshinDestroyOne (You can click it now)
		- Bunshins now give less chakra back on dispel
		- Potentially slowed down the clone/rasengan bug? Iono...
		- Added new reboot logic for higher level admins :)
		- Sexy Jutsu (got bored)
		- GM * no longer has a space (because Fry complained a bunch)
		27/06/19
		- Updated Chidori chakra input to reflect Rasengan changes
		29/06/19
		- Updated dogs to match the players current cap stats.
		- Updated dogs to have half of the players reflex stat
		- Updated the way dogs train. No more picking them up to "claim" your stats.
		- Added "No Clan" as an option
		- Changed soft caps for "No Clan" to be unique throughout gameplay.
		1/07/19
		- Sub shop (icon giver) can be enabled/disabled with a command
		- Clones now start at 2, you unlock more at higher ranks
		- Changed clones for no clan (regarding unlock changes above)
		- Clones get less reflexes
		- Now possible to learn Kage Bunshin at Chuunin with high enough stats, easier to gain at even higher ranks
		- Changed % stats for kage bunshin for non-clans. hehe


		=============Update 3.5.14================ (Apparently also 3.6)
		- Sharingan now shows level. (I don't know if I like this method of it but 'eh giving it a try.
		- Fixed the fisher bug...
		- Gates now scales Cooldown by what gate you open. (I think)
		- Improved animation of standing on water (essentially fades out and stuff.. thanks fry xP)
		- Cooldown message is now minutes and seconds if over 60 seconds. (Should I make this a toggle??)

		=============Update 3.5.13================
		- Restored old level system for now
		- Tweaked stat points, pushed a lot more to the meditated stats rather than generic (Make sure to meditate first!)
		- Lowered XP curve
		- Host has ability to control CS rates
		- Potentially this version has a lot of issues, I didn't check if I was half done with things.... :)
		=============Update 3.5.12b===============
		12/01/18 (Quick Update)
		- Updated feather icon
		- Can now walk over feathers to collect.
		- Added Cooldown messages to Jashin skills
		- Updated messages for Jashin Skills
		=============Update 3.5.12===============
		11/01/18
		- Fix for seals not going away when reverting from giant form
		- Basic attacks now deal a minimum % of damage if the difference is too high. No more 1 damage.
		- Few changes to palms
		- Mirrors updated (Need feedback on this..)
		- Admins now have their own button to open verbs rather than using the "?" button.
		- Cheaters no longer benefit from meditating & take triple damage. Read the rules <3

		=============Update 3.5.11===============
		11/01/18
		- You will always get fish from auto fishing.
		- Fixed Calories gained from eating fish. Also gained from mediating.
		- Improved Orochimaru AI, should be a bit smarter now.(No more running into a wall to get to you)
		- Fix for giant form attacking
		- Initial release of some of the Akimichi skills for beta testing.

		9/01/18
		- Can no longer henge class ninjas
		- Updated Hidan icon
		- Updated Jashin learn requirements

		8/01/18
		- Removed level requirement from Tsukuyomi
		- Fixed self harm damage of jashin, incorrect damage values - also increased delay

		=============Update 3.5.10===============
		7/01/18
		- You can no longer jubaku out of mirrors if you are the target
		- Added a timer to Sound five mission (So you can find out how long is left before you can enter)
		- Removed shunshin ability from S5
		- A Scythe for Jashin is now registered for sword skill
		- If the target dies, the circle for Jashin will now disappear.
		- Jashin self harm now includes ninjutsu damage.
		- Changed mirror logic (Not released...)

		=============Update 3.5.9===============
		5/01/18
		- Sensatsu now works with practice (Pretty sure this is the only Clan jutsu that has this...)
		- Sensatsu had some minor icon changes
		- Waterwalking properly starts at 38cc
		- Jashin symbol now disappears when walking off it or if you log out, not prior to the jutsu ending.
		- You can move towards the giant tree to tree climb rather than use the climb verb.
		- Removed level from mangekyou requirement. Increased stats required.
		- Modified clan gains
		- Added Akimichi clan gains
		- Increased stat points obtained from missions
		- Added Jashin to the game - TESTING!
		- Players shouldn't be able to escape mirrors by running as easily anymore.

		4/01/18
		- Few changes to Yuki & Aburame starting stats
		- Kirigakure now works with practice

		3/01/18
		- You no longer gain benefits from the water/sand inside the sand nins house.
		- Fixed genin exam still completing even if you got kicked out of the exam
		- Carriage drivers weren't updating the players village even though they now deliver INSIDE the village.
		- Few other changes to drivers. (They like Admins now too)
		- Fixed strange issue with waterfall village Acad building.


		=============Update 3.5.8 LIVE 1/1/18===============
		1/01/18 - HAPPY NEW YEAR
		- I had a massive new year party and didn't get things finished... but people complaining so uploading this
		- Removed ability to level until end of the week or so...
		- Lowered all gains until end of the week or so...

		25/12/17
		- Changes to Orochimaru attacks, also sharingan should help in a certain aspect of this fight now.
		- Fixed cost of crafting shuriken
		- Removed Function of Icon Giver (Needs adjustments but thanks for testing!)
		- Few changes to the shuriken collection messages.
		- Shuriken Jutsus now update the inventory of the player to reflect the loss in shurikens.
		- You can no longer dupe shuriken collection with shuriken jutsus


		24/12/17
		- Kage bunshin limit can now be set to 0 to disable bunshins (Only for Kage Bunshin) (How Practice button currently works)
		- Practice mode no longer works on kage bunshins. (Should help with sparring)
		- Acads can no longer kick other players.
		- Few improvements to sending bunshins to attack.
		- Shousen can only be applied to other players directly in front of you.
		- I advise against healing enemy NPCs....

		19/12/17
		- Village nins have a wider variety of hair selections now. Enjoy afro hairstyles!


		14/12/17
		- Admins can no longer switch off their OOC
		- Players can still see admins talking in the OOC if their chat is switched off

		13/12/17
		- New characters should no longer start invisible to others, also you should be able to see your skin in character creation.

		12/12/17
		- Byakugan now requires at least 50 chakra to activate.
		- Byakugan now gains perma vision (Will always have an overlay) when it is maxed. This allows them to always see a player behind objects.

		10/12/17
		- Shunshin is now toggled on when learning and will remember your preference.
		- Byakugan is now able to see players while they are invisible even behind objects.
		- Updated admin login.

		=============Update 3.5.7 live 9/12/17===============
		- Updated SoM to Beta Version 512.1398

		=============Update 3.5.6 live 6/12/17===============
		- Moved web servers, better connection to database on a 3 year plan

		=============Update 3.5.5 live 1/12/17===============

		1/12/17
		- A village kage can kill their villagers without losing kage. Might create something better later
		- Admins no longer drop gold if they die for any reason. (Admins like gold... leave us alone)
		- Reduced damage from allies while in S Rank
		- Fixed a bug with obtaining shurikens from stumps, also it now displays how many you got back.
		- A bunch of disabling jutsus will no longer work on players within the S rank. <u>If you find one that does, please let me know!</u>
		- Changed how elements work. You get to choose both elements in any village, however you'll get a bonus start if your elements align with the village.
		- Disabled friendly fire to village on creation. (You can toggle it on but it doesn't confuse new players anymore)

		30/11/17
		- Fix for Rasengan knockback doing strange things
		- Jailed players can no longer take part in the arena.
		- Fixed the bug where you could run into a wall to train Stamina/collect rocks.
		- Increased rules message size on login.
		- Added rules to ? and a popup  on creation

		29/11/17
		- Small change to uploaded files to list them under the users key.

		=============Update 3.5.4 live 28/11/17===============
		28/11/17
		- Go check the clothes dealer, early christmas present. (TESTING THIS OUT ONLY! No promises on keeping it)
		26/11/17

		- Fix for Kirigakre not removing overlays if the user logs out
		- <s>New Jutsu: Suiton: Baku Suishouha</s> Redacted

		=============Update 3.5.3 live 26/11/17 ===============================================================
		26/11/17
		- You now need to meditate for bonus SP on level up after 10 levels (up from 5)
		- Tank damage applied & all logic for when you can use it has been set.
		- Changes to level up experience & gains
		- Shurikens have a chance to get stuck in a stump. You can collect these with the Action verb.
		- Shuriken prices have been increased due to the above change.
		- More hurs on that special thing xoxo
		- Death gate *should* instant kill once it's over now
		- Removed trading again, it shouldn't have been in yet sorry.
		- Brands now get logged as an admin action
		- S Rank Timer should be fixed

		25/11/17
		- A LOT OF HOURS AGAIN SPENT ON SOMETHING SPECIAL.. *RAGE*
		- Minor fix for GladiatorMedal having an incorrect requirement (Did this ever work? Who knows)
		- Auto Chuunin requirements have changed a bit. ALSO you won't get it unless you attempt Chuunin at least once.


		24/11/17
		- Fixed Kanashibari endless stun if user logged out
		- Fixed for shadows applying twice (Should be good from now on...)
		- A LOT OF HOURS SPENT ON SOMETHING SPECIAL... JESUS

		=============Update 3.5.2 live 23/11/17==================================================

		23/11/17
		- Fix for obtaining endless missions
		- More Admin logging features
		- Few changes to creation for Admins
		- Admins can no longer be killed by players attacking them (Admin characters are no longer allowed to "Play" the game)


		22/11/17
		- Extended death gate timer
		- Admins now have their own spawn/village (This is essentially something to stop GM's playing on their GM accounts)
		- More work on Admin Improvements
		- Few changes to rank requirements
		- C Missions are a pain, I've reduced C missions as a requirement, but the "Total" missions required are now higher.
		- Admin verbs now log to a database (This means players will have history stored through wipes)
		- Personal timers (Such as jail time/Mute time) would not go down when marked as AFK


		=============Update 3.5.1 Live 21/11/17 =====================================
		21/11/17 - Iono why I did so many terms today but I did...
		- Fixed an issue with sparring, you should NOW be able to spar anywhere.
		- Fixed an issue with edit (No GM's, you can't change icons)
		- Fixed an issue with Meditate, sorry guys, 30k chakra day one is not allowed...
		- Added some bonus logic to Sparring
		- Fixed an issue where dogs running (not standing) on water would drain a lot of Stamina
		- Jailers should always be walking when someone is in jail now... no more lazing around.
		- Fixed issue where mutes & jails under 1 minute would glitch out
		- Fixed issue with dispel other (Could spam bunshins really fast)
		- Fixed an issue with shunshin and water walking
		- Worked on Gates a bit more, should last longer. Death gate should feel like a "I'm giving up my life for this!" kind of moment.
		- Gates now update stat panels, you can see what you get!
		- Increased Kaguya gain multipliers

		19/11/17
		- Fixed names not allowing spaces


		=================== Major Update 3.5 Live 19/11/17 ===========================================
		19/11/17 (I legit did this for around 13 hours straight - you are welcome)
		- Added S Rank Checker to Time Check
		- Changed length of time for Chuunin / S Rank to start after a reboot
		- Added a way for players to view remaining time left on their jail/mute (Check the same timer as Genin/Chuunin)
		- Fixed jail/mutes to properly work over relogging/reboots.
		- Auto labels people as afk if they haven't done ANY action (including talking) in over 10 minutes.
		- Admins can't undo higher level Admins work (They also can't mess with higher levels)
		- Fixed shadows stacking when you get teleported to the hospital (IE unjail)
		- Moving while AFK now removes your AFK status rather than blocking movement.
		- Players can no longer go into rest while inside a shadow!
		- Increased some reflection damage
		- TaiSpec Clan now uses skill cards! Yay, still need icons for them though!
		- Added new icons for Gates Skill
		- Fixed shadows bugging on creation

		- Some creation stuff for a few Admins
		- Some map details (Mainly at 2 2 2)

		21/07/17
		- @GM or @Admin in ooc will alert any online admin.
		- Mugen Sajin should just pass through the owner without damage now.


		19/08/17
		- New Create verb (Credits go to SinJ) which is going to be AWESOME for events!

		18/07/17
		- Fixed up names.
			Names can no longer have any special characters.
			Names can no longer have spaces at the start and end.
			Names now remove capital letters if not the beginning of a new word
		- New Admin handling.(better determines abilities)
		- Fixed a major bug with movement. Move() was being called millions of times for no reason at times. This should help a lot with reducing server lag!!
		- Increased FPS to 50
		- Fixed game settings not changing when wiping. This includes Guilds, Names, Kage, etc
		- Changes to Tournaments, should now give what they say they do.
		- Fixes for attack, can now continue to punch.
		- Finished Implementing new H2H ability. (I am sure you will figure it out <3)
		- Single click now targets while double click uses "Look"
		- Acads can no longer attack anything aside from stumps.
		- Using Look on a Village kage will now show their placement.
		- Changed the logic on Meditate. Should now feel a lot better for gains.
		- If you walk when meditating, you stop meditating.


		17/07/17 (I am literally writing this at 7:17AM on the 17/07/2017. Cool haha
		- Changed logic for jail and mute. Now continues counting down after relog.
		- Working on a lot of Admin stuff, slowly changing the verbs to better organise Admins (and plan to log everything)
		- <b>Removed the new movement update. Too many problems, hopefully I can get it back eventually</b>
		- New conditions on player Names.


		16/07/17
		- Genin exam fixed to hide exam when collected.
		- Punching below Stamina will now will the player in bold and reduce wounds each hit! Rest up
		- Bunch of changes to the server verification for testing with a linux server.
		- Shurikens now bounce off other shurikens.

		15/07/17 (While on a flight)
		- Genin exam can now be completed whenever. It is individual and no longer announces to the world when you pass.
		- Failing the genin exam will result in a 30 minute time out before you can attempt it again.


		14/07/17
		- Changes to spar logic for tai gains. (Overall increase, but mainly improved for bunshin spar)


		12/07/17
		- Fixed dogs Stamina draining until death after they leave the water.
		- You now heal before the 1v1 Chuunin battles
		- You can obtain chuunin automatically with high enough stats. (Needs high Stamina and total stats)
		- Fixed shadow on Chuunin/Genin/Arena exit.

		9/07/17
		- Clone sparring fixed to give around the same reflex as normal spar.
		- Sparring XP has been lowered however now scales with extra weights.
		- Basic attacks now spar instead when both players have "Practive Mode" toggled on.
		- You can now spar anywhere you want!
		- <b><u>Panda now properly kills anyone who dares attack him. RIP Man.</u></b>

		20/06/17
		- Fixed Shadows release timer being super slow
		- Changed Water prison, now increases chakra usage over time. (Intended to stop players resting while using it)
		- Resting will now instantly fix negative numbers on stam/chakra
		- Possible fix for getting stuck in Arena when winning
		- Changed Carraige Driver, no longer requires a map but cost increases with rank. (Free for acad)
		- Increased Death gate timer to 60 seconds. Also increased reflexes given to gates.
		- If you are under 38cc you can still swim
		- Fixed kage label in ooc chat.
		- Nehan can't be used in shadow, also fixed some shadow bugs
		- New skillcard for Nara
		- Jutsu list can now be sorted by elements, clan, class
		- Fixed a bug where some skins were showing incorrect animations.

		=========================== END OF MAJOR UPDATE 3.5 =======================================================

		=================== Live 15/06/17 =========================================

		- Dogs can no longer kill Acad
		- Nara's can no longer move when using shadows.
		- Nara Shadow speed has been slightly increased.
		- KageKubiShibari icon added + dmg increased. (Tai is now more effective as counter)
		- Added shadow to big tree (Also handle this as an entire entity rather than 28 individual parts)
		- Reworked Dynamic Marking to be what was intended. Targets last 2 minutes but have exact tracking on minimap.
		- Village kage now have a unique colour in OOC. They also get a hat, which is cool I guess.

		=================== Live 14/06/17 =========================================

		- Dogs can now walk on water until they drop below 20% health. They do have a constant Stamina drain while on water though!
		- Brands now also reduce players training by 80%. Don't cheat!
		- Fixed "RanshinShou" bug where the nerves never healed.
		- Fixed dogs placing and unable to attack. Now bases it off your own protection state. (If you aren't in a safe zone, nor are they)
		- Dogs can now be numerous colours! Find the colour you want in the world before first taming OR simply pay a fee to change the colour!
		- Changed weather settings (Aiming to lessen the annoyance of some colours) and set change timer to 7 minutes
		- Changed a few things about Executioner Blade
		- Kage Bunshin now spawn in a random place near the user.


		===================== LIVE 12/06/17 =================================

		- Added new skins for Byond Members. Byond Members also get a unique login colour!
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
		-Dog Stat Window now updates when dog gains Stamina and not just when they lose it.
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


		- Class Jutsus can be learnt again for free if lost. (Go to Prof Ninja)
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
			Lots of new hair styles including three XPensive styles.
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
			Mugen self damage caused positive Stamina
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
			toggleEXP commands - prevents level XP (requested)
	</div>
</div>
</body>
</html>
		    "}