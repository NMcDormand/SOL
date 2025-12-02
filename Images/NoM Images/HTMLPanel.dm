client/Topic(href, list/href_list)
	..()
	var/action = href_list["action"]
	var/PLAYER(M)=usr
	switch(action)
		if ("ChangePanel")
			winset(usr, "map1", "focus=true")
		if ("UseVerb")
			switch(href_list["VUsed"])
				if("Attack")
				if("Analysis")
					var/mob/Living/Player/Admin/Helper/MM=M
					var/obj/A=locate(href_list["OClicked"])
					MM.Variable_Analysis(A)
				if("Close")
				if("Create")
				if("Delete")
					var/obj/A=locate(href_list["OClicked"])
					del A
					M.UpdateItems()
				if("Dispel")
				if("Drop")
					var/obj/Item/A=locate(href_list["OClicked"])
					A.Drop()
				if("Drink")
				if("Eat")
				if("Equip")
					var/obj/Item/A=locate(href_list["OClicked"])
					if(istype(A,/obj/Item/Wear/Clothes))
						var/obj/Item/Wear/Clothes/AB=A
						AB.Equip()
					else if(istype(A,/obj/Item/Wear/Weapons/Wield))
						var/obj/Item/Wear/Weapons/Wield/AB=A
						AB.Equip()
				if("Edit")
					var/mob/Living/Player/Admin/Admin/MM=M
					var/obj/A=locate(href_list["OClicked"])
					MM.Edit(A)
					spawn(5)winset(MM,"EditPage.Search","focus=true")
				if("Fill")
				if("Focus")
				if("Fish")
				if("Follow")
				if("Forget")
				if("Inspect")
					var/obj/Item/A=locate(href_list["OClicked"])
					A.Inspect()
				if("Locate")
				if("Options")
				if("Place")
				if("Pick Up")
				if("Read")
				if("Release")
				if("Remember")
				if("Smelt")
				if("Stop")
				if("Summon")
				if("Switch")
				if("Throw")
				if("UpdateItems")
					M.UpdateItems(href_list["Subject"])
				if("Upgrade")
				if("Use")
					var/obj/A=locate(href_list["OClicked"])
					A.DblClick()
		if ("ReFocus")
			winset(usr,"map1","focus=true")
		if ("SendMsg")
			if(href_list["MsgTgt"] == "World")
				world << "[href_list["Msg"]]"
			if(href_list["MsgTgt"] == "usr")
				src << "[href_list["Msg"]]"
		if ("UpdateItems")
			M.UpdateItems()
		if ("ClickObject")
			var/obj/A=locate(href_list["OClicked"])
			A.DblClick()
	..()

