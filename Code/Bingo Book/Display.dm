mob/proc/UpdateBingoBook()
	for(var/obj/BingoBook/B in src) del(B)
	if(!Bounty) Bounty=new()
	src << output(name, "BingoBook.self_name")
	src << output("\icon [AcquireSelfImage(src)]", "BingoBook.self_image")
	src << output("[Rank_Calculator(src)] Rank", "BingoBook.self_rank")
	if(Rank2Num(NinjaRank) > 7)
		src << output(Bounty["Cloud"]*2, "BingoBook.self_cloud")
		src << output(Bounty["Grass"]*2, "BingoBook.self_grass")
		src << output(Bounty["Leaf"]*2, "BingoBook.self_leaf")
		src << output(Bounty["Mist"]*2, "BingoBook.self_mist")
		src << output(Bounty["Rain"]*2, "BingoBook.self_rain")
		src << output(Bounty["Rock"]*2, "BingoBook.self_rock")
		src << output(Bounty["Sand"]*2, "BingoBook.self_sand")
		src << output(Bounty["Sound"]*2, "BingoBook.self_sound")
		src << output(Bounty["Waterfall"]*2, "BingoBook.self_waterfall")
	else
		src << output(Bounty["Cloud"], "BingoBook.self_cloud")
		src << output(Bounty["Grass"], "BingoBook.self_grass")
		src << output(Bounty["Leaf"], "BingoBook.self_leaf")
		src << output(Bounty["Mist"], "BingoBook.self_mist")
		src << output(Bounty["Rain"], "BingoBook.self_rain")
		src << output(Bounty["Rock"], "BingoBook.self_rock")
		src << output(Bounty["Sand"], "BingoBook.self_sand")
		src << output(Bounty["Sound"], "BingoBook.self_sound")
		src << output(Bounty["Waterfall"], "BingoBook.self_waterfall")
//------------------------------------------------------------------
	var/entries=0
	for(var/mob/O in BingoBook)
		if(!O.BingoBookAssociations) O.BingoBookAssociations=new()
		if(O.BingoBookAssociations[Village])
			var/obj/BingoBook/disp=new(src)
			disp.icon_state=Rank_Calculator(O)
			disp.Link=O
			disp.name=O.name
			if(client)
				winset(src, "BingoBook.Selection_Grid", "current-cell=[++entries]")
				src<<output(disp, "BingoBook.Selection_Grid")
	if(client) winset(src, "BingoBook.Selection_Grid", "cells=[entries]")

proc
	AcquireSelfImage(mob/S)
		var/obj/BingoBook/pic/o = locate() in S
		if(o) del(o)
		var/obj/BingoBook/pic/self=new(S)
		var/icon/s=new(S.icon)
		for(var/obj/x in S)
			if(x&&x.icon&&x.worn)
				s.Blend(x.icon,ICON_OVERLAY)
		var/Overlay_Obj/OO = S.EyeIcon
		if(OO)
			s.Blend(OO.icon,ICON_OVERLAY)
		OO = S.HairIcon
		if(OO)
			s.Blend(OO.icon,ICON_OVERLAY)

		if(self) {self.name=null; self.icon=s}
		S.SelfImage=self
		spawn(2) del(self)
		return self