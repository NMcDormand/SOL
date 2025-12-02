mob/proc/
	RatioCheck()
		if(!PlayerKills)
			ratio=(-deaths)
		else if(!deaths)
			ratio=PlayerKills
		else
			ratio=PlayerKills/deaths

	Arena_RatioCheck()
		if(!ArenaWins) ArenaRatio=(-ArenaLosses)
		if(!ArenaLosses) ArenaRatio=ArenaWins
		else ArenaRatio=ArenaWins/ArenaLosses