mob/Living/Player
	proc
		LoadPanel(var/type)
			set background=1,waitfor=0
			var/PanelHTML,Style,Script
			//var/i="\[i]"
			/* Example of default
			if(type=="Name")
				Script={"
				"}
				Style={"
				"}
				PanelHTML={"
				"}
			*/
			if(type=="Stats")
				Script={"
				"}
				Style={"
				"}
				//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				var/Stats1,Stats2
				for(var/B in vars)
					if(istype(vars[B],/Stat))
						var/Stat/A=vars[B]
						if(!(A.Name == "Health"||A.Name == "Stamina"||A.Name == "Energy"||A.Name == "Level"))
							/*if(A.Name=="Willpower"||A.Name=="Reflexes"||A.Name=="Spear"||A.Name=="Attack Speed")
								Stats2 += \
								{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current]</span></div><br>"}
							else*/
							Stats2 += \
							{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current]</span></div>"}
						else if(A.Name != "Level")
							Stats1 += \
							{"<div class="StEs" id="U[A.Name]"><div>[A.Name]:</div><p class="Desc" style="display:none;">Description Here</p><span id="[A.Name]">[A.Current] / [A.Max]</span></div>"}

				PanelHTML={"
					<body onload="" oncontextmenu="ReFocus()" onclick="ReFocus()">
						<div class="ContA" id="Page1">
							<div class="ContC" id="BasicInfo"><button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Basic Info</span><img class="BarRO"></button>
								<div class="ContP">
									<div class="StEb"id="UName"><span id="Name1">[Name1]</span> <span id="Alias">[Alias]</span></div>
									<div class="StE" id="ULevel"><div >Level:</div><p class="Desc" style="display:none;">Description Here</p><span id="Level">[Level.Current]</span></div>
									<div class="StE" id="UYen"><div >Yen:</div><p class="Desc" style="display:none;">Description Here</p><span id="Gold">[Yen]</span></div>
									<div class="StE" id="UZWord"><div >Location:</div><p class="Desc" style="display:none;">Description Here</p><span id="ZWord">[ZWord]</span></div>
								</div>
							</div>
							<div class="ContC" id="PrimaryStats"><button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Primary Stats</span><img class="BarRO"></button>
								<div class="ContP" style="display:;">
									[Stats1]
								</div>
							</div>
						</div>
						<div class="ContA" id="Page2">
							<div class="ContC" id="SecondaryStats"><button class="ButC" onclick="showC(this)" ><img class="BarL"><span class="CatName">Secondary Stats</span><img class="BarRC"></button>
								<div class="ContP" style="display:none;">
									[Stats2]
								</div>
							</div>
						</div>
					</body>
				"}
			if(type=="Items")
				/*for(var/obj/A in usr.contents)
					usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")*/
				var
					General
					Weapons
					Clothing
					Food
					Material
					C1=0;C2=0;C3=0;C4=0;C5=0
					B1=1000;B2=1000;B3=1000;B4=1000;B5=1000
					Verbs1= \
						{"<button class="Verb" onclick="UseVerb(this)">Drop</button>
						<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
					Verbs2
				if(GM>=1)
					Verbs1 += \
						{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
					if(GM>=4)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
							<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
				for(var/obj/Item/A in usr.contents)
					usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
					Verbs2=null
					if(istype(A,/obj/Item/Wear/Weapons))
						C2++
						if(C2==4)
							B2--
							C2=0
						if(istype(A,/obj/Item/Wear/Weapons/Wield))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
						if(istype(A,/obj/Item/Wear/Weapons/Thrown))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Throw</button>"}
						Verbs2 +=Verbs1
						Weapons += \
							{"<div class="Item" style="z-index:[B2];" ObjRef="\ref[A]" ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					else if(istype(A,/obj/Item/Wear/Clothes))
						C3++
						if(C3==4)
							B3--
							C3=0
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
						Verbs2 +=Verbs1
						Clothing += \
							{"<div class="Item" style="z-index:[B3];" ObjRef="\ref[A]"ObjEquipped="[A.Equipped]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					else if(istype(A,/obj/Item/Food))
						C4++
						if(C4==4)
							B4--
							C4=0
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
						Verbs2 +=Verbs1
						Food += \
							{"<div class="Item" style="z-index:[B4];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					else if(istype(A,/obj/Item/Materials))
						C5++
						if(C5==4)
							B5--
							C5=0
						Verbs2 +=Verbs1
						Material += \
							{"<div class="Item" style="z-index:[B5];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					else
						C1++
						if(C1==4)
							B1--
							C1=0
						Verbs2 +=Verbs1
						General += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}

				Script={"
						function showC(el){
							var inner = el.nextSibling.nextSibling;
							var ButR = el.lastChild;
							if (inner.style.display == "none")
								{inner.style.display = "";
								ButR.className = "BarRO";}
							else
								{inner.style.display = "none";
								ButR.className = "BarRC";}
						}
						function ClearVerbs(){
							var ContEL = document.getElementsByTagName('div');
							for (i = 0; i < ContEL.length; i++) {
								var Blur=document.getElementsByTagName('div')\[i]
								if(Blur.className=="ObjVerbs"){Blur.style.display = "none" }
							}
						}
						function ClickObject(el)
							{window.location='byond://?src=\ref[src]&action=ClickObject&OClicked='+el.ObjRef;}
						function DispVerb(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){
								ClearVerbs(el);
								inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function UseVerb(el){
							var elem = el.parentNode.parentNode;var JustDoIt=1
							if(el.innerHTML== "Drop")
								{if(elem.ObjEquipped>0){var DropMsg = "You need to unequip it first!";window.location='byond://?src=\ref[src]&action=SendMsg&Msg='+DropMsg+'&MsgTgt=usr';return;}
								}
							window.location='byond://?src=\ref[src]&action=UseVerb&VUsed='+el.innerHTML+'&OClicked='+elem.ObjRef;}
						function UpdateItems(ObjType,Obj){
							var Blah = document.getElementById(ObjType);
							if(Obj){
								Blah.innerHTML=null;
								Blah.innerHTML=Obj;
							}
						}
						function UpdatePanel(){window.location='byond://?action=UpdateItems';}
				"}
				Style={"
						body		{overflow-x:hidden;font-family:Arial;background:#070707;color:#BBB;font-size:10pt;scrollbar-base-color:#151515;scrollbar-highlight-color:#070707;scrollbar-arrow-color:#151515;scrollbar-face-color:#151515;scrollbar-shadow-color:#070707;width:100%;margin:0px;}
						.ContC		{z-index:004;position:relative;vertical-align:top;margin:0px auto;display:inline-block;*display:inline;zoom:1;*float:none;Width:325px;}
						.ButO		{position:relative;background:url(http://mysting.net/Nom/BarBg.png);border:0px;height:28px;width:100%;margin:0px;padding:0px;}
						.ButO img	{position:absolute;right:-8px;width:28px;height:28px;}
						.ButO span	{position:absolute;left:20px;top:7px;color:#BBB;font-weight:Bold;}
						.BarL 		{position:absolute;background:url(http://mysting.net/Nom/BarL.png);left:0px;}
						.BarRC		{position:relative;background:url(http://mysting.net/Nom/BarCB2.png);}
						.BarRO		{position:relative;background:url(http://mysting.net/Nom/BarOB2.png);}
						.ContO		{position:relative;}
						.Item		{position:relative;display:inline-block;*display:inline;zoom:1;background: url(http://mysting.net/Nom/Items.png);width:70px;height:70px;margin:5px;text-align:center;}
						.Item img	{position:absolute;bottom:8px;left:19px;}
						.OName		{position:relative;top:4px;font-size:7pt;width:60px;font-weight:Bold;}
						.ObjVerbs	{position:absolute;filter:alpha(opacity=80);background: #070707;top:-5px;right:-5px;width:60px;height:80px;padding:3px;}
						.Verb		{position:relative;color:#BBB;background:#070707;padding:0px;margin:0px auto;border:0px;height:16px;font-size:8pt;width:100%;}
						#C1			{z-index:005;position:relative;}
						#C2			{z-index:004;position:relative;}
						#C3			{z-index:003;position:relative;}
						#C4			{z-index:002;position:relative;}
						#C5			{z-index:001;position:relative;}
						#Refresh	{z-index:002;position:relative;left:320px;background:url(http://mysting.net/Nom/Refresh.png);height:16px;width:16px;border:0px;}
				"}
				PanelHTML={"
					<body onload="" oncontextmenu="ReFocus()" onclick="ReFocus()">
						<div class="ContB">
							<div class="ContC" id="C1">
								<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">General</span><img class="BarRO"></button>
								<div id="General">
									[General]
								</div>
							</div>
							<div class="ContC" id="C2">
								<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Weapons</span><img class="BarRO"></button>
								<div id="Weapons">
									[Weapons]
								</div>
							</div>
							<div class="ContC" id="C3">
								<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Clothing</span><img class="BarRO"></button>
								<div id="Clothing">
									[Clothing]
								</div>
							</div>
							<div class="ContC" id="C4">
								<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Food</span><img class="BarRO"></button>
								<div id="Food">
									[Food]
								</div>
							</div>
							<div class="ContC" id="C5">
								<button class="ButO" onclick="showC(this)"><img class="BarL"><span class="CatName">Material</span><img class="BarRO"></button>
								<div id="Material">
									[Material]
								</div>
							</div>
						</div>
						<button id="Refresh" onclick="UpdatePanel()"></button>
					</body>
				"}
			PanelHTML={"
			<html>
				<head>
					<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
					<title>[type]</title>
				</head>
				<style type="text/css">
					[Style]
				</style>
				<script type="text/javascript">
					[Script]
					function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
				</script>
				[PanelHTML]
			</html>
			"}
			if(type=="Items")
				winset(src,"Browsers","is-visible=true")
				src << browse(PanelHTML,"Window=Panel;")
			else
				src << browse(PanelHTML,"Window=Panel[type];size=345x400")
mob//Living/Player
	proc
		UpdateItems(B,C)
			set background=1
			set waitfor=0
			var
				PLAYER(M)=src
				Subject
				Verbs1
				Verbs2
				C1=0
				B1=1000
			if(B=="Items"||!B)
				Verbs1+= \
						{"<button class="Verb" onclick="UseVerb(this)">Drop</button>
						<button class="Verb" onclick="UseVerb(this)">Inspect</button>"}
				if(M.GM>=1)
					Verbs1 += \
						{"<button class="Verb" onclick="UseVerb(this)">Analysis</button>"}
					if(M.GM>=4)
						Verbs1 += \
							{"<button class="Verb" onclick="UseVerb(this)">Edit</button>
							<button class="Verb" onclick="UseVerb(this)">Delete</button>"}
				if(!C||C=="Weapons")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Wear/Weapons/A in contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						if(istype(A,/obj/Item/Wear/Weapons/Wield))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
						if(istype(A,/obj/Item/Wear/Weapons/Thrown))
							Verbs2 += \
								{"<button class="Verb" onclick="UseVerb(this)">Throw</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					src << output(list2params(list("Weapons",Subject)),"Browsers.Panel:UpdateItems")
				if(!C||C=="Clothing")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Wear/Clothes/A in contents)
						world<<"found one"
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Equip</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					src << output(list2params(list("Clothing",Subject)),"Browsers.Panel:UpdateItems")
				if(!C||C=="Food")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Food/A in contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 += \
							{"<button class="Verb" onclick="UseVerb(this)">Use</button>"}
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					src << output(list2params(list("Food",Subject)),"Browsers.Panel:UpdateItems")
				if(!C||C=="Material")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/Materials/A in contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
						Verbs2=null
						Verbs2 +=Verbs1
						Subject += \
							{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					src << output(list2params(list("Material",Subject)),"Browsers.Panel:UpdateItems")
				if(!C||C=="General")
					Subject=null
					C1=0
					B1=1000
					for(var/obj/Item/A in contents)
						C1++
						if(C1==4)
							B1--
							C1=0
						if(!istype(A,/obj/Item/Wear)&&!istype(A,/obj/Item/Food)&&!istype(A,/obj/Item/Materials))
							usr << browse_rsc(icon(A.icon, A.icon_state), "[A.Name1].png")
							Verbs2=null
							Verbs2 +=Verbs1
							Subject += \
								{"<div class="Item" style="z-index:[B1];" ObjRef="\ref[A]" ondblclick="ClickObject(this)" oncontextmenu="DispVerb(this);return false;"><span class="OName">[A.name]</span><br><img src='[A.Name1].png'><div class="ObjVerbs" style="display:none;">[Verbs2]</div></div>"}
					src << output(list2params(list("General",Subject)),"Browsers.Panel:UpdateItems")