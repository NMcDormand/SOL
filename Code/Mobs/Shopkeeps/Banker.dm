var
	BankName = "Citibank"
	BankAccountCost = 5000
	SDBCost = 200000

	list
		CitiBank = list()
		TrollList = list()

mob/var/
	SDB=list()
	SDBaccount

mob/NPC/Shopkeepers
	Banker
		name = "Banker"
		icon = 'Naruto Bases.dmi'
		icon_state = "banker"
		CantHenge=1
		protect=1

		proc
			InitializeBank(mob/user)
				if(!CitiBank)
					CitiBank = list()

				var/list/CB = CitiBank[user.ckey]
				if(CB)
					if(CB["Items"])
						user.SDBaccount = 1
					if(CB["Gold"])
						user.bankaccount = 1
					if(user.goldinbank)
						if(!user.bankaccount)
							user.bankaccount = 1
						CB["Gold"] += goldinbank
						user.goldinbank = 0
				else
					if(user.bankaccount)
						CitiBank[user.ckey] = list("Gold"=0)
					if(user.SDBaccount)
						CitiBank[user.ckey]["Items"] = list()
					if(user.goldinbank)
						CitiBank[user.ckey]["Gold"] += goldinbank
						user.goldinbank = 0

			CreateBankAccount(mob/user)
				if(user.gold >= BankAccountCost)
					user.gold -= BankAccountCost
					user << "<i>-[BankAccountCost] gold</i>"
					user.bankaccount = 1
					if(!CitiBank[user.ckey])
						CitiBank[user.ckey] = list("Gold" = 0)
					else
						CitiBank[user.ckey]["Gold"] = 0
					user.goldinbank = 0
					alert("Thank you, your account with [BankName] has been succesfully set up.")
				else if(user.ckey in TrollList)
					alert("You poor bro - what you trying to open a bank account for?")
				else
					alert("You only have [gold] gold. It costs [BankAccountCost] to open a bank account with us.")

			PurchaseSafetyDepositBox(mob/user)
				if(user.gold > SDBCost)
					user.gold -= SDBCost
					user << "<i>-[SDBCost] gold</i>"
					user.SDBaccount=1
					if(!CitiBank[user.ckey])
						CitiBank[user.ckey] = list("Items" = list())
					else
						CitiBank[user.ckey]["Items"] = list()
					alert("Thank you, your safety deposit box is safe with us here at [BankName].")
				else if(user.ckey in TrollList)
					alert("You poor bro - what you think people trying to steal from you fool?")
				else
					alert("You only have [gold] gold. It costs [SDBCost] to purchase a safety deposit box.")

			DepositAllItems(mob/user)
				if(!CitiBank[user.ckey]["Items"])
					CitiBank[user.ckey]["Items"] = list()
				var/list/itemlist=list()
				for(var/obj/o in user)
					if(o.worn||o.BlockDrop||istype(o,/obj/Weapon/Wield/Samehada)||istype(o,/obj/Weapon/Wield/ExecutionerBlade)||o.bones||istype(o,/obj/Item/Cat))
						continue
					if(istype(o,/obj/Item)||istype(o,/obj/Weapon/Wield)||istype(o,/obj/Clothing)||istype(o,/obj/Scrolls)||istype(o,/obj/Fish))
						if(!istype(o,/obj/Item/Class))
							itemlist+=o
				if(itemlist.len)
					var/msg = ""
					for(var/obj/SO in itemlist)
						if(!SO.trueName)
							SO.trueName = SO.name
						if(!SO.Stackable)
							msg += "<br>You Deposited [SO.amount] [SO.trueName] to your Safety Deposit Box"
							CitiBank[user.ckey]["Items"] += SO
							SO.loc = null
							SO.OnSpeedRail = 0
						else
							var/obj/DepositBoxItem = locate(SO.type) in CitiBank[user.ckey]["Items"]
							if(DepositBoxItem)
								DepositBoxItem.amount += SO.amount
								msg += "<br>You Deposited [SO.amount] [SO.trueName] you now have [DepositBoxItem.amount] in the Safety Deposit Box"
								DepositBoxItem.Checkamount()
								DepositBoxItem.OnSpeedRail = 0
								del SO
							else
								user << "<br>You Deposited [SO.amount] [SO.trueName] to your Safety Deposit Box"
								CitiBank[user.ckey]["Items"] += SO
								SO.loc = null
								SO.OnSpeedRail = 0
					user.UpdateInventory()
				else
					user << "I'm sorry sir you don't have any items to deposit"
					user.UpdateInventory()

			DepositItems(mob/user)
				if(!CitiBank[user.ckey]["Items"])
					CitiBank[user.ckey]["Items"] = list()
				var/list/itemlist=list()
				for(var/obj/o in user)
					if(o.worn||o.BlockDrop||istype(o,/obj/Weapon/Wield/Samehada)||istype(o,/obj/Weapon/Wield/ExecutionerBlade)||o.bones||istype(o,/obj/Item/Cat))
						continue
					if(istype(o,/obj/Item)||istype(o,/obj/Weapon/Wield)||istype(o,/obj/Clothing)||istype(o,/obj/Scrolls)||istype(o,/obj/Fish))
						if(!istype(o,/obj/Item/Class))
							itemlist+=o
				if(itemlist.len)
					var/obj/SO = input("What would you like to deposit?","Safety Deposit Box") as null|anything in itemlist
					if(SO)
						if(!SO.trueName)
							SO.trueName = SO.name
						if(!SO.Stackable)
							user << "You Deposited [SO.amount] [SO.trueName] to your Safety Deposit Box"
							CitiBank[user.ckey]["Items"] += SO
							SO.loc = null
							SO.OnSpeedRail = 0
						else
							var/obj/DepositBoxItem = locate(SO.type) in CitiBank[user.ckey]["Items"]
							if(SO.amount>1)
								if(alert("I noticed you have more than one of these, would you like to deposit the lot?","Deposit Amount","Yes","No") == "Yes")
									if(SO.loc == user)
										if(DepositBoxItem)
											user << "You Deposited [SO.amount] [SO.trueName] you now have [SO.amount + DepositBoxItem.amount] in the Safety Deposit Box"
											DepositBoxItem.amount += SO.amount
											DepositBoxItem.Checkamount()
											DepositBoxItem.OnSpeedRail = 0
											del SO
										else
											user << "You Deposited [SO.amount] [SO.trueName] to your Safety Deposit Box"
											CitiBank[user.ckey]["Items"] += SO
											SO.loc = null
											SO.OnSpeedRail = 0
								else
									var/AM = input("How many would you like us to lose?","How many?") as num
									if(AM>0 && SO.loc == user)
										if(DepositBoxItem)
											user << "You Deposited [SO.amount] [SO.trueName] you now have [SO.amount + DepositBoxItem.amount] in the Safety Deposit Box"
											if(AM>=SO.amount)
												DepositBoxItem.amount += SO.amount
												DepositBoxItem.Checkamount()
												DepositBoxItem.OnSpeedRail = 0
												del SO
											else
												DepositBoxItem.amount += AM
												DepositBoxItem.Checkamount()
												DepositBoxItem.OnSpeedRail = 0
												SO.amount -= AM
												SO.Checkamount()
										else
											user << "You Deposited [SO.amount] [SO.trueName] to your Safety Deposit Box"
											if(AM >= SO.amount)
												CitiBank[user.ckey]["Items"] += SO
												SO.OnSpeedRail = 0
												SO.loc = null
											else
												var/obj/NO = new SO.type()
												NO.amount = AM
												NO.OnSpeedRail = 0
												NO.Checkamount()
												CitiBank[user.ckey]["Items"] += NO
												SO.amount -= AM
												SO.Checkamount()
							else
								if(SO.loc == user)
									if(DepositBoxItem)
										user << "You Deposited 1 [SO.trueName] you now have [1 + DepositBoxItem.amount] in the Safety Deposit Box"
										DepositBoxItem.amount += SO.amount
										DepositBoxItem.Checkamount()
										del SO
									else
										user << "You Deposited 1 [SO.trueName] to your Safety Deposit Box"
										CitiBank[user.ckey]["Items"] += SO
										SO.loc = null
					user.UpdateInventory()
				else
					user << "I'm sorry sir you don't have any items to deposit"
					user.UpdateInventory()

			WithdrawItems(mob/user)
				if(!CitiBank[user.ckey]["Items"])
					CitiBank[user.ckey]["Items"] = list()
				var/obj/wd=input("Viewing Contents...","Safety Deposit Box") as null|anything in CitiBank[user.ckey]["Items"]
				if(wd)
					user << "Wow, I cant believe we didn't lose your [wd] but here you go, thank you for you business"
					if(wd.Stackable)
						var/obj/Item/F = locate(wd.type) in user
						if(!F)
							wd.loc=user
							user.UpdateInventory()
							CitiBank[user.ckey]["Items"] -= wd
							user << "You withdrew [wd.amount] [wd.trueName]"
						else
							F.amount += wd.amount
							F.Checkamount()
							user << "You withdrew [wd.amount] [wd.trueName]"
							CitiBank[user.ckey]["Items"] -= wd
							del wd
							user.UpdateInventory()
					else
						CitiBank[user.ckey]["Items"] -= wd
						wd.loc = user
						user.UpdateInventory()

		Action(mob/user)
			if(user.choosing)
				return
			if(get_dist(user,src)>2)
				return
			user.choosing = 1

			InitializeBank(user)

			var/list/options=list()

			var/message = "Welcome to Citibank. "

			if(!user.bankaccount)
				message += "You do not currently have a bank account with us. "
				options+="Create Bank Account"
			else
				if(CitiBank[user.ckey]["Gold"])
					message += "Your bank account with us currently has [CitiBank[user.ckey]["Gold"]]."
					options+="Withdraw Gold"
				if(user.gold)
					options+="Deposit Gold"

			if(!user.SDBaccount)
				options+="Purchase Safety Deposit Box"
			else
				options+="View Safety Deposit Box"
				options+="Deposit Items"
				options+="Deposit All Items"
				options+="Withdraw Items"

			if(!user.bankaccount && !user.SDBaccount)
				user << "Welcome to [BankName]! We're excited to serve you - please either open a bank account (costs [BankAccountCost] gold) or purchase a safety deposit box (costs [SDBCost] gold) so we can assist you."
			else if(!user.bankaccount)
				if(!CitiBank[user.ckey]["Items"])
					CitiBank[user.ckey]["Items"] = list()
				var/itemsinsdb = length(CitiBank[user.ckey]["Items"])
				if(itemsinsdb == 0)
					user << "Welcome to [BankName]! We're happy to serve you - your safety deposit box with us is currently empty. Please let me know if you'd like to open a bank account (costs [BankAccountCost] gold) with us."
				else if(itemsinsdb == 1)
					user << "Welcome to [BankName]! We're happy to serve you - you have one item in your safety deposit box. Please let me know if you'd like to open a bank account (costs [BankAccountCost] gold) with us."
				else
					user << "Welcome to [BankName]! We're happy to serve you - there are [itemsinsdb] in your safety deposit box. Please let me know if you'd like to open a bank account (costs [BankAccountCost] gold) with us."
			else if(!user.SDBaccount)
				var/goldinsdb = CitiBank[user.ckey]["Gold"]
				user << "Welcome to [BankName]! We're happy to serve you - you currently have [goldinsdb] gold in your bank account. Please let me know if you'd like to purchase a safety deposit box (costs [SDBCost] gold)."
			else
				if(!CitiBank[user.ckey]["Items"])
					CitiBank[user.ckey]["Items"] = list()
				var/goldinsdb = CitiBank[user.ckey]["Gold"]
				var/itemsinsdb = length(CitiBank[user.ckey]["Items"])
				user << "Welcome back to [BankName]! You currently have [goldinsdb] gold in your bank account and [itemsinsdb] items in your safety deposit box."

			switch(input("Welcome to [BankName], how would you like to be robbed today?","Bank",)as null|anything in options)
				// Set Up Options
				if("Create Bank Account")
					CreateBankAccount(user)

				if("Purchase Safety Deposit Box")
					PurchaseSafetyDepositBox(user)

				// Bank Options
				if("Deposit Gold")
					var/deposit = input("How much gold will you be depositing into your account?","Deposit Gold") as num
					if(deposit > user.gold)
						if(alert("You do not have this much Gold, would you like to deposit everything ([user.gold] gold)?","Max Deposit","Yes","No") == "Yes")
							deposit = user.gold
						else
							deposit = 0

					if(deposit > 0)
						user.gold -= deposit
						CitiBank[user.ckey]["Gold"] += deposit
						var/actualgoldinbank = CitiBank[user.ckey]["Gold"]
						user.goldinbank = actualgoldinbank
						user << "Deposited [deposit] gold. You now have [actualgoldinbank] gold in your bank account."

				if("Withdraw Gold")
					var/withdraw = input("How much gold will you be taking with you?","Withdraw Gold") as num
					var/actualgoldinbank = CitiBank[user.ckey]["Gold"]

					if(withdraw > actualgoldinbank)
						if(alert("You do not have this much Gold in your account, would you like to withdraw everything ([actualgoldinbank] gold)?","Max Withdraw","Yes","No") == "Yes")
							withdraw = CitiBank[user.ckey]["Gold"]
						else
							withdraw = 0

					if(withdraw > 0)
						CitiBank[user.ckey]["Gold"] -= withdraw
						actualgoldinbank = CitiBank[user.ckey]["Gold"]
						user.goldinbank = actualgoldinbank
						user.gold += withdraw
						user << "Withdrew [withdraw] gold. You now have [actualgoldinbank] gold in your bank account."

				// Safety Deposit Box Options
				if("View Safety Deposit Box")
					var/itemsinsdb = length(CitiBank[user.ckey]["Items"])
					if(itemsinsdb == 0)
						user << "Your safety deposit box is empty."
					else if(itemsinsdb == 1)
						user << "Your safety deposit box has 1 item:"
					else
						user << "Your safety deposit box has the following items:"

					for(var/obj/depositboxitem in CitiBank[user.ckey]["Items"])
						user << "[depositboxitem]"

				if("Deposit Items")
					DepositItems(user)
				if("Deposit All Items")
					if(alert(user,"This will deposit every Item, that is capable of doing so, to your Safety Deposit Box. Are you sure you would like to lose them all today?","Deposit All Items","Yes","No") == "Yes")
						DepositAllItems(user)
				if("Withdraw Items")
					WithdrawItems(user)

			user.choosing = 0
			user.UpdateInventory()
			user.StatUpdate_gold()