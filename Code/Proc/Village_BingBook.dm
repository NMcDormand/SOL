mob/proc/VillageBB_KillMe(mob/victim)
	var/B = "[victim.Village]Bounty"
	if(vars[B]<5000) vars[B] += 300
	HitListCheck(victim)
mob/proc/HitListCheck(mob/v)
	if(v.Village=="Sand")
		if(istype(src,/mob/player)&&!(src in SandHitList))	SandHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in SandHitList)) SandHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) SandHitList+=Master
	if(v.Village=="Leaf")
		if(istype(src,/mob/player)&&!(src in LeafHitList))	LeafHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in LeafHitList)) LeafHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) LeafHitList+=Master
	if(v.Village=="Rain")
		if(istype(src,/mob/player)&&!(src in RainHitList))	RainHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in RainHitList)) RainHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) RainHitList+=Master
	if(v.Village=="Grass")
		if(istype(src,/mob/player)&&!(src in GrassHitList))	GrassHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in GrassHitList)) GrassHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) GrassHitList+=Master
	if(v.Village=="Cloud")
		if(istype(src,/mob/player)&&!(src in CloudHitList))	CloudHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in CloudHitList)) CloudHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) CloudHitList+=Master
	if(v.Village=="Rock")
		if(istype(src,/mob/player)&&!(src in RockHitList))	RockHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in RockHitList)) RockHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) RockHitList+=Master
	if(v.Village=="Waterfall")
		if(istype(src,/mob/player)&&!(src in WaterfallHitList))	WaterfallHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in WaterfallHitList)) WaterfallHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) WaterfallHitList+=Master
	if(v.Village=="Mist")
		if(istype(src,/mob/player)&&!(src in MistHitList))	MistHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in MistHitList)) MistHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) MistHitList+=Master
	if(v.Village=="Sound")
		if(istype(src,/mob/player)&&!(src in SoundHitList))	SoundHitList+=src
		if(istype(src,/mob/Hittable/Command/Clones)&&!(Creator in SoundHitList)) SoundHitList+=Creator
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet)&&!(Master in SandHitList)) SoundHitList+=Master
