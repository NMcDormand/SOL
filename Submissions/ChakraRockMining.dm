var/Rockcount=0
mob/var
	Mining = 0
turf/var
	canspawn=0
turf
	spawnarea
		canspawn=1
obj/Mining
	var
		Health=1
	ChakraRock
	MineableRock
		density=1
		icon='Misc.dmi'
		icon_state="rock"
		New()
			Rockcount++
			..()
		Click()
			var
				c=500; mx=c; s=usr.SS*2
			if(usr.Mining)
				usr<<"You need a short break, you recently mined a rock!"
				return
			usr.Mining=1
			if(usr.Chakra<=c) {usr<<"Not enough Chakra."; spawn(30) ;usr.Mining=0 ; return}
			if(prob(usr.ChakraControl))
				spawn(1)
					usr.JutsuSeals(s); usr.JutsuChakra(c)
					usr.UseChakra_Jutsu(c)
					src.Health-=1
				spawn(1)
				switch(pick(prob(50); 1,prob(25); 2,prob(15); 3/*,prob(1); 4,prob(0.5); 5*/))
					if(1)
						usr<<"You mined a rock!"
						var/obj/Items/Rock/R=locate(/obj/Items/Rock) in usr.contents
						if(!(R in usr.contents)) new/obj/Items/Rock(usr)
						else {R.amount++; R.Checkamount()}
						usr.UpdateInventory(); usr.RocksFound++
						spawn(30)
							usr.Mining=0
							if(src.Health==0)
								usr<<"The rock crumbles to dust before you can mine any further."
								del src
								return
					if(2)
						usr<<"You found nothing."
						spawn(30)
							usr.Mining=0
							if(src.Health==0)
								usr<<"The rock crumbles to dust before you can mine any further."
								del src
								return
					if(3)
						usr<<"You skillfully chip away at the rock"
						var/obj/Items/Rock/R=locate(/obj/Items/Rock) in usr.contents
						var/num=rand(2,5)
						if(!(R in usr.contents)) new/obj/Items/Rock(usr)
						else {R.amount+=num; R.Checkamount()}
						usr.UpdateInventory(); usr.RocksFound+=num
						usr<<"You mined [num] rocks!"
						spawn(30)
							usr.Mining=0
							if(src.Health==0)
								usr<<"The rock crumbles to dust before you can mine any further."
								del src
								return
//					if(4)
//						usr<<"You found a rare chakra rock!!"
//						spawn(30)
//							usr.Mining=0
//					if(5)
//						usr<<"You found a rare gemstone! Maybe you can sell it to a merchant?"
//						spawn(30)
//							usr.Mining=0
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>";spawn(30); usr.Mining=0; return}
			..()
		Del()
			Rockcount-=1
			StartMining()
			..()
mob/AdminLevel4/verb
	StartMiningVerb()
		usr<<"Initiated population of rocks"
		StartMining()
		return
	RockCheck()
		set desc        = "Rock Check"
		set category    = "Admin"
		usr<<"[Rockcount]"
proc
	StartMining()
		var/num_x = 0
		var/num_y = 0
		while(Rockcount<=199)
			num_x = rand(1,1000)
			num_y = rand(1,568)
			var/turf/T = locate(num_x,num_y,1)
			if(!T.density&&T.canspawn)
				var/obj/Mining/MineableRock/O = new /obj/Mining/MineableRock
				O.Move(locate(num_x,num_y,1))
				O.Health+=rand(2,4)
				if(Rockcount==200)
					return

