mob/NPC/Shopkeepers
	WeaponsDealer
		name = "Weapons Dealer"
		icon = 'WeaponsDealer.dmi'
		CantHenge=1
		protect=1
		Action(mob/user)
			if(get_dist(user,src) > 2||user.choosing)
				return
			user.choosing=1
			var/Choice = input("How can I help you, stranger?") as null|anything in list("Buy Weapons","Sell Weapons","Repair Weapons")
			if(Choice)
				switch(Choice)
					if("Sell Weapons")
						var/list/R=list("Sell All Weapons")
						for(var/obj/Weapon/W in user.contents)
							if(W.Durability < 1 || W.NotSellable)
								continue
							else
								R+=W
						if(R.len < 2)
							user<<"Weapons Dealer: <i>You've got no weapons on for me to buy.</i>"
							user.choosing=0
							return
						var/obj/Weapon/Z=input("What would you like to sell, stranger?","Weapons Dealer")as null|anything in R
						if(Z=="Sell All Weapons")
							switch(input("Are you sure you want to sell all of your weapons?","Weapons Dealer") as null|anything in list("Yes","No"))
								if("Yes")
									for(var/obj/Weapon/x in user)
										if(x.NotSellable||x.worn)
											continue
										else
											if(!x.amount||x.amount<2)
												user.gold+=x.price*GOLDMULTI
												user.StatUpdate_gold()
											else user.gold+=(x.price*x.amount)
											del(x)

						else if(Z)
							var/cost
							if(Z.amount>1)
								var/SellN=input("How many [Z.name] would you like to sell? (Max: [Z.amount])","Weapons Dealer") as num
								if(SellN>Z.amount) SellN=Z.amount
								if(SellN>0)
									Z.amount-=SellN; user.gold+=(SellN*(Z.price*GOLDMULTI))
									user.StatUpdate_gold()
									Z.Checkamount()
									if(Z.amount<=0) del(Z)
							else
								cost=(Z.price * Z.Durability/Z.MaxDurability) * GOLDMULTI
								switch(input("Wanna sell the [Z.name] for [cost] gold?","Weapons Dealer") in list("Yes","No"))
									if("Yes")
										user.gold+=cost
										user<<"Weapons Dealer: <i>Heheh, Thankyou!</i>"
										if(Z.worn)
											user.wielding=null; user.atkspeed=3
											for(var/obj/Weapon/Wield/w in user)
												if(w.worn) user.overlays-=w.icon
										del(Z)
									if("No") user<<"Weapons Dealer: <i>Alright then, stranger.</i>"
					if("Repair Weapons")
						var/list/R=list()
						for(var/obj/Weapon/Wield/W in user.contents)
							if(W.Durability < W.MaxDurability)
								R+=W
						if(!R.len)
							user<<"Weapons Dealer: <i>You've got no weapons that need to be repaired stranger.</i>"
							user.choosing=0
							return
						var/obj/Z=input("What would you like me to repair, stranger?","Weapons Dealer") as null|anything in R
						if(Z)
							var/cost=round((Z.MaxDurability-Z.Durability)*0.35)
							if(istype(Z,/obj/Weapon/Wield/Samehada)||istype(Z,/obj/Weapon/Wield/ExecutionerBlade)||istype(Z,/obj/Weapon/Wield/Gunbai)||istype(Z,/obj/Weapon/Wield/Shibuki)||istype(Z,/obj/Weapon/Wield/Nuibari))
								cost*=5
							if(istype(Z,/obj/Weapon/Wield/Elemental))
								cost*=3
							if(cost<1)
								cost=1
							switch(input("Shall I repair the [Z.name] for [cost] gold?","Weapons Dealer") in list("Yes","No"))
								if("Yes")
									if(user.gold>=cost)
										user.gold-=cost
										Z.Durability=Z.MaxDurability
										Z.icon_state="inventory"
										user<<"<i>There you are, stranger. Good as new!"
									else
										user<<"Weapons Dealer: <i>Not enough gold, stranger.</i>"
								if("No")
									user<<"Weapons Dealer: <i>Alright then, stranger."

					if("Buy Weapons")
						switch(input("Greetings, stranger. I got plenty on sale today.","Weapons Dealer")in list("Shuriken {100}","Windmill Shuriken {1800}","Kunai {800}","Double-Edged Kunai {500}","Katana {2000}","Broad Sword {5000}","Explosion Note {200}","Never mind"))
							if("Shuriken {100}")
								var/quantity=input("How many d'ya want?","Weapons Dealer")as num
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								var/goldneeded=quantity*100
								if(quantity>0)
									if(user.gold>=goldneeded)
										user.gold-=goldneeded
										var/obj/Weapon/Thrown/Shuriken/S
										for(var/obj/Weapon/Thrown/Shuriken/SH in user.contents)
											if(!SH.Creator)
												S = SH
										if(S)
											S.amount+=quantity
										else
											S=new(user)
											S.amount=quantity
										S.Checkamount()
										user<<"Weapons Dealer: <i>Heheh. Thankyou.</i>"
									else
										user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
							if("Windmill Shuriken {1800}")
								var/quantity=input("How many d'ya want?","Weapons Dealer")as num
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								var/goldneeded=quantity*1800
								if(quantity>0)
									if(user.gold>=goldneeded)
										user.gold-=goldneeded
										var/obj/Weapon/Thrown/WindmillShuriken/S
										for(var/obj/Weapon/Thrown/WindmillShuriken/SH in user.contents)
											if(!SH.Creator)
												S = SH
										if(S)
											S.amount+=quantity
										else
											S=new(user)
											S.amount=quantity
										S.Checkamount()
										user<<"Weapons Dealer: <i>Heheh. Thankyou.</i>"
									else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
								user.choosing=0
		//------------------------------------------------------------------------------------------------------------
							if("Kunai {800}")
								user.choosing=0
								if(user.gold>=800) {user.gold-=800; var/obj/Weapon/Wield/Kunai/K=new/obj/Weapon/Wield/Kunai; K.loc=user; user<<"<i>Heheh. Thankyou.</i>"}
								else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
		//------------------------------------------------------------------------------------------------------------
							if("Double-Edged Kunai {500}")
								var/quantity=input("How many d'ya want?","Weapons Dealer")as num
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								var/goldneeded=quantity*500
								if(quantity>0)
									if(user.gold>=goldneeded)
										user.gold-=goldneeded
										var/obj/Weapon/Thrown/DoubleEdgedKunai/S
										for(var/obj/Weapon/Thrown/DoubleEdgedKunai/SH in user.contents)
											if(!SH.Creator)
												S = SH
										if(S)
											S.amount+=quantity
										else
											S=new(user)
											S.amount=quantity
										S.Checkamount()
										user<<"Weapons Dealer: <i>Heheh. Thankyou.</i>"
									else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
		//------------------------------------------------------------------------------------------------------------
							if("Katana {2000}")
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								if(user.gold>=2000) {user.gold-=2000; new/obj/Weapon/Wield/Katana(user); user<<"<i>Weapons Dealer: Heheh. Thankyou.</i>"}
								else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
							if("Broad Sword {5000}")
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								if(user.gold>=5000) {user.gold-=5000; new/obj/Weapon/Wield/BroadSword(user); user<<"Weapons Dealer: <i>Heheh. Thankyou.</i>"}
								else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
							if("Explosion Note {200}")
								var/quantity=input("How many d'ya want?","Weapons Dealer")as num
								if(!get_dist(user,src) > 2)
									user.choosing=0
									return
								if(quantity > 0)
									var/goldneeded=quantity*200
									if(user.gold>=goldneeded)
										user.gold-=goldneeded
										var/obj/Weapon/Wield/ExplosionNote/S
										for(var/obj/Weapon/Wield/ExplosionNote/SH in user.contents)
											if(!SH.Creator)
												S = SH
										if(S)
											S.amount+=quantity
										else
											S=new(user)
											S.amount=quantity
										S.Checkamount()
										user<<"Weapons Dealer: <i>Heheh. Thankyou.</i>"
									else user<<"Weapons Dealer: <i>Not enough cash, stranger.</i>"
			user.choosing=0
			user.StatUpdate_gold(); user.UpdateInventory()