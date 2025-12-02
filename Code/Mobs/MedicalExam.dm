mob/var/tmp
	MedicalScore
	TakingMedical
mob/proc
	MedicalExam(mob/M)
		if(TakingMedical)
			src<<"You're already taking the exam."; return
		else
			MedicalScore=0
			TakingMedical=1

			if(get_dist(src,M)<=3)
				switch(input("How many Chakra Gates are there in a human body","Question Two")as num)
					if(8) MedicalScore++
			else
				TakingMedical=null


			if(get_dist(src,M)<=3)
				switch(input({"What is the purpose of "Shousen"?"},"Question Five")in list("To blind a foe","To heal others","To poison a foe","To revive the dead"))
					if("To heal others") MedicalScore++
			else
				TakingMedical=null


			if(get_dist(src,M)<=3)
				switch(input({"What is a Medical Ninja's main tool?"},"Question Three")in list("Kunai","Scalpels","Hypodermic Needle","Broad Sword","All of the above","None of the above"))
					if("Scalpels") MedicalScore++
			else
				TakingMedical=null


			if(get_dist(src,M)<=3)
				switch(input("How many Tenketsus are there in a human body","Question Four")as num)
					if(361) MedicalScore++
			else
				TakingMedical=null


			if(get_dist(src,M)<=3)
				switch(input({"What is the purpose of "Chakra no Mesu"?"},"Question One")in list("To heal others","To heal yourself","To create chakra scalpels","To prevent someone from using their chakra"))
					if("To create chakra scalpels") MedicalScore++
			else
				TakingMedical=null


			if(get_dist(src,M)<=3) MedicalExamCheck()

	MedicalExamCheck()
		spawn(20)
			if(MedicalScore==5)
				src<<"<b>Congratulations! You have passed the Medical Exam!</b>"
				ReAssignProfession("Medical-Nin"); TakingMedical=0; return
			else
				TakingMedical=null; src<<"You have failed the Medical Exam!"; return