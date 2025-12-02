mob/VerbHolder/Admin/Level5/verb
	Build_Villages()
		Village_Reset()

proc
	Village_Reset()
		//Village Maker
		var/Infobox/Village/A=new/Infobox/Village
		A.Name="Cloud"
		A.Desc="Cloud Village is a quiet yet large village to the North-East. Village members have Lightning natured chakra"
		A.AssHair="Gaara"
		A.AssColor="#000000"
		A.AssSkin="Dark"
		A.AssName="Yuri Suzuki"
		A.AssEye="#000000"
		A.AssGender="female"
		VillageData["CloudLabel"]=A

		var/Infobox/Village/B=new/Infobox/Village
		B.Name="Leaf"
		B.Desc="Leaf village is centrally located in the world, making traveling easier and faster. Leaf ninjas have Fire natured chakra"
		B.AssHair="Orochimaru"
		B.AssColor="#992020"
		B.AssSkin="Pale"
		B.AssName="Rei Fujimoto"
		B.AssEye="#000000"
		B.AssGender="female"
		VillageData["LeafLabel"]=B

		var/Infobox/Village/C=new/Infobox/Village
		C.Name="Grass"
		C.Desc="Grass village has more chickens than the other villages. ninjas from Grass are free to choose whatever elemental augment they desire"
		C.AssHair="LongStraight"
		C.AssColor="#999920"
		C.AssSkin="Tan"
		C.AssName="Hiroto Kimura"
		C.AssEye="#000000"
		C.AssGender="male"
		VillageData["GrassLabel"]=C

		var/Infobox/Village/D=new/Infobox/Village
		D.Name="Mist"
		D.Desc="Mist nins will be able to learn the Water Prison technique; Their chakra is Water natured"
		D.AssHair="Konan"
		D.AssColor="#999920"
		D.AssSkin="Medium"
		D.AssName="Ren Mori"
		D.AssEye="#000000"
		D.AssGender="female"
		VillageData["MistLabel"]=D

		var/Infobox/Village/E=new/Infobox/Village
		E.Name="Rain"
		E.Desc="Rain Village is easier to defend as it only has one entrance. Rain ninjas align with Water or Lightning M.Elements"
		E.AssHair="Sakura"
		E.AssColor="#209999"
		E.AssSkin="Pale"
		E.AssName="Naoko Hisakawa"
		E.AssEye="#000000"
		E.AssGender="female"
		VillageData["RainLabel"]=E

		var/Infobox/Village/F=new/Infobox/Village
		F.Name="Rock"
		F.Desc="Those from Rock Village will be adept at finding rocks and will have Earth natured chakra"
		F.AssHair="Hidan"
		F.AssColor="#999999"
		F.AssSkin="Medium"
		F.AssName="Haruki Ito"
		F.AssEye="#000000"
		F.AssGender="male"
		VillageData["RockLabel"]=F

		var/Infobox/Village/G=new/Infobox/Village
		G.Name="Sound"
		G.Desc="Sound ninja can learn exclusive sound based techniques; Their chakra aligns with Wind"
		G.AssHair="Ino"
		G.AssColor="#209945"
		G.AssSkin="Pallid"
		G.AssName="Daichi Hisakawa"
		G.AssEye="#000000"
		G.AssGender="male"
		VillageData["SoundLabel"]=G

		var/Infobox/Village/H=new/Infobox/Village
		H.Name="Sand"
		H.Desc="Members of Sand Village will have an easier path as a Sand Nin than other ninjas will. Their chakra is Wind natured"
		H.AssGender="male"
		H.AssHair="Hashirama"
		H.AssColor="#994520"
		H.AssSkin="Tan"
		H.AssEye="#000000"
		H.AssName="Eiji Hiyashi"
		VillageData["SandLabel"]=H

		var/Infobox/Village/I=new/Infobox/Village
		I.Name="Waterfall"
		I.Desc="Waterfall ninja are able to climb waterfalls at much lower Chakra Control levels. Waterfall ninja have either Water or Lightning natured chakra"
		I.AssHair="LongStraight"
		I.AssColor="#101045"
		I.AssSkin="Medium"
		I.AssName="Bam"
		I.AssEye="#000000"
		I.AssGender="male"
		VillageData["WaterfallLabel"]=I

		var/Infobox/Village/J=new/Infobox/Village
		J.Name="Missing"
		J.Desc="Missing nin have no advantages, they are limited greatly in what can be done"
		VillageData["MissingLabel"]=J

		var/savefile/J1 = new("Data/Wipe/Villages.sav")
		J1["VillageData"]<<VillageData

	Village_Fix()
		//Village Maker
		if(!VillageData["CloudLabel"])
			var/Infobox/Village/A=new/Infobox/Village
			A.Name="Cloud"
			A.Desc="Cloud Village is a quiet yet large village to the North-East. Village members have Lightning natured chakra"
			A.AssHair="Gaara"
			A.AssColor="#000000"
			A.AssSkin="Dark"
			A.AssName="Yuri Suzuki"
			A.AssEye="#000000"
			A.AssGender="female"
			VillageData["CloudLabel"]=A

		if(!VillageData["LeafLabel"])
			var/Infobox/Village/B=new/Infobox/Village
			B.Name="Leaf"
			B.Desc="Leaf village is centrally located in the world, making traveling easier and faster. Leaf ninjas have Fire natured chakra"
			B.AssHair="Orochimaru"
			B.AssColor="#992020"
			B.AssSkin="Pale"
			B.AssName="Rei Fujimoto"
			B.AssEye="#000000"
			B.AssGender="female"
			VillageData["LeafLabel"]=B

		if(!VillageData["GrassLabel"])
			var/Infobox/Village/C=new/Infobox/Village
			C.Name="Grass"
			C.Desc="Grass village has more chickens than the other villages. ninjas from Grass are free to choose whatever elemental augment they desire"
			C.AssHair="LongStraight"
			C.AssColor="#999920"
			C.AssSkin="Tan"
			C.AssName="Hiroto Kimura"
			C.AssEye="#000000"
			C.AssGender="male"
			VillageData["GrassLabel"]=C

		if(!VillageData["MistLabel"])
			var/Infobox/Village/D=new/Infobox/Village
			D.Name="Mist"
			D.Desc="Mist nins will be able to learn the Water Prison technique; Their chakra is Water natured"
			D.AssHair="Konan"
			D.AssColor="#999920"
			D.AssSkin="Medium"
			D.AssName="Ren Mori"
			D.AssEye="#000000"
			D.AssGender="female"
			VillageData["MistLabel"]=D

		if(!VillageData["RainLabel"])
			var/Infobox/Village/E=new/Infobox/Village
			E.Name="Rain"
			E.Desc="Rain Village is easier to defend as it only has one entrance. Rain ninjas align with Water or Lightning M.Elements"
			E.AssHair="Sakura"
			E.AssColor="#209999"
			E.AssSkin="Pale"
			E.AssName="Naoko Hisakawa"
			E.AssEye="#000000"
			E.AssGender="female"
			VillageData["RainLabel"]=E

		if(!VillageData["RockLabel"])
			var/Infobox/Village/F=new/Infobox/Village
			F.Name="Rock"
			F.Desc="Those from Rock Village will be adept at finding rocks and will have Earth natured chakra"
			F.AssHair="Hidan"
			F.AssColor="#999999"
			F.AssSkin="Medium"
			F.AssName="Haruki Ito"
			F.AssEye="#000000"
			F.AssGender="male"
			VillageData["RockLabel"]=F

		if(!VillageData["SoundLabel"])
			var/Infobox/Village/G=new/Infobox/Village
			G.Name="Sound"
			G.Desc="Sound ninja can learn exclusive sound based techniques; Their chakra aligns with Wind"
			G.AssHair="Ino"
			G.AssColor="#209945"
			G.AssSkin="Pallid"
			G.AssName="Daichi Hisakawa"
			G.AssEye="#000000"
			G.AssGender="male"
			VillageData["SoundLabel"]=G

		if(!VillageData["SandLabel"])
			var/Infobox/Village/H=new/Infobox/Village
			H.Name="Sand"
			H.Desc="Members of Sand Village will have an easier path as a Sand Nin than other ninjas will. Their chakra is Wind natured"
			H.AssGender="male"
			H.AssHair="Hashirama"
			H.AssColor="#994520"
			H.AssSkin="Tan"
			H.AssEye="#000000"
			H.AssName="Eiji Hiyashi"
			VillageData["SandLabel"]=H

		if(!VillageData["WaterfallLabel"])
			var/Infobox/Village/I=new/Infobox/Village
			I.Name="Waterfall"
			I.Desc="Waterfall ninja are able to climb waterfalls at much lower Chakra Control levels. Waterfall ninja have either Water or Lightning natured chakra"
			I.AssHair="LongStraight"
			I.AssColor="#101045"
			I.AssSkin="Medium"
			I.AssName="Bam"
			I.AssEye="#000000"
			I.AssGender="male"
			VillageData["WaterfallLabel"]=I

		if(!VillageData["MissingLabel"])
			var/Infobox/Village/J=new/Infobox/Village
			J.Name="Missing"
			J.Desc="Missing nin have no advantages, they are limited greatly in what can be done"
			VillageData["MissingLabel"]=J

		var/savefile/J1 = new("Data/Wipe/Villages.sav")
		J1["VillageData"]<<VillageData