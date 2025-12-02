var
	//Stat world vars
	StatCap=0		//Stat Caps
	list/StatCaps		=list("Level"=200,"Health"=100000,"Stamina"=100000,"Energy"=100000,"Speed"=50,"AttackSpeed"=1)
	StatGrow=1		//MXP Growth percentage
	list/StatGrowth		=list("Level"=0.1,"Health"=0.1,"Stamina"=0.1,"Energy"=0.1,"Speed"=0.1,"AttackSpeed"=0.1)
	StatEGCap=1		//MXP Growth Cap
	list/StatEGCaps		=list("Level"=200,"Health"=500,"Stamina"=500,"Energy"=500,"Speed"=500,"AttackSpeed"=500)
	StatECap=1		//MXP Cap
	list/StatECaps		=list("Level"=8000,"Health"=8000,"Stamina"=8000,"Energy"=8000,"Speed"=8000,"AttackSpeed"=8000)
	StatMod=1		//Base Mod
	list/StatMods		=list("Level"=1,"Health"=1,"Stamina"=1,"Energy"=1,"Speed"=1,"AttackSpeed"=1)
	StatMGrow=1		//Mod Growth
	//Growth 1=100% 0.1=10%
	list/StatMGrowth	=list("Level"=0.01,"Health"=0.01,"Stamina"=0.01,"Energy"=0.01,"Speed"=0.01,"AttackSpeed"=0.01)
	//Chance of Happening 1=100% 0.1=10%
	list/StatMGrowCh	=list("Level"=0.1,"Health"=0.1,"Stamina"=0.1,"Energy"=0.1,"Speed"=0.1,"AttackSpeed"=0.1)

mob
	var
		//Stats(Type/Cur/Max/Tru,CXP,MXP,Mod,Cap)
		//Main

		Stat
			Level		=new("Level",1,0,100,1,600)
			Primary
				Stamina		=new("Stamina",500,0,50,1,0)
				Chakra		=new("Chakra",500,0,50,1,0)
			Fighting
				Taijutsu	=new("Taijutsu",1,0,50,1,0)
				Ninjutsu	=new("Ninjutsu",1,0,50,1,0)
				Genjutsu	=new("Genjutsu",1,0,50,1,0)
			Secondary
				Reflexes		=new("Reflexes",1,0,200,1,0)
			//Skill Stats (specific stats for games, example Sword skill if swords exist)
				Fishing			=new("Fishing",1,0,100,1,0)
				Crafting		=new("Crafting",1,0,20,1,0)
				FirstAid		=new("FirstAid",1,0,100,1,0)
				ChakraControl	=new("ChakraControl",30,30,30,0,40,1,0)
				Mining			=new("Mining",30,30,30,0,80,1,0)
			Speed
				MoveSpeed		=new("Speed",3,0,3000,1,0)
				SealSpeed		=new("Seal Speed",3,0,3000,1,0)
				AttackSpeed		=new("AttackSpeed",5,5,5,0,0,1,0)
		//Hidden
			Hidden
			//Advanced
				Perception	=new("Perception",1,0,50,1,0)
				Defense		=new("Defense",1,0,50,1,0)
				Luck		=new("Luck",1,0,50,1,0)
		//Weapon
			Weapon
				Unarmed		=new("Unarmed",0,0,0,0,50,1,0)
				Knife		=new("Knife",0,0,0,0,50,1,0)//Also thrown
				Pole		=new("Pole",0,0,0,0,50,1,0)
				Scythe		=new("Scythe",0,0,0,0,50,1,0)
				Sword		=new("Sword",0,0,0,0,50,1,0)
				Whip		=new("Whip",0,0,0,0,50,1,0)
				Fan			=new("Fan",0,0,0,0,50,1,0)
				Axe			=new("Axe",0,0,0,0,50,1,0)
			//Weapon Thrown
				Throwing	=new("Throwing",0,0,0,0,50,1,0)
		//Basic Elements
			Element
				Fire
				Earth
				Lightning
				Water
				Wind
		//Advanced s
				Blaze		//Fire Lightning
				Boil		//Fire Water
				Explosion	//Lightning Earth
				Ice			//Wind Water
				Lava		//Fire Earth
				Magnet		//Wind Earth
				Sand		//Magnet Offset
				Scorch		//Wind Fire
				Storm		//Water Lightning
				Swift		//Wind Lightning
				Wood		//Water Earth
				Yang
				Yin
		//Tota Element
				Particle
		//Sage Element
				Nature

