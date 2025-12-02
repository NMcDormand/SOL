mob
	proc
		ResetRebirth()
			Cap_Stamina=2000; Cap_Chakra=400; Cap_Genjutsu=1000; Cap_Ninjutsu=1000; Cap_Taijutsu=1000
			fdel("Saves/[copytext(ckey, 1, 2)]/[ckey]/[Slot]/Rebirth.sav")
			RebirthData = null
			RebirthData = new(src)

			var/A = NinjaRank
			var/Stop

			//src << "As an apology we are granting you 300 Stat Points for resetting your Rebirth profiles"
			//StatPoints += 300
			//StatUpdate_statpoints()
			switch(A)
				if("Academy Student")
					Stop = 0
				if("Genin")
					Stop = 1
				if("Chuunin")
					Stop = 2
				if("Special Jounin")
					Stop = 3
				if("Anbu")
					Stop = 4
				if("Jounin")
					Stop = 5
				if("Kage Level")
					Stop = 6
				else
					Stop = 7
			for(var/i = 1 to Stop)
				switch(i)
					if(1)
						NinjaRank = "Genin"
					if(2)
						NinjaRank = "Chuunin"
					if(3)
						NinjaRank = "Special Jounin"
					if(4)
						NinjaRank = "Anbu"
					if(5)
						NinjaRank = "Jounin"
					if(6)
						NinjaRank = "Kage Level"
					if(7)
						NinjaRank = A
				AddCaps()
			NinjaRank = A
			StatUpdate_rank();

		ResetJustRebirth()
			fdel("Saves/[copytext(ckey, 1, 2)]/[ckey]/[Slot]/Rebirth.sav")
			RebirthData = null
			RebirthData = new(src)