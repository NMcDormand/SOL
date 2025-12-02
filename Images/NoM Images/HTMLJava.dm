mob/Living/Player
	proc
		JavaGenerate(WPAN=1)
			var
				i = "\[i]"
				t = "\[t]"
				g = "\[g]"
				A = "\[A]"
				Chats ="\['OOC','Say','Vil','Gui','Pri','Adm','Dam','Gai','Mac','Tim','Ann']"
				//list/Panel = UIColour["Panel[WPAN]"]
				Java = {"
				var TOOC = true;
				var TSay = true;
				var TVil = true;
				var TGui = true;
				var TPri = true;
				var TAdm = true;
				var TDam = true;
				var TGai = true;
				var TMac = true;
				var TAnn = true;
				var Tock = 1;
				var PCHC = 0;
				function AddChat(Type,MSG,Ref,Sent){ //Ref would be \[src]
					var Box = document.getElementById('ChatBox');
					var B = true
					switch(Type){
						case "OOC":
							B = TOOC;
							break;
						case "Say":
							B = TSay;
							break;
						case "Vil":
							B = TVil;
							break;
						case "Gui":
							B = TGui;
							break;
						case "Pri":
							B = TPri;
							break;
						case "Adm":
							B = TAdm;
							break;
						case "Dam":
							B = TDam;
							break;
						case "Gai":
							B = TGai;
							break;
						case "Mac":
							B = TMac;
							break;
						case "TAnn":
							B = TAnn;
							break;
					}
					var DISP = B ? "block":"none";
					if(Type != "Pri"){
						Box.innerHTML += "<div class='"+Type+"' style='display:"+DISP+";'>"+MSG+"</div>";
					}else{
						var Privs = document.getElementsByClassName("PTogs");
						var A = 0;
						var i = Privs.length;
						while(i--){
							if(Privs[i].getAttribute('data-Player') == Ref || Privs[i].getAttribute('data-Player') == "All"){
								if(!Sent){
									if(document.getElementById('PrivSet').getAttribute('data-Player') != Ref && document.getElementById('PrivSet').getAttribute('data-Player') != "All"||document.getElementById('ChatInd').innerHTML != "Priv" && !TPri){
										var C = parseInt(Privs[i].firstElementChild.innerHTML,10)||0;
										C++
										Privs[i].firstElementChild.innerHTML = C;
										document.getElementById('PrivO').firstElementChild.removeAttribute('style');
										document.getElementById('POpts').firstElementChild.removeAttribute('style');
									}
								}
								if(Privs[i].getAttribute('data-Player') == Ref){
									A++
								}
							}
						}
						if(!Sent){
							document.getElementById('PrivO').firstElementChild.innerHTML = document.getElementById('PrivSet').firstElementChild.firstElementChild.innerHTML;
							document.getElementById('POpts').firstElementChild.innerHTML = document.getElementById('PrivSet').firstElementChild.firstElementChild.innerHTML;
						}
						if(document.getElementById('PrivSet').getAttribute('data-Player') != "All"){
							if(Ref != document.getElementById('PrivSet').getAttribute('data-Player')){
								DISP = "none";
							}onclick="window.location.href='?src=\ref[src];action=PM'"
						}
						Box.innerHTML += "<div class='"+Type+"' style='display:"+DISP+";' >"+MSG+"</div>";
						//window.location.href=?src=\ref[src];action=PM
						if(!A){
							if(document.getElementById('PrivSet').getAttribute('data-Player') != Ref && document.getElementById('PrivSet').getAttribute('data-Player') != "All" || document.getElementById('ChatInd').innerHTML != "Priv" && !TPri){
								document.getElementById("PrivSet").innerHTML+="<div class='PTogs' data-Player='"+Ref+"' onclick='SwitchPriv(this)'><span class='PNote'>1</span>"+Ref+"<button class='PClose' onclick='CloseChat(this)'>x</button></div>";
							}else{
								document.getElementById("PrivSet").innerHTML+="<div class='PTogs' data-Player='"+Ref+"' onclick='SwitchPriv(this)'><span class='PNote'>0</span>"+Ref+"<button class='PClose' onclick='CloseChat(this)'>x</button></div>";
							}
						}
					}
					if(document.getElementById('PageInd').innerHTML == "Chat"){
						BottomBoy();
					}
				}
				function BottomBoy(){
					window.scrollTo(0, document.body.scrollHeight);
				}
				function CloseChat(el){
					PCHC++;
					var A = el.parentNode.getAttribute('data-Player');
					var txt;
					if(!confirm("This will delete all messages")) {
						return;
					}
					var Whisps = document.getElementsByClassName("Pri");
					var i = Whisps.length;
					while(i--){
						if(Whisps[i].firstElementChild.getAttribute('data-Player') == A || A == "All"){
							Whisps[i].parentNode.removeChild(Whisps[i]);
						}
					}
					if(A == "All"){
						var PIChats = document.getElementsByClassName("PTogs");
						var t = PIChats.length;
						while(t--){
							if(PIChats[t].getAttribute('data-Player') !="All"){
								PIChats[t].parentNode.removeChild(PIChats[t]);
							}
						}
					}else{
						el.parentNode.parentNode.removeChild(el.parentNode);
					}
				}
				function ContextME(el){
					if(el.className == "PlayerName"){
						HideContext();
						el.firstElementChild.style.display="inline";
					}else if(el.className == "OBJ" && document.getElementById('InfoPanel').style.display=="none"){ //OVerbs
						var IPan = document.getElementById('InfoPanel').firstElementChild;
						var ITin = el.firstElementChild
						IPan.lastElementChild.innerHTML = ITin.lastElementChild.innerHTML;
						IPan.childNodes\[3].innerHTML = ITin.childNodes\[1].innerHTML;
						IPan.childNodes\[5].src = ITin.childNodes\[3].src;
						IPan.childNodes\[7].innerHTML = ITin.childNodes\[5].innerHTML;
						IPan.parentNode.removeAttribute('style');
					}
				}
				function HideClass(Boo,A){
					var B = document.getElementsByClassName(""+Boo)
					C = A == 1 ? "none" : "block";
					var i = B.length;
					while(i--){
						B[i].style.display = C;
					}
				}
				function HideContext(){
					var A = document.getElementsByClassName("PlayerBox");
					//document.getElementById("ChatSet").style.display = "none";
					//document.getElementById("TabSelB").style.display = "none";
					var i = A.length;
					while(i--){
						A[i].style.display = "none";
					}
				}
				function HideThis(el,el2){
					if(el.style.display != "none"){
						el.style.display="none";
						el.style.zIndex="0";
						if(el2){
							if(el2.getAttribute('class') == "StatButO"){
								el2.setAttribute('class',"StatBut");
								//el.parentNode.setAttribute('class',"StCont");
							}
						}
					}else{
						el.style.display="";
						if(el2){
							if(el2.getAttribute('class') == "StatBut"){
								el2.setAttribute('class',"StatButO");
								//el.parentNode.setAttribute('class',"StContO");
							}
						}
					}
				}
				function InfoClose(){
					document.getElementById('InfoPanel').style.display = "none";
				}
				function LoadPage(A,B){
					switch(A){
						case "Chat":
							SwitchPage("ChatBox");
							SetThis(B);
							break;
						case "Game":
							SwitchPage("GameBox");
							SwitchGameTab(B);
							break;
						case "Sett":
							SwitchPage("SetBox");
							SwitchSetTab(B);
							break;
					}
				}
				function ReFocus(){
					window.location = "byond:////winset?id='map1'&focus='true'"
				}
				function SettColor(el){
					el.style.background = "linear-gradient(-90deg, "+el.value+" 30%, #111111 90%)";
					//el.style.backgroundColor = "linear-gradient("+el.value+",#111)";
					el.style.border = "0px";
				}
				function SaveColors(){
					var Cols = document.getElementById("ColoSetts").getElementsByTagName("input")
					alert(Cols.length+" Colors Saved, but not really because clearly");
				}
				function SetCust(){
					var Togs = document.getElementsByClassName("CTogs");
					var t = Togs.length;
					while(t--){
						if(Togs[t].getAttribute('data-Toggled')=="true"){
							HideClass(Togs[t].innerHTML.substring(0, 3),0)
						}else{
							HideClass(Togs[t].innerHTML.substring(0, 3),1)
						}
					}
					document.getElementById("COpts").removeAttribute("style");
					document.getElementById("CustO").style.display = "none";
					TOOC = (document.getElementById("TOOC").getAttribute('data-Toggled') == "true");
					TSay = (document.getElementById("TSay").getAttribute('data-Toggled') == "true");
					TVil = (document.getElementById("TVil").getAttribute('data-Toggled') == "true");
					TGui = (document.getElementById("TGui").getAttribute('data-Toggled') == "true");
					TPri = (document.getElementById("TPri").getAttribute('data-Toggled') == "true");
					TAdm = (document.getElementById("TAdm").getAttribute('data-Toggled') == "true");
					TDam = (document.getElementById("TDam").getAttribute('data-Toggled') == "true");
					TGai = (document.getElementById("TGai").getAttribute('data-Toggled') == "true");
					TMac = (document.getElementById("TMac").getAttribute('data-Toggled') == "true");
					TAnn = (document.getElementById("TAnn").getAttribute('data-Toggled') == "true");
					if(TPri){
						document.getElementById('PrivO').firstElementChild.innerHTML = 0;
						document.getElementById('POpts').firstElementChild.innerHTML = 0;
						document.getElementById('PrivO').firstElementChild.style.display = "none";
						document.getElementById('POpts').firstElementChild.style.display = "none";
					}else{
						HideClass("Pri",1);
					}
					document.getElementById("PrivO").removeAttribute("style");
					document.getElementById("POpts").style.display = "none";
					document.getElementById("PrivSet").style.display = "none";
					document.getElementById("ChatInd").innerHTML = "Cus";
				}
				function SetThis(A){
					if(A=="Cust"){
						SetCust();
						return
					}
					if(A != document.getElementById("ChatInd").innerHTML){
						var Chats = [Chats]; //\["OOC","Say","Vil","Gui","Pri","Adm","Dam","Gai","Mac","Tim","Ann"];
						document.getElementById("COpts").style.display = "none";
						document.getElementById("CustO").removeAttribute("style");
						var t = Chats.length;
						while(t--){
							if(Chats[t] == A ){
								HideClass(A,0);
							}else if(Chats[t] == "Say" && A=="OOC"){
								HideClass(Chats[t],0);
							}else if(Chats[t] == "Mac" && A=="Gam"||Chats[t] == "Gai" && A=="Gam"||Chats[t] == "Dam" && A=="Gam"){
								HideClass(Chats[t],0);
							}else{
								HideClass(Chats[t],1);
							}
						}
						if(A=="Pri"){
							var PChats = document.getElementsByClassName("PTogs")
							var CurPChat = document.getElementById('PrivSet').getAttribute('data-Player');
							var g = PChats.length;
							while(g--){
								if(PChats[g].getAttribute('data-Player') == CurPChat){
									CurPChat = PChats[g];
								}
							}
							SwitchPriv(CurPChat,1);
							document.getElementById("PrivO").style.display = "none";
							document.getElementById("POpts").removeAttribute("style");
						}else if(A!="Pri" && document.getElementById("PrivO").style.display == "none"){
							document.getElementById("PrivO").removeAttribute("style");
							document.getElementById("POpts").style.display = "none";
						}
						document.getElementById("ChatSet").style.display = "none";
						document.getElementById("PrivSet").style.display = "none";

						document.getElementById("ChatInd").innerHTML = A;

						TOOC = false;
						TSay = false;
						TVil = false;
						TGui = false;
						TPri = false;
						TAdm = false;
						TDam = false;
						TGai = false;
						TMac = false;
						TAnn = false;
						switch(A){
							case "OOC":
								TOOC = true;
								TSay = true;
								break;
							case "Say":
								TOOC = true;
								TSay = true;
								break;
							case "Vil":
								TVil = true;
								break;
							case "Gui":
								TGui = true;
								break;
							case "Pri":
								TPri = true;
								break;
							case "Adm":
								TAdm = true;
								break;
							case "Dam":
								TDam = true;
								break;
							case "Gai":
								TGai = true;
								break;
							case "Mac":
								TMac = true;
								break;
							case "TAnn":
								TAnn = true;
								break;
						}
					}
				}
				function SwitchGameTab(A){
					var Tabs = document.getElementsByClassName("GamePage");
					document.getElementById(A).removeAttribute('style');
					var t = Tabs.length;
					while(t--){
						if(Tabs[t].id == A){
							continue
						}else{
							Tabs[t].style.display="none";
						}
					}
				}
				function SwitchPriv(el,Skip){
					if(PCHC){
						PCHC=0;
						return;
					}
					var B = el.getAttribute('data-Player');
					if(B != el.parentNode.getAttribute('data-Player')||Skip){
						el.parentNode.setAttribute('data-Player',B);
						var Whisps = document.getElementsByClassName("Pri");
						var C = parseInt(el.parentNode.firstElementChild.firstElementChild.innerHTML,10)||0;
						var D = parseInt(el.firstElementChild.innerHTML,10)||0;
						var E = (C-D)
						if(B == "All"){
							var i = Whisps.length;
							while(i--){
								Whisps[i].removeAttribute('style');
							}
							document.getElementById('PrivO').firstElementChild.innerHTML = 0;
							document.getElementById('POpts').firstElementChild.innerHTML = 0;
							var Privs = document.getElementsByClassName("PTogs");
							var t = Privs.length;
							while(t--){
								Privs[t].firstElementChild.innerHTML = 0;
							}
						}else{
							el.parentNode.firstElementChild.firstElementChild.innerHTML = E;
							document.getElementById('PrivO').firstElementChild.innerHTML = E;
							document.getElementById('POpts').firstElementChild.innerHTML = E;
							el.firstElementChild.innerHTML=0;
							var i = Whisps.length;
							while(i--){
								if(Whisps[i].firstElementChild.getAttribute('data-Player') != B){
									Whisps[i].style.display="none";
								}else{
									Whisps[i].removeAttribute('style');
								}
							}
						}
						if(!E){
							document.getElementById('PrivO').firstElementChild.style.display = "none";
							document.getElementById('POpts').firstElementChild.style.display = "none";
						}
						el.parentNode.style.display = "none";
					}
				}
				function SwitchPage(A){
					var Pages = document.getElementsByClassName("Page");
					if(A != document.getElementById('PageInd').innerHTML){
						var i = Pages.length;
						while(i--){
							if(Pages[i].id == A){
								Pages[i].removeAttribute('style');
								SwitchTab(i);
							}else{
								Pages[i].style.display = "none";
							}
						}
						document.getElementById('PageInd').innerHTML = A;
					}
				}
				function SwitchSetTab(A){
					var Tabs = document.getElementsByClassName("SettPage");
					document.getElementById(A).removeAttribute('style');
					var t = Tabs.length;
					while(t--){
						if(Tabs[t].id == A){
							continue
						}else{
							Tabs[t].style.display="none";
						}
					}
				}
				function SwitchTab(A){
					var Tabs = document.getElementsByClassName("Header");
					Tabs[A].removeAttribute('style');
					var t = Tabs.length;
					while(t--){
						if(A==t){
							continue
						}else{
							Tabs[t].style.display="none";
						}
					}
					document.getElementById('PrivSet').style.display = "none";
				}
				function ToggleMe(el,A){
					if(el.getAttribute('data-Toggled')=="true"){
						HideClass(A,1);
						el.setAttribute('data-Toggled','false');
						el.setAttribute('class','CTogsO');
					}else{
						HideClass(A,0);
						el.setAttribute('data-Toggled','true');
						el.setAttribute('class','CTogs');
						if(A=="Pri"){
							document.getElementById('PrivO').firstElementChild.innerHTML = 0;
							document.getElementById('POpts').firstElementChild.innerHTML = 0;
							document.getElementById('PrivO').firstElementChild.style.display = "none";
							document.getElementById('POpts').firstElementChild.style.display = "none";

							var Privs = document.getElementsByClassName("PTogs");
							var t = Privs.length;
							while(t--){
								Privs[t].firstElementChild.innerHTML = 0;
							}
						}
					}
					switch(el.id){
						case "TOOC":
							TOOC = !TOOC;
							break;
						case "TSay":
							TSay = !TSay;
							break;
						case "TVil":
							TVil = !TVil;
							break;
						case "TGui":
							TGui = !TGui;
							break;
						case "TPri":
							TPri = !TPri;
							break;
						case "TAdm":
							TAdm = !TAdm;
							break;
						case "TDam":
							TDam = !TDam;
							break;
						case "TGai":
							TGai = !TGai;
							break;
						case "TMac":
							TMac = !TMac;
							break;
						case "TAnn":
							TAnn = !TAnn;
							break;
					}
				}
				function Unhide(Clan){
					var AProf = "[Profession]";
					if(!Clan){
						Clan = "[Clan]";
					}
					if(Clan == "Aburame" || Clan == "All"){
						document.getElementById("PBugCount").style.display = "";
					}
					if(Clan == "Uchiha" || Clan == "All"){
						document.getElementById("PInSharingan").style.display = "";
					}
					if(Clan == "Inuzuka" || Clan == "All"){
						document.getElementById("PetStats").style.display = "";
					}
					if(Clan == "Sand" || AProf == "Sand" || Clan == "All"){
						document.getElementById("PSandCollected").style.display="";
					}

					var ContEL = document.getElementsByClassName("PEStat");
					var EleNum = 0;
					var i = ContEL.length;
					while(i--){
						var Tra = parseInt(ContEL[i].lastElementChild,10);
						if(Tra){
							ContEL[i].style.display = "";
							EleNum++
						}
					}
					if(EleNum){document.getElementById("ElementStats").style.display = "";}
				}
				function UpdateStat(A,B,C,D){
					if (D == null){D  = "";}
					if (A == "Mining Skill"){A = "Mining Skill";}
					if (A == "Crafting Skill"){A = "Crafting Skill";}
					if (A == "Fishing Skill"){A = "Fishing Skill";}
					if (A == "Sword Skill"){A = "Sword";}
					if (A == "Knife Skill"){A = "Knife";}
					if (A == "Chakra Control"){A = "Chakra Control";}
					if (A == "Seal Speed"){A = "Seal Speed";}
					if (A == "First Aid"){A = "First Aid Skill";}
					if (A == "Unarmed Skill"){A = "Unarmed"  }
					if (A == "Shuriken Skill"){A = "Shuriken";}
					if (A == "Senbon Skill"){A = "Senbon";}

					var StatE = document.getElementById(A);
					if (A == "Health" || A == "Stamina" || A == "Chakra" || A=="SandCollected" || A=="InGate" || A=="DgHealth" || A=="DgStamina"){
						StatE.innerHTML = B + " / " + C
					}
					//else if (A=="ZWord" || A=="Name" || A=="Rank" || A=="Yen" || A=="Alias" || A=="Village" || A=="Clan" || A=="Smissions" || A=="Amissions" || A=="Bmissions" || A=="Cmissions" || A=="Dmissions"){StatE.innerHTML = (B)}
					else{
						StatE.innerHTML = (B);
					}
				}
				function ClickObject(el){
					window.location='byond://?src=\ref[src]&action=ClickObject&OClicked='+el.ObjRef;
				}
				function ClearVerbs(){
					var ContEL = document.getElementsByClassName("OVerbs");
					var i = ContEL.length;
					while(i--){
						ContEL[i].style.display = "none";
					}
				}
				function UseVerb(el){
					var elem = el.parentNode.parentNode;
					if(el.innerHTML== "Drop"){
						if(elem.ObjEquipped>0){
							var DropMsg = "You need to unequip it first!";
							return;
						}
					}
					//window.location='byond://?src=\ref[src]&action=UseVerb&VUsed='+el.innerHTML+'&OClicked='+elem.ObjRef;
				}
				function UpdateItems(ObjType,Obj){
					var Blah = document.getElementById(ObjType);
					if(Obj){
						//Blah.innerHTML=null;
						Blah.innerHTML=Obj;
					}
				}
				function UpdatePanel(){
					window.location='byond://?action=UpdateItems';
				}
				function ReplaceString(A,B,C){
					A = A.replace(B,C);
					return A;
				}
				function SaveColors(){
					var Cols = document.getElementsByClassName("ColourInput");
					var WPAN = "[WPAN]";
					var i = Cols.length;
					while(i--){
						var Col = Cols[i].value;
						var ColN = Cols[i].id;
						if(Col.indexOf('#') != -1){
							Col=Col.replace("#","");
						}
						window.location="byond://?src=\ref[src]&action=SaveColor&Colour="+Col+"&ColourName="+ColN+"&WPAN="+WPAN;
					}
				}
				function SaveChat(A,B){
					var Chat = document.getElementById("ChatBox").innerHTML;
					if(A==1){
						window.location="byond://?src=\ref[src]&action=SaveChat&Chat="+Chat;
					}else{
						Chat+=B
					}
				}
				function AddVerb(A,B,C,D){
					window.location = "byond:////winset?id='map1'&focus='true'"
					var VerbTarget = document.getElementById(A);
					var VerbIgnore = \["Admin","Overlays","Exam","Trade","SP","Stat","Restore","Maximize","Minimize","OpenChat","CloseBook","Say","Close","Dye","Barb","To","Create","Set","Dir","Hair","Color"]
					var t = VerbIgnore.len
					while(t--){
						if(B.indexOf(VerbIgnore[t]) > -1){
							return
						}
					}
					VerbTarget.innerHTML+="<button class='Verb"+Tock+"'data-VerbPath='+B+' onclick='ClickVerb(this)'>"+C+"</button>"
					if(Tock == 1){
						Tock = 2;
					}else{
						Tock = 1;
					}
				}
				function AddVerbs(B){
					window.location = "byond://winset?id='map1'&focus='true'"
					document.getElementById("VerbTab").innerHTML = B;
				}
				function ClickVerb(el){
					var url = "byond://winset?command=";
					var command = el.innerHTML
					command.replace(" ","");
					encodeURIComponent(command);
					window.location = "byond://winset?command="+command;
					window.location = "byond://winset?id='map1'&focus='true'"
				}
				function Maximize(){
					window.location = "byond://winset?id='Panel"+[WPAN]+"'&size='319x640'"
					//if(WPan
				}
				function RemoveObj(el){
					document.getElementById(el).parenNode.removeChild(el);
				}
				function ForceITIn(A,B){
					//M << output(list2params(list("Items",HTML)),"Panel1:ForceITIn")
					document.getElementByID(A).innerHTML = B;
				}
			"}
			//window.location = "byond://winset?id=[id]&[property]=[value]&..."
			//window.location = "byond://winget?callback=[function name]&id=[id or list]&property=[id or list]"
			return Java