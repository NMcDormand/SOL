mob/var
	weights
	equippedweight
	extraweight=0

obj/Item
	AnkleWeight
		name="Ankle Weights"
		trueName="Ankle Weights"
		icon='AnkleWeights.dmi'
		icon_state="inventory"
		price=100
		ItemType="Weights"
		Drop()
			if(usr.equippedweight)
				usr << "Please unequip the weights before dropping them"
				return
			else
				..()
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Equip()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			EquipMax()
				set src in usr.contents
				set name="Equip Max/Unequip"
				if(usr.choosing)
					return
				if(worn)
					usr.overlays-='AnkleWeights.dmi'
					//usr.overlays-='ExtraWeights.dmi'
					usr.weights=0; usr.equippedweight=0
					usr.TooMuchWeight=0
					usr.WeightSpeed()
					worn=0
					name=trueName
					usr<<"You remove the [name]"
				else
					usr.choosing=1
					var/obj/Item/ExtraWeights/E = locate(/obj/Item/ExtraWeights) in usr.contents
					if(!E)
						usr.extraweight=0
						usr << "You dont have any Extra Weights"
						return

					var/mx=round((usr.StaminaTrue-15000)/15000)
					var/count=E.amount

					if(mx>count)
						usr<<"You did not have enough extra weights to clip your maximum([mx]). Instead you clipped ([count])"
						usr.choosing=0
						if(usr.extraweight)
							//usr.overlays+='ExtraWeights.dmi'
						else
							usr.overlays+='AnkleWeights.dmi'
						worn=1
						usr.weights=1
						usr.extraweight=count
						usr.equippedweight=1+count
						usr.WeightSpeed()
						name="[trueName] ([usr.equippedweight])"
					else
						usr.choosing=0; usr.extraweight=mx
						usr.equippedweight=mx+1
						usr<<"You have equipped the maximum weight for your Stamina([mx])."
						//if(usr.extraweight)usr.overlays+='ExtraWeights.dmi';else
						usr.overlays+='AnkleWeights.dmi'
						usr.weights=1
						worn=1
						usr.WeightSpeed()
						name="[trueName] ([usr.equippedweight])"
				usr.UpdateInventory()

			Equip()
				set name="Equip/Remove"
				set src in usr.contents
				if(usr.StaminaTrue<15000)
					usr<<"Not enough Stamina to wear these and move"
					return
				if(worn)
					usr.overlays-='AnkleWeights.dmi'; //usr.overlays-='ExtraWeights.dmi'
					usr.weights=0; usr.equippedweight=0
					usr.TooMuchWeight=0; usr.WeightSpeed(); worn=0; name=trueName
					usr<<"You remove the [name]"
				else
					//if(usr.extraweight) usr.overlays+='ExtraWeights.dmi'
					//else
					usr.overlays+='AnkleWeights.dmi'
					usr.weights=1
					var/obj/Item/ExtraWeights/E = locate(/obj/Item/ExtraWeights) in usr.contents
					if(!E)
						usr.extraweight=0
					else if(E&&(E.amount<usr.extraweight))
						usr.extraweight=E.amount
					usr.equippedweight=1+usr.extraweight
					name="[trueName] ([usr.equippedweight])"; worn=1
					usr.WeightSpeed(); usr<<"You equip the [name]"
				usr.UpdateInventory()

	ExtraWeights
		name="Extra Weights"
		trueName="Extra Weights"
		icon='ExtraWeights.dmi'
		icon_state="inventory"
		amount=1
		Stackable = 1
		verb
			ClipOn()
				set name="Clip/Unclip"
				if(usr.choosing) return
				var/obj/Item/AnkleWeight/W = locate() in usr.contents
				if(!W)
					usr << "You dont have any weights to clip the on to"
					return
				//if(W.worn) {usr<<"You need to unquip the weights first."; return}
				usr.choosing=1
				var/clipon = round(input(usr,"Clip on how many extra weights?","Extra Weight",) as num)
				var/mx=round((usr.StaminaTrue-15000)/15000)
				if(clipon>=mx)
					usr.choosing=null
					usr<<"This will overload you!"
					return
				else if(clipon<0)
					usr.choosing=null
					return

				if(!clipon)
					usr << "You remove all Extra Weights."
					usr.choosing=0
					usr.extraweight=0
					usr.WeightSpeed();
					return

				var/obj/Item/ExtraWeights/E = locate() in usr.contents
				if(clipon>E.amount)
					usr.choosing=0
					usr<<"You don't have that many"
				else
					usr<<"You clip on [clipon] Extra Weights"
					usr.choosing=0
					usr.extraweight=clipon
					usr.UpdateInventory()
					if(usr.equippedweight)
						usr.equippedweight = 1+usr.extraweight

						var/obj/Item/AnkleWeight/AW = locate() in usr
						AW.name="[AW.trueName] ([usr.equippedweight])"
				usr.WeightSpeed();

		Drop()
			var/dropno = round(input("Drop how many?","Drop",) as num)
			if(dropno<=0 || !dropno)
				return
			var/obj/Item/ExtraWeights/E = locate() in usr.contents
			if(dropno>E.amount)
				usr<<"You don't have that many."
				return
			else
				var/BB = E.amount - dropno
				E.amount -= dropno
				usr<<"You drop [dropno] Extra Weights."

				var/obj/Item/ExtraWeights/E2 = new(usr.loc)
				E2.amount=dropno
				E2.Checkamount()

				//var/obj/Item/AnkleWeight/W = locate() in usr.contents
				if(BB <= usr.extraweight && BB > 0)
					usr.extraweight -= BB
				else
					usr.extraweight = 0

				if(usr.equippedweight)
					var/obj/Item/AnkleWeight/AW = locate() in usr
					usr.equippedweight = 1 + usr.extraweight
					AW.name="[AW.trueName] ([usr.equippedweight])"
					usr.WeightSpeed();

				spawn(5)
					usr.UpdateInventory()
				if(E.amount<=0)
					del E
				else
					E.Checkamount()
mob/var
	TooMuchWeight
	WeightZone
	weightspeed
mob/proc
	SwimGain()
		ApplyEXP(rand(50,400),"Stamina")

	WeightSpeed()
		if(!weights)
			if(onmountain) MountainWalkSpeed()
			else weightspeed=setspeed
		else
			var/mx=round(StaminaTrue/15000)
			if(equippedweight>mx && client) TooMuchWeight=1
			else if(equippedweight==mx) {weightspeed=5; TooMuchWeight=0; WeightZone="max"}
			else if(equippedweight<mx&&equippedweight>=(mx-2)) {weightspeed=3;  TooMuchWeight=0; WeightZone="top"}
			else if(equippedweight<mx&&equippedweight>=(mx-5)) {weightspeed=2;  TooMuchWeight=0; WeightZone="med"}
			else if(equippedweight<(mx-5)) {weightspeed=1;  TooMuchWeight=0; WeightZone="min"}

	WeightsGain()
		var/gain=0
		if(!WeightZone && client)
			WeightSpeed()
		if(WeightZone=="max")
			if(prob(85)) Stamina -= rand(120,220)
			gain=rand(40,220)
			gain += (equippedweight*70)
		else if(WeightZone=="top")
			if(prob(85)) Stamina -= rand(80,130)
			gain=rand(30,200)
			gain = (equippedweight*70)
		else if(WeightZone=="med")
			if(prob(85)) Stamina -= rand(50,80)
			gain=rand(10,90)
			gain += (equippedweight*45)
		else if(WeightZone=="min")
			gain=rand(4,15)
			gain += (equippedweight*25)
		ApplyEXP(gain,"Stamina")
