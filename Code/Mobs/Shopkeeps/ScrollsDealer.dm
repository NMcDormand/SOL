mob/NPC/Shopkeepers
	ScrollDealer
		name = "Scroll Dealer"
		icon = 'Naruto Bases.dmi'
		icon_state = "scroll dealer"
		CantHenge=1
		protect=1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.choosing) return
			user.choosing=1
			var/Choice = input("","")as null|anything in list("Buy Scrolls","Sell Scrolls","Nevermind")
			if(!Choice || Choice == "Nevermind")
				user.choosing=0
			else
				switch(Choice)
					if("Sell Scrolls")
						var/obj/Scrolls/X=locate(/obj/Scrolls) in user
						if(!X){user<<"Scrolls Dealer: <i>You've got no Scrolls on for me to buy.</i>"; user.choosing=0; return}
						var/R=list()
						for(var/obj/Scrolls/W in user.contents) {if(!W.NotSellable) R+=W}
						var/obj/Scrolls/Z=input("What would you like to sell?","Scrolls Dealer")as null|anything in R
						if(Z)
							var/cost=Z.price
							switch(input("Wanna sell the [Z.name] for [cost] gold?","Scrolls Dealer") in list("Yes","No"))
								if("Yes")
									user.gold+=cost
									user.StatUpdate_gold()
									switch(pick(1,2,3,4))
										if(1) user<<"Scrolls Dealer: <i>A pleasure doing business with you!</i>"
										if(2) user<<"Scrolls Dealer: <i>Your drive a good deal!</i>"
										if(3) user<<"Scrolls Dealer: <i>Thankyou.</i>"
										if(4) user<<"Scrolls Dealer: <i>Please, come again.</i>"
									del(Z)
						user.choosing=0
					else if("Buy Scrolls")
						switch(input("Salutations, how can I be of assistance?","Scroll Dealer")in list("MeiMei Scroll {5000}","Kage Shuriken Scroll {2000}","Shuriken Kage Bunshin Scroll {3000}","Kage Bunshin Scroll {9000}","Bunshin Daibakuha Scroll {15000}","Never mind"))
							if("Bunshin Daibakuha Scroll {15000}")
								if(user.gold>=15000)
									user.gold-=15000; new/obj/Scrolls/BunshinExplodeScroll(user)
									user<<"<i>A wise choice.</i>"
								else user<<"<i>You do not have enough to purchase this item.</i>"
							if("MeiMei Scroll {5000}")
								if(user.gold>=5000)
									user.gold-=5000; new/obj/Scrolls/MeiMeiScroll(user)
									user<<"<i>A wise choice.</i>"
								else user<<"<i>You do not have enough to purchase this item.</i>"

							if("Kage Shuriken Scroll {2000}")
								if(user.gold>=2000)
									user.gold-=2000; new/obj/Scrolls/KageShurikenScroll(user)
									user<<"<i>A wise choice.</i>"
								else user<<"<i>You do not have enough to purchase this item.</i>"

							if("Kage Bunshin Scroll {9000}")
								if(user.gold>=9000)
									user.gold-=9000; new/obj/Scrolls/KageBunshinScroll(user)
									user<<"<i>A wise choice.</i>"
								else user<<"<i>You do not have enough to purchase this item.</i>"

							if("Shuriken Kage Bunshin Scroll {3000}")
								if(user.gold>=3000)
									user.gold-=3000; new/obj/Scrolls/ShurikenKageBunshinScroll(user)
									user<<"<i>A wise choice.</i>"
								else user<<"<i>You do not have enough to purchase this item.</i>"
				user.choosing=0
				user.StatUpdate_gold(); user.UpdateInventory()
