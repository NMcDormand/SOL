mob/var/tmp
	isTrading=0; hasAccepted; invitePending; tradingWith; tradeitems=0;


obj
	//If the item is up for trade or not
	var/tmp/upForTrade=0;

/** Note!
	Other parts relating to how this System works can be found within
	"InventoryButtons.dm" and "UpdateInventory.dm"
*/

mob/verb
	ConfirmTrade()
		//Set up partner
		var/mob/player/partner = tradingWith

		//If both players have opted to trade, make the trade
		if(hasAccepted && partner.hasAccepted)
			makeTrade(partner)
			CloseTradeWindow(partner)
			return

		if(hasAccepted)
			hasAccepted=0
			winset(src, "Trade.tradeAccept", "is-visible=false")
			winset(partner, "Trade.tradeAccept2", "is-visible=false")
		else
			hasAccepted=1
			winset(src, "Trade.tradeAccept", "is-visible=true")
			winset(partner, "Trade.tradeAccept2", "is-visible=true")

	inviteAccept()
		setUpTrade(tradingWith)
		retractInvite()

	inviteDecline()
		tradingWith=0;
		retractInvite()

	//Verb to close the trade window
	CloseTrade()
		usr.CloseTradeWindow(usr.tradingWith)

mob/VerbHolder
	verb
		Trade(mob/player/M in view(6))
			set name="Trade"
			set desc="Initiate a Trade with another player"

			return;

			//Check conditions
			//if(((M == src) || !(istype(M, /mob/player)) || isTrading || M.isTrading || M.invitePending ||isTrading)) {return;}

			//If the person trying to trade has an invite, remove it.
			if(invitePending) retractInvite()
			//If none of the above, set up initial trade values (required for trade request)
			invitePending=1; M.invitePending=1; M.tradingWith=src;

			//Send Invite
			M.sendInvite(src);


			//Timer for someone to accept

			var/timerCheck=0
			//Reference
			timeRef
			if((M.invitePending) && (M.tradingWith==src) && !(isTrading && M.isTrading))
				//Check every second to see if the person has accepted.
				if(timerCheck < 20)
					sleep(10) //sleep for 4 seconds
					timerCheck++
					goto timeRef // Return to timer
				else //If we have used up our attempts, retract the invite
					invitePending=0;
					M.tradingWith=0;
					M.retractInvite()

