mob/var/tmp/receiveingpopup
var/hidepopups

mob/VerbHolder/Admin/Level2/verb
	MasterTogglePopups()
		set category="Staff"
		set name="Master Popup Toggle"
		if(hidepopups) {usr<<"popups now: on"; hidepopups=0}
		else {usr<<"popups now: off"; hidepopups=1}

mob/proc
	Popup(PU_type,var1,var2,XPiryinseconds)
		set waitfor = 0
		if(hidepopups||popupsoff||!client) return
		src<< Popup	//sound
		receiveingpopup=PU_type
		if(!var1) var1="?"
		if(!var2) var2="?"
		if(!XPiryinseconds) XPiryinseconds=30
		switch("[PU_type]")
			if("genin") winset(src,null,"PopUpP.Title.text='Genin Exam'; PopUpP.SubText.text='at the Ninja Academy'; PopUpP.About.text='Starting in [var1] minutes'")
			if("chuunin") winset(src,null,"PopUpP.Title.text='Chuunin Exam'; PopUpP.SubText.text='[ChuuninVillage] Village'; PopUpP.About.text='Starting in [var1] minutes'")
			if("Event") winset(src,null,"PopUpP.Title.text='Event'; PopUpP.SubText.text='[var1]'; PopUpP.About.text='Starting at any local arena in [var2] minutes'")
			if("konoha invasion") winset(src,null,"PopUpP.Title.text='S Rank Quest'; PopUpP.SubText.text='Invasion of Konoha'; PopUpP.About.text='Starting in [var1] minutes'")
			if("gain kage") winset(src,null,"PopUpP.Title.text='Promotion'; PopUpP.SubText.text='[NinjaRank]'; PopUpP.About.text='You are now the [NinjaRank]'")
			if("lose kage") winset(src,null,"PopUpP.Title.text='Demotion'; PopUpP.SubText.text='[NinjaRank]'; PopUpP.About.text='You have been stripped of your rank'")
			if("swap kage") winset(src,null,"PopUpP.Title.text='Demotion'; PopUpP.SubText.text='[NinjaRank]'; PopUpP.About.text='The [var1] has logged in'")
			if("add bingo book") winset(src,null,"PopUpP.Title.text='Bingo Book'; PopUpP.SubText.text='[var1] has added you to the [var1:Village] Bingo Book!'; PopUpP.About.text='[var1:Village] Bounty: [Bounty[var1:Village]]'")
			if("increase bingo book") winset(src,null,"PopUpP.Title.text='Bingo Book'; PopUpP.SubText.text='[var1] has increased your bounty in the [var1:Village] Bingo Book!'; PopUpP.About.text='[var1:Village] Bounty: [Bounty[var1:Village]]'")
			if("guild war") winset(src,null,"PopUpP.Title.text='Guild War'; PopUpP.SubText.text='[Guild] vs. [var1]'; PopUpP.About.text='Guild War starting in 20 seconds'")
		spawn(XPiryinseconds*10) PopupExpire(PU_type)


	PopupExpire(PU_type)
		if(PU_type==receiveingpopup && client)
			winset(src,null,"PopUpP.Title.text=''; PopUpP.SubText.text=''; PopUpP.About.text=''")