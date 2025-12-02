mob/verb
	StatsButton()
		set hidden=1
		if(!usr.client||!(usr.loggedin)) return
		winset(usr,"mainwindow.Panel","left='statpane'")
	ProfileButton()
		set hidden=1
		if(!usr.client||!(usr.loggedin)) return
		usr.ViewProfile(usr)
	WorldMapButton()
		set hidden=1
		if(!usr.client||!(usr.loggedin)) return
		usr.ShowLocation(); winshow(usr,"WorldMap",1)
	BingoBookButton()
		set hidden=1
		if(usr.whopause) return
		if(!usr.client||!(usr.loggedin)) return
		usr.whopause=1; spawn(70) usr.whopause=0
		usr.UpdateBingoBook()
		winshow(usr,"BingoBook",1)

	AdminWindow()
		set hidden=1
		if(usr.GM)
			winshow(usr,"AdminWindow",1)