obj/var/tmp/Clashed
proc
	JutsuClash_Fire(obj/A,obj/B)
		if(B.WaterElemental) {B.WaterElemental*=0.8; del(A)}
		else if (B.WindElemental) {A.loc=B.loc; A.FireElemental+=(B.WindElemental*5); del(B)}
		else if (B.IceElemental)
			if(A.FireElemental>B.IceElemental) {A.loc=B.loc; A.FireElemental-=(B.IceElemental*0.7); del(B)}
			else {B.IceElemental-=(A.FireElemental*0.7); del(A)}
		else {del(A); del(B)}

	JutsuClash_Water(obj/A,obj/B)
		var/mob/O=A.Owner
		var/mob/b=B.Owner
		if(B.FireElemental) {A.loc=B.loc; del(B)}
		else if(B.LightningElemental)
			A.loc=B.loc; A.LightningElemental=B.LightningElemental
			if(A.CanBeShocked&&O!=b) {var/dmg=B.LightningElemental*5; O.Death(b,dmg,"electricrecoil")}
		else {del(A); del(B)}

	JutsuClash_Lightning(obj/A,obj/B)
		var/mob/b=A.Owner
		if(B.EarthElemental) {del(A)}
		else if(B.WaterElemental)
			B.loc=A.loc; A.LightningElemental=(b.LightningElemental+(B.WaterElemental*5))

	JutsuClash_Earth(obj/A,obj/B)
		if(B.LightningElemental) {A.loc=B.loc; del(B)}
		else if(B.WindElemental) {A.loc=B.loc; A.EarthElemental*=0.5; A.movespeed++}
		else {del(A); del(B)}

	JutsuClash_Wind(obj/A,obj/B)
		if(B.EarthElemental) {A.loc=B.loc; B.EarthElemental-=A.WindElemental*0.7; B.movespeed++}
		else {del(A); del(B)}

	JutsuClash_Ice(obj/A,obj/B)
		if(B.FireElemental)
			if(B.FireElemental>A.IceElemental) {B.FireElemental-=(A.IceElemental*0.7); del(A)}
			else {A.loc=B.loc; A.IceElemental-=(B.FireElemental*0.7); del(B)}
		else {del(A); del(B)}

	JutsuClash_Wood(obj/A,obj/B)
		if(B.FireElemental) {del(A)}
		else if(B.WaterElemental) {A.loc=B.loc; del(B)}
		else {del(A); del(B)}