mob/proc
	setUpTrade(mob/M)
		//Reset Objects for both players
		for(var/obj/T in (src||M))
			if(T.upForTrade) T.upForTrade=0


		//Set First player to trading.
		usr.ShowTradeWindow(M)
		usr.closeInventory(M)

		//Set Second player to trading
		M.ShowTradeWindow(usr)
		M.closeInventory(usr)


		//Update both player trade windows
		usr.updateTradeWindow(M)
		M.updateTradeWindow(usr)


	retractInvite()
		invitePending=0;
		winset(usr,"mainwindow.topsection","right=VillagePoints")

	sendInvite(mob/trader)
		winset(src,"mainwindow.topsection","right=InviteAlerts")
		winset(src,null,"InviteAlerts.About.text='[trader] has sent an invite'")

	undoTradeLock()
		var/mob/player/partner = tradingWith
		//Reset user
		hasAccepted=0
		if(src && partner)
			winset(src, "Trade.tradeAccept", "is-visible=false")
			winset(partner, "Trade.tradeAccept2", "is-visible=false")
			//Reset trade partner
			partner.hasAccepted=0
			winset(partner, "Trade.tradeAccept", "is-visible=false")
			winset(src, "Trade.tradeAccept2", "is-visible=false")

	makeTrade(mob/M)
		undoTradeLock()
		M.undoTradeLock()
		//Trade your items
		for(var/obj/O in src)
			if((!O.OnSpeedRail)&& O.upForTrade)
				if(O.worn)
					overlays-=O.icon;
					if(wielding==O.wielding)
						wielding=null; atkspeed=3
				M.TradeItem(O)
		//Obtain their items
		for(var/obj/O in M)
			if((!O.OnSpeedRail)&& O.upForTrade)
				if(O.worn)
					M.overlays-=O.icon;
					if(M.wielding==O.wielding)
						M.wielding=null; M.atkspeed=3
				TradeItem(O)

	TradeItem(obj/O)
		//If trading more than one of this item
		if(O.upForTrade > 1)
			//Check if the user already has an item of this type
			if(locate(O.type) in src)
				for(var/obj/T in src)
					if(T.type == O.type)
						T.amount += O.upForTrade //Add amount to new item
						O.amount -= O.upForTrade //Remove amount from own item
						src<<"You obtain [O.upForTrade] [T.trueName]"; UpdateInventory()

			//otherwise create a new object to send
			else
				var/obj/N = new O.type
				N.amount = O.upForTrade //Add amount to new item
				O.amount -= O.upForTrade //Remove amount from own item
				N.Checkamount() //Rename
				N.loc=src; N.worn=0; N.upForTrade=0;
				src<<"You obtain [O.upForTrade] [N.trueName]"; UpdateInventory()

			if(O.amount <= 0) {del(O)} // Delete if O no longer has an amount.
			else {O.upForTrade=0}

		//If trading just one of an item
		else
			src<<"You obtain [O.trueName]"; O.loc=src; O.worn=0; O.upForTrade=0; UpdateInventory()

	//Show Trade Window Function
	ShowTradeWindow(mob/player/M)
		//Set up trade window Info
		if(client)
			src<<output("\icon [AcquireSelfImage(src)]","Trade.TraderDisplayOne")
			src<<output("[name]'s Offer","Trade.Trader1")
		if(M.client)
			src<<output("\icon [AcquireSelfImage(M)]","Trade.TraderDisplayTwo")
			src<<output("[M.name]'s Offer","Trade.Trader2")


		//Set up Vars
		isTrading=1; tradingWith=M;

		//Show Trade Window
		winshow(src,"Trade",1)

	//Close Trade Window Function
	CloseTradeWindow(mob/player/M)

		undoTradeLock()
		M.undoTradeLock()

		//Set player back to normal
		isTrading=0; hasAccepted=0; tradingWith=0; tradeitems=0;
		UpdateInventory()
		winshow(src,"Trade",0)

		//Set Other player back to normal
		if(M)
			M.isTrading=0; M.hasAccepted=0; M.tradingWith=0; M.tradeitems=0;
			M.UpdateInventory()
			winshow(M,"Trade",0)




	//Update Trade Window Function
	updateTradeWindow(mob/player/M)
		if(!client) return
		if(!M.client) return
		var/items=0
		var/tradeitems=0
		//var/dura
		for(var/obj/O in src)
			if((!O.OnSpeedRail)&& O.upForTrade)
				//if(O.Durability != O.MaxDurability) dura = 255 - (round((O.Durability/O.MaxDurability)*100))
				//else dura = 0
				if(O.upForTrade > 1)
					//Display your items up for trade
					winset(src, "Trade.grid2", "current-cell=[++tradeitems]")
					//src << output("\icon [O.icon]     [O.trueName] ([O.upForTrade])", "Trade.grid2")
					src << output(O, "Trade.grid2")
					src << output("[O.trueName] ([O.upForTrade])", "Trade.grid2")
					//Display your items for them
					winset(M, "Trade.grid3", "current-cell=[tradeitems]")
					M << output("\icon [O.icon]     [O.trueName] ([O.upForTrade])", "Trade.grid3")
				else
					//Display your items up for trade
					winset(src, "Trade.grid2", "current-cell=[++tradeitems]")
					src << output(O, "Trade.grid2")
					//Display your items for them
					winset(M, "Trade.grid3", "current-cell=[tradeitems]")
					M << output(O, "Trade.grid3")
			if((!O.OnSpeedRail)&&(!O.upForTrade)&&(O.tradeable)&&(O.amount>0)&&(istype(O,/obj/Item)||istype(O,/obj/Weapon)||istype(O,/obj/Fish)||istype(O,/obj/Scrolls)||istype(O,/obj/Clothing)||istype(O,/obj/Event)))
				//Display your inventory in trade window
				winset(src, "Trade.grid1", "current-cell=[++items]")
				src << output(O, "Trade.grid1")
		winset(src, "Trade.grid1", "cells=[items]")
		winset(src, "Trade.grid2", "cells=[tradeitems]")
		winset(M, "Trade.grid3", "cells=[tradeitems]")
		Save()
		M.Save()
		//Update both players inventories (This is not needed now I don't think)
		UpdateInventory()
		M.UpdateInventory()