Stat
	var
		name
		Cur = 0 //Cur Stat
		Max = 0 //Max Stat -What they reset to without item buff or nerf
		Tru = 0 //Tru stat - Base stat without any buff or nerf
		CXP = 0 //Cur Experience
		MXP = 0 //Max Experience - Level up with this much
		Mod = 0 //Modplier - The amount the EXP is Modplied on addition
		Cap = 0 //Stat Limit - Aka the cap before it stops growing
		Gai = 0 //if its still gaining dont initiate another gain proc
	New(Nam,a,b,c,d,e)
		name=Nam
		Cur=a
		Max=a
		Tru=a
		CXP=b
		MXP=c
		Mod=d
		if(!Mod)
			Mod = 1
		Cap=e

	Primary
		StatDeduct(N,mob/Living/ME,mob/Living/THEM)
			if(!ME||N<1)
				return
			if(!M.KO && Cur)
				N = round(N,1)
				Cur -= N
				if(name == "Chakra")
					var/G=round(N*0.3,1)
					M.Chakra.XP(G,0,M)
					//if(WorldOMsg && M.OMsg)
						//M.OverMsg(M,"<b><font style=\"color:#202060;\">- [round(N,1)]</font></b>",5,5,1,0,8)
				if(name == "Stamina")
					var/G=round(N*0.1,1)
					M.Stamina.Added(G,M)
					if(Cur<=0 && !M.KO)
						M.KOCheck(N,THEM)
					//if(WorldOMsg && M.OMsg)
						//M.OverMsg(M,"<b><font style=\"color:#206020;\">- [round(N,1)]</font></b>",5,5,1,0,24,36)
				if(M.client)
					//Update panel and bars
				if(Cur<0)
					Cur=0

		XP(A,mob/ME)
			if(Cap)
				if(Tru>Cap)
					return
			CXP+=A*Mod
			if(!Gaining)
				if(CXP >= MXP)
					Gaining = 1
					var/Gained
					Again
					CXP-=MXP
					var/N = rand(40,120)
					Gained += N
					//Cur+=N
					if(Cap)
						var/T = Tru + Gained
						if(T>Cap)
							Gained = Cap - Tru
							CXP = 0
					MXP*=1.01
					if(prob(0.1))
						Mod += 0.01
					if(CXP>=MXP)
						goto Again
					Max+=Gained
					Tru+=Gained
					if(M.client)
						M << "Your [name] has increased by [Gained]!"
						/*if(WorldOMsg && M2.OMsg)
							M2.OverMsg(M,"<b><font style=\"color:#206020;\">+[Gained]</font></b>",5,5,1,0,24,36)*/
						//Make it update bars and panel
					Gaining = 0

	Fighting
		XP(A,mob/ME)
			if(Cap)
				if(Tru>Cap)
					return
			CXP+=A*Mod
			if(!Gaining)
				if(CXP >= MXP)
					Gaining = 1
					var/Gained
					Again
					CXP-=MXP
					var/N = rand(20,50)
					Gained += N
					//Cur+=N
					if(Cap)
						var/T = Tru + Gained
						if(T>Cap)
							Gained = Cap - Tru
							CXP = 0
					MXP*=1.01
					if(prob(0.1))
						Mod += 0.01
					if(CXP>=MXP)
						goto Again
					Cur+=Gained
					Max+=Gained
					Tru+=Gained
					if(ME.client)
						ME << "Your [name] has increased by [Gained]!"
						/*if(WorldOMsg && M2.OMsg)
							M2.OverMsg(M,"<b><font style=\"color:#206020;\">+[Gained]</font></b>",5,5,1,0,24,36)*/
						//Make it update bars and panel
					Gaining = 0
	Speed
		XP(A,mob/ME)
			if(Tru>Cap)
				CXP+=A*Mod
				if(!Gaining)
					if(CXP >= MXP)
						Gaining = 1
						var/Gained
						Again
						CXP-=MXP
						var/N = 0.01
						Gained += N
						//Cur+=N
						if(Cap)
							var/T = Tru - Gained
							if(T<Cap)
								Gained = Tru - Cap
								CXP = 0
						MXP*=1.01
						if(prob(0.1))
							Mod += 0.01
						if(CXP>=MXP)
							goto Again
						Cur-=Gained
						Max-=Gained
						Tru-=Gained
						if(M.client)
							M << "Your [name] has increased by [Gained]!"
							/*if(WorldOMsg && M2.OMsg)
								M2.OverMsg(M,"<b><font style=\"color:#206020;\">+[Gained]</font></b>",5,5,1,0,24,36)*/
							//Make it update bars and panel
						Gaining = 0
	Secondary
	Weapon
	Hidden
	Element

	proc
		StatDeduct(N,mob/ME,mob/THEM)
			set waitfor=0
			..()

		XP(A,mob/ME)
			set waitfor=0
			..()

			set waitfor=0
			CXP+=A*Mod
			if(Gaining)
				return
			if(CXP>=MXP)
				if(Cap)
					if(!findtext(name,"Speed"))
						if(Tru>=Cap)
							return
					else
						if(name=="Speed"&&Tru>=Cap)
							return
						else if (Tru<=Cap)
							return
				if(name=="Taijutsu"||name=="Ninjutsu"||name=="Genjutsu"||name=="Health"||name=="Chakra"||name=="Stamina")
					var/Gain
					if(name=="Health"||name=="Chakra"||name=="Stamina")
						Gain=rand(HSCMinGain,HSCMaxGain)
					else
						Gain=rand(TNGMinGain,TNGMaxGain)
					StatMIncrease(Gain,M)
				else
					StatMIncrease(1,M)

		StatUp(N,mob/ME)
			set waitfor=0
			set background=1
			..()
			Gaining = 1
			var/Gained
			var/Redo
			Again
			CXP-=MXP
			Gained += N
			if(name=="Level")
				Cur++
				Tru++
				Max++
			else if(name=="Speed")
				Max++
				Tru++
				Cur++
				M.step_size++
			else if(findtext(name,"Speed"))
				Max--
				Tru--
				Cur--
			else
				Max+=N
				Tru+=N
				//Cur+=N
			if(StatCap)
				if(Tru>Cap)
					Cur=Cap
					Max=Cap
					Tru=Cap
			MXP*=1.01
			if(StatMGrow)
				if(prob(0.1))
					Mod += 0.01
			if(CXP>=MXP)
				Redo=1
				goto Again
			if(M.client)
				if(name=="Level")
					//M<<"You have leveled up!"
					M << "You leveled up!"
				else
					//M<<"Your [name] has increased!"
					M << "Your [name] has increased!"
				M2 << output(list2params(list(name,Cur,Max)),"Panel1:UpdateStat")
				M2 << output(list2params(list(name,Cur,Max)),"Panel2:UpdateStat")
				if(WorldOMsg && M2.OMsg)
					M2.OverMsg(M,"<b><font style=\"color:#206020;\">+[Gained]</font></b>",5,5,1,0,24,36)
				if(name=="Health"||name=="Stamina"||name=="Chakra")
					winset(M, "[name]Bar", "value = [round((Cur / Max) * 100)]")
			Gaining = 0

		Buff(N)
			Max += N
			Cur += N

		Nerf(N)
			Max -= N
			Cur -= N
			if(Max<Tru)
				Max = Tru
			if(Cur<Max)
				Max = Cur

		StatIncrease(N,var/PLAYER(M))
			set waitfor = 0
			if(Cur >= Max)
				return
			Cur += N
			if(Cur > Max)
				Cur = Max
			if(M.client)
				if(name=="Health"||name=="Stamina"||name=="Chakra")
					if(WorldOMsg && M.OMsg)
						if(name=="Health")
							M.OverMsg(M,"<b><font style=\"color:#602020;\">+ [round(N,1)]</font></b>",5,5,1,0,-8)
						else if(name=="Stamina")
							M.OverMsg(M,"<b><font style=\"color:#206020;\">+ [round(N,1)]</font></b>",5,5,1,0,24,36)
						else //if(name=="Chakra")
							M.OverMsg(M,"<b><font style=\"color:#202060;\">+ [round(N,1)]</font></b>",5,5,1,0,8)
					winset(M, "[name]Bar", "value = [round((Cur / Max) * 100)]")
				M << output(list2params(list(name,Cur,Max)),"Panel1:UpdateStat")
				M << output(list2params(list(name,Cur,Max)),"Panel2:UpdateStat")

		Reset(N)
			if(N)
				Cur=Max
			else
				Cur=Tru
				Max=Tru