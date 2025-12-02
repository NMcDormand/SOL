mob/Living/Player
	var
		//list/UIColour = list("Panel1"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#00FF00","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),"Panel2"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#00FF00","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),"Panel3"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#00FF00","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),"Panel4"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#00FF00","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"))
		list/UIColour = list(
		"Panel1"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="#FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#004400","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),
		"Panel2"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="#FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#004400","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),
		"Panel3"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="#FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#004400","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C"),
		"Panel4"=list("BGC"="#707070","TBC"="#D0D0D0","VBC"="#292929","HBC"="#303030","HFC"="#FEFEFE","HLC"="#FF8C00","HOC"="#FF6D00","HEC"="#DD4040","STC"="#40DD40","CHC"="#4040EE","BTC"="#313131","OCOL"="#202020","OPCOL"="#503C3C","SCOL"="#000030","SNCOL"="#000099","PCOL"="#CC33CC","PRNCOL"="#FF00FF","GCOL"="#902010","GNCOL"="#FF0000","VCOL"="#004400","DAC"="#AA0000","GAC"="#2088FF","STAC"="#BB5500","LIC"="#00BB70","LOC"="#FF5050","PNC"="#503C3C")
		)
		list/Panels = list(
		"Panel1" = list("Display"="true","size" = "332x319"),
		"Panel2" = list("Display"="true","size" = "332x319"),
		"Panel3" = list("Display"="true","size" = "332x343"),
		"Panel4" = list("Display"="true","size" = "332x343")
		)
	proc
		StyleGenerate(WPAN=1)
			var
				list/Panel = UIColour["Panel[WPAN]"]
				ScDir = "ltr"
			if(WPAN == 1 || WPAN == 2)
				ScDir = "rtl"

			var/Style = {"
				body {background:#707070;color:[Panel["HLC"]];margin:0px;padding:0px;font-family:calibri;width:100%;max-width:640px;overflow-y:scroll;/*overflow-x:hidden;*/
					direction:[ScDir];

					  scrollbar-base-color: #000;
					  scrollbar-face-color: #555;
					  scrollbar-highlight-color: #000;
					  scrollbar-track-color: #2A2A2A;
					  scrollbar-arrow-color: #444;
					  scrollbar-shadow-color: #2A2A2A;
				}
				div, span, button {direction:ltr;}
				button {cursor:pointer;}
				span:hover,button:hover{color:[Panel["HOC"]];}

				#PageInd, #ChatInd, #PrivInd, #SettInd, #PanelNum {display:none;}
				#Cont1 {position:relative;width:100%;max-width:640px;top:26px;}

				#Tabs {width:100%;max-width:640px;margin:0px;word-wrap:break-word;z-index:6;position:fixed;height:26px;cursor:pointer;}
				#Tabs > div {background:[Panel["HBC"]];}
				#Tabs > div > div {background:transparent;}
				#Tabs > div > div  div{font-size:10px;}
				#Tabs div {font-size:0px}
				#Tabs div span{font-size:9px;}

				#HITab, #SHTab {font-size:11px;position:absolute;right:0px;width:12px;height:13px;padding:0px;line-height:normal;background:transparent;}
				#ShTab {position:fixed;display:none;}

				#TabSel {font-size:11px;position:absolute;right:0px;Top:13px;width:12px;height:13px;padding:0px;line-height:normal;background:transparent;}

				#TabSelB {z-index:8;position:absolute;right:0px;top:26px;width:70px;text-align:right;background:transparent;}
				#TabSelB button {color:inherit;width:70px;outline:0px;padding:5px;margin-top:1px;border-radius:20px;background:rgba(31,31,31,0.8);border:1px dashed;}
				#TabSelB #TPop{border:0px;}
				#TabSelB button:hover {color:[Panel["HOC"]];}

				#ChatTab {position:relative;}
				#ChatSet {z-index:7;position:absolute;right:0px;width:72px;text-align:right;font-size:0px;}

				.CTogs {width:60px;outline:0px;background:rgba(31,31,31,0.8);border-radius:20px;padding:2px;margin-top:1px;border:1px dashed;color:inherit;font-size:10px;}
				.CTogsO {width:60px;outline:0px;background:rgba(31,31,31,0.8);border-radius:20px;padding:2px;margin-top:1px;border:1px dashed;color:#FF0101;font-size:10px;}
				.CTogs:hover,.CTogsO:hover {color:[Panel["HOC"]];}

				#PrivSet {z-index:7;position:absolute;right:50px;top:8;width:78px;text-align:right;}

				.PTogs {position:relative;width:80px;height:16px;outline:0px;border-radius:20px;background:rgba(31,31,31,0.8);font-size:12px;padding:0px;margin-top:1px;border:1px dashed;text-align:center;}
				.PTogs:hover,.CTogsO:hover {color:[Panel["HOC"]];}
				.PNote	{position:absolute;left:3px;top:0px;}
				.PNote1	{position:absolute;left:3px;top:-8px;}
				.PClose	{position:absolute;right:0px;top:-2px;border:0px;border-radius:20px;background:transparent;color:inherit;outline:none;}

				.TButs {position:relative;color:inherit;height:26px;line-height:26px;width:38px;border:0px;outline:none;background:transparent;border-right: 1px solid #444;font-size:10px;text-align: center;font-weight:bold;display:inline-block;}
				.TButs:hover{color:[Panel["HOC"]];}

			/* Chat */
				.PlayerName {
					position:relative;
					color:#3c3c3c;
					font-weight:bold;
					display:inline;
					cursor:pointer;
				}
				.PlayerBox {
					position:absolute;
					z-index:6;
					left:5px;
					display:none;
				}
				.PlayerBox button{
					color:[Panel["HLC"]];
					font-weight:bold;
					display:block;
					width:70px;
					border-radius:20px;
					background:rgba(31,31,31,0.8);
					margin-bottom:1px;
					border:1px dashed;
				}
				.PlayerBox button:hover{
					color:[Panel["HOC"]];
				}
				.Header {
					display:inline;
				}
				#ChatBox{
					font-size:12px;
					font-weight:bold;
					color:#000000;
					background:[Panel["TBC"]];
				}
				.GuildName {
					color:[Panel["GNCOL"]];
					font-weight:bold;
				}
				.MSG {
					display:inline;
				}
				.OOC .PlayerName{
					color:[Panel["OPCOL"]];
				}
				.OOC .MSG {
					color:[Panel["OCOL"]];
				}
				.Say,.Say .PlayerName {
					color:[Panel["SNCOL"]];
				}
				.Say .MSG {
					color:[Panel["SCOL"]];
				}
				.vil,.Vil .PlayerName,.Vil .MSG{
					color:[Panel["VCOL"]];
				}
				.Pri,.Pri .PlayerName {
					color:[Panel["PRNCOL"]];
					font-style:italic;
				}
				.Pri .MSG {
					color:[Panel["PCOL"]]
				}
				.Gui,.Gui .PlayerName {
					color:[Panel["GNCOL"]];
				}
				.Gui .MSG {
					color:[Panel["GCOL"]]
				}
				.Adm,.Adm .PlayerName {
					color:#2020AA;
				}
				.Adm .MSG {
					color:[Panel["GAC"]]
				}
				.Dam {
					color:[Panel["DAC"]];
				}
				.Gai {
					color:[Panel["GAC"]];
				}
				.Ann {
					background:#444;
					color:[Panel["HLC"]];
				}
				.Mac {
					color:[Panel["STAC"]];
				}
				.Mac .Login{
					color:[Panel["LIC"]];
				}
				.Mac .Login .PlayerName{
					color:[Panel["LIC"]];
				}
				.Mac .Logout{
					color:[Panel["LOC"]];
				}
				.Mac .PlayerName{
					color:[Panel["PNC"]];
				}

			/* Game Tab */
				.StCont	{
					background:[Panel["TBC"]];
					color:[Panel["HLC"]];
					overflow:hidden;
					position:relative;
					width:100%;
					max-width:640px;
					text-align:center;
					font-size:10px;
					font-weight:bold;
					margin: 0px auto;
					margin-bottom:4px;
					overflow-y:hidden;
				}
				.StatBut {
					width:100%;
					background:[Panel["HBC"]];
					outline:none;
					font-weight:bold;
					border:0px;
					color:[Panel["HFC"]];
					padding:4px;
					height:20px;
					font-size:10px;
					text-align:left;
					text-indent:10px;
					margin-top:0px;
				}
				.GamePage > .StCont {
					font-size:0px;
				}
				.GamePage > .StCont > div > span{
					font-size:10px;
				}
				.PPStat	{
					display:block;
					position:relative;
					width:100%;
					margin:0px auto;
					padding:4px;
				}
				.PEStat	{
					display:block;
					position:relative;
					width:100%;
					margin:0px auto;
					padding:4px;
				}
				.StName	{
					position:absolute;
					left:0px;
					width:100px;
					text-align:right;
				}
				#Name1, #Alias, #Clan, #Rank, #Village {
					position:relative;
				}
				#BasicInfo .StEntr {
					position:relative;l
					eft:20px;
				}
				.StEntr {
					position:relative;
					left:30px;
					color:[Panel["BTC"]];
				}
				.StDesc	{
					background:rgba(30,30,30,0.8);
					position:absolute;
					top:-16px;left:0px;
					height: 20px;
					padding: 0px 7px;
					display:none;
				}
				#Health {
					Color:[Panel["HEC"]];
				}
				#Stamina {
					Color:#40AA40;
				}
				#Chakra	{
					Color:[Panel["CHC"]];
				}
			/* Item Tab */
				#ItemPage {
					position:relative;
					width:100%;
				}
				.OBJ {
					position:relative;
					display:inline-block;
					zoom:1;
					background:[Panel["HBC"]];
					width:55px;/*13.5%;*/
					min-width:54px;
					height:55px;
					margin:1px;
					padding:0px;
					text-align:center;
					border-radius:4px;
					cursor:pointer;
				}
				.OBJ > div:first-of-type {
					position:relative;
					margin:0px;
					top:-3px;
				}
				.OInfo {
					display:none;
				}
				.OBJ div .Image {
					position:absolute;
					left:11px;
					border-radius:4px;
					background:rgba(31,31,31,0.9);
				}
				.OName {
					position:relative;
					top:4px;
					font-size:7pt;
					width:93%;
					font-weight:Bold;
					overflow:hidden;
					white-space:nowrap;
					display:block;
					margin:0px auto;
					margin-bottom:2px;
				}
				.OVerbs {display:none;}

			/* Info Pane; */
				#InfoPanel	{
					position:absolute;
					top:10px;
					left:50%;
					width:80%;
					z-index:5;
					text-align:center;
				}
				#InfoPanel > div:first-of-type {
					background:rgba(31,31,31,0.9);
					border-radius:10px;
					padding:6px 0px;
					position:relative;
					left:-50%;
					margin:0px;
				}
				#InfoPanel > div  div{font-size:0px;}
				#InfoPanel > div:first-of-type, #InfoPanel > div:first-of-type span, .Verb1, .Verb2 {
					font-size:10px;
				}
				#ObName{
					display:inline-block;
					position:relative;
					top:-2px;
					border-bottom-right-radius:8px;
					border-bottom-left-radius:8px;
					padding:0px 8px;
					text-align:center;
					border-bottom:1px dashed;
					max-width:90px;
				}
				#InfoClose {
					position:absolute;
					top:0px;
					right:0px;
					height:18px;
					width: 15px;
					padding:0px;
					border:0px;
					border-bottom:1px dashed;
					background:transparent;
					color:inherit;
					border-top-right-radius:10px;
					border-bottom-left-radius:10px;
					outline:none;
					font-size:11px;
				}
				.Image {
					position:relative;
					display:block;
					width: 58%;
					min-width:32px;
					min-height:32px;
					background:rgba(60,60,60,0.5);
					margin: 4px auto;
					border-radius:10px;
				}
				#Info{
					text-align:center;
					margin:4px;
				}
				#ObInfo span{display:block;}
				#ObjVerbs{
					width:90%;
					text-align:right;
					padding:4px 0px;
					margin:0px auto;
				}
		/* Verbs */
				#VerbTab, #AdminTab{
					background:[Panel["VBC"]];
				}
				.Verb1 {
					outline:none;
					display:inline-block;
					position:relative;
					color:inherit;
					padding:2px 0px;
					border:0px;
					width:50%;
					max-width:160px;
					background:transparent;
					border-top-right-radius:10px;
					border-bottom-right-radius:10px;
					border-bottom:1px dashed;
					margin-top:1px;
				}
				.Verb2 {
					outline:none;
					display:inline-block;
					position:relative;
					color:inherit;
					padding:2px 0px;
					border:0px;
					width:50%;
					max-width:160px;
					background:transparent;
					border-top-left-radius:10px;
					border-bottom-left-radius:10px;
					border-top:1px dashed;
					margin-top:1px;
				}
				#VerbPage .Verb1{width:25%;border-bottom-left-radius:10px;}
				#VerbPage .Verb2{width:25%;border-top-right-radius:10px;}
				#AdminPage .Verb1 {border-bottom-left-radius:10px;}
				#AdminPage .Verb2 {border-top-right-radius:10px;}

				.Verb1:hover, .Verb1:hover{background: linear-gradient(rgba(80,80,80,0) 30%, rgba(80,80,80,1) 100%);}
				.Verb2:hover, .Verb2:hover{background: linear-gradient(-360deg, rgba(80,80,80,0) 30%, rgba(80,80,80,1) 100%);}
		/* Guild */
				#GuildPage{
					position:relative;
					text-align:center;
					width:100%;
					background:#2A2A2A;
					max-width:
				}
				#GuName{
					display:inline-block;
					position:relative;
					top:-2px;
					border-bottom-right-radius:8px;
					border-bottom-left-radius:8px;
					padding:0px 8px;
					border-bottom:1px dashed;
					max-width:320px;
				}
				#GuImg{max-width:260px;}
				#GuInfo{
					text-align:center;
					margin:4px;
				}
				#GuInfo span{display:block;}
				#GuVerbs{
					text-align:center;
					padding:4px 0px;
					font-size:0px;
				}
				#GuildPage .Verb1 {max-width:140px; border-bottom-left-radius:10px;}
				#GuildPage .Verb2 {max-width:140px; border-top-right-radius:10px;}
		/* Settings */
				.SettPage{
					width:100%;
					background:#111111;
					font-size:0px;
					padding:0px;
				}
				.SettPage span{
					font-size:11px;
					width: 35%;
					display:inline-block;
					text-align:right;
					margin:0px;
					padding:0px;
				}
				.SettPage label{
					font-size:11px;
					display:inline-block;
					text-align:center;
					margin:0px;
					padding:0px;
					width: 60px;
				}
				.SettPage input\[type=text]{
					width:65%;
					margin:2px 0px;
					padding:4px 0px;
					border:0px;
					text-indent:10px;
					color:inherit;
					font-size:11px;
				}
				.SaveSetButton{
					background:#111111;
					color:inherit;
					border:0px;
					border-bottom:1px dashed;
					border-bottom-left-radius:10px;
					border-bottom-right-radius:10px;
					position:fixed;
					right:0px;
					top:26px;
				}
				#HowToButton{
					background:#111111;
					color:inherit;
					border:0px;
					border-bottom:1px dashed;
					border-bottom-left-radius:10px;
					border-bottom-right-radius:10px;
					position:absolute;
					right:60px;
					top:0px;
				}
				p {
					margin-bottom:0px;
				}
			"}
			return Style