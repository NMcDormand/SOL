/*mob/var/tmp/MoveList

mob/player/verb
	ViewUses()
		set name="View Move Uses"
		set desc="See how often you've used your techniques"
		MoveList=null; CheckMoveUses()
		src<<browse(null,"window=info"); src<<browse({"
<STYLE>BODY {background: black; color: white; font-family: Verdana; font-size: 10px}</STYLE>
<head><title>[Clan], [name]</title></head>
<body>
<table width="320" style="font-size: 10px; font-family: Verdana>
  <tr>
    <td width="58%"> </td>
    <td width="42%"> </td>
  </tr>
[MoveList]
</table>
</body>"},"window=info;can_resize=0;size=350x400")
mob/proc/CheckMoveUses()*/
//	if(HengeUses>0) MoveList+={"<tr><td width="58%"><b>Henge no Jutsu</b>:</td><td width="42%">[HengeUses]</td></tr>"}
//	if(KawarimiUses>0) MoveList+={"<tr><td width="58%"><b>Kawarimi no Jutsu</b>:</td><td width="42%">[KawarimiUses]</td></tr>"}
//	if(ShunshinUses>0) MoveList+={"<tr><td width="58%"><b>Shunshin no Jutsu</b>:</td><td width="42%">[ShunshinUses]</td></tr>"}
//	if(KageShurikenUses>0) MoveList+={"<tr><td width="58%"><b>Kage Shuriken no Jutsu</b>:</td><td width="42%">[KageShurikenUses]</td></tr>"}
//	if(RasenganUses>0) MoveList+={"<tr><td width="100%" colspan="2"></td></tr><tr><td width="58%"><b>Rasengan</b>:</td><td width="42%">[RasenganUses]</td></tr>"}
//
//	if(MeiMeiUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Mei Mei no Jutsu</b>:</td><td width="42%">[MeiMeiUses]</td></tr>"}
//	if(NehanShoujaUses>0) MoveList+={"<tr><td width="58%"><b>Nehan Shouja no Jutsu</b>:</td><td width="42%">[NehanShoujaUses]</td></tr>"}
//	if(KokuangyouUses>0) MoveList+={"<tr><td width="58%"><b>Kokuangyou no Jutsu</b>:</td><td width="42%">[KokuangyouUses]</td></tr>"}
//	if(JubakuSatsuUses>0) MoveList+={"<tr><td width="58%"><b>Jubaku Satsu</b>:</td><td width="42%">[JubakuSatsuUses]</td></tr>"}
//
//	if(BunshinUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Bunshin no Jutsu</b>:</td><td width="42%">[BunshinUses]</td></tr>"}
//	if(KageBunshinUses>0) MoveList+={"<tr><td width="58%"><b>Kage Bunshin no Jutsu</b>:</td><td width="42%">[KageBunshinUses]</td></tr>"}
//	if(MizuBunshinUses>0) MoveList+={"<tr><td width="58%"><b>Mizu Bunshin no Jutsu</b>:</td><td width="42%">[MizuBunshinUses]</td></tr>"}
//	if(SunaBunshinUses>0) MoveList+={"<tr><td width="58%"><b>Suna Bunshin no Jutsu</b>:</td><td width="42%">[SunaBunshinUses]</td></tr>"}
//	if(MushiBunshinUses>0) MoveList+={"<tr><td width="58%"><b>Mushi Bunshin no Jutsu</b>:</td><td width="42%">[MushiBunshinUses]</td></tr>"}
//	if(DaibakuhaUses>0) MoveList+={"<tr><td width="58%"><b>Bunshin Daibakuha</b>:</td><td width="42%">[DaibakuhaUses]</td></tr>"}
//
//	if(DaibakufuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Suiton: Daibakufu</b>:</td><td width="42%">[DaibakufuUses]</td></tr>"}
//	if(SuiryuudanUses>0) MoveList+={"<tr><td width="58%"><b>Suiton: Suiryuudan</b>:</td><td width="42%">[SuiryuudanUses]</td></tr>"}
//	if(SuikoudanUses>0) MoveList+={"<tr><td width="58%"><b>Suiton: Suikoudan</b>:</td><td width="42%">[SuikoudanUses]</td></tr>"}
//	if(SuirouUses>0) MoveList+={"<tr><td width="58%"><b>Suirou no Jutsu</b>:</td><td width="42%">[SuirouUses]</td></tr>"}
//	if(KirigakureUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"></td></tr><tr><td width="58%"><b>Kirigakure no Jutsu</b>:</td><td width="42%">[KirigakureUses]</td></tr>"}
//
//	if(GoukakyuuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Katon: Goukakyuu</b>:</td><td width="42%">[GoukakyuuUses]</td></tr>"}
//	if(HousenkaUses>0) MoveList+={"<tr><td width="58%"><b>Katon: Housenka</b>:</td><td width="42%">[HousenkaUses]</td></tr>"}
//	if(KaryuuEndanUses>0) MoveList+={"<tr><td width="58%"><b>Katon: Karyuu Endan</b>:</td><td width="42%">[KaryuuEndanUses]</td></tr>"}
//	if(RyuukaUses>0) MoveList+={"<tr><td width="58%"><b>Katon: Ryuuka</b>:</td><td width="42%">[RyuukaUses]</td></tr>"}
//
//	if(DaitoppaUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Fuuton: Daitoppa</b>:</td><td width="42%">[DaitoppaUses]</td></tr>"}
//	if(MugenSajinUses>0) MoveList+={"<tr><td width="58%"><b>Fuuton: Mugen Sajin Daitoppa</b>:</td><td width="42%">[MugenSajinUses]</td></tr>"}
//	if(RenkoudanUses>0) MoveList+={"<tr><td width="58%"><b>Fuuton: Renkoudan</b>:</td><td width="42%">[RenkoudanUses]</td></tr>"}
//	if(KyoumeisenUses>0) MoveList+={"<tr><td width="100%" colspan="2"></td></tr><tr><td width="58%"><b>Kyoumeisen</b>:</td><td width="42%">[KyoumeisenUses]</td></tr>"}
//	if(ZankouhaUses>0) MoveList+={"<tr><td width="58%"><b>Zankouha</b>:</td><td width="42%">[ZankouhaUses]</td></tr>"}
//	if(ZankoukyokuhaUses>0) MoveList+={"<tr><td width="58%"><b>Zankoukyokuha</b>:</td><td width="42%">[ZankoukyokuhaUses]</td></tr>"}
//
//	if(RaikyuuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Raiton: Raikyuu</b>:</td><td width="42%">[RaikyuuUses]</td></tr>"}
//	if(RairyuunoTatsumakiUses>0) MoveList+={"<tr><td width="58%"><b>Raiton: Rairyuu no Tatsumaki</b>:</td><td width="42%">[RairyuunoTatsumakiUses]</td></tr>"}
//	if(ChidoriUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"></td></tr><tr><td width="58%"><b>Chidori</b>:</td><td width="42%">[ChidoriUses]</td></tr>"}

//	if(ShinjuuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Doton: Shinjuu Zanshu</b>:</td><td width="42%">[ShinjuuUses]</td></tr>"}
//	if(DoryuuDangoUses>0) MoveList+={"<tr><td width="58%"><b>Doton: Doryuu Dango</b>:</td><td width="42%">[DoryuuDangoUses]</td></tr>"}
//	if(DoryuuHekiUses>0) MoveList+={"<tr><td width="58%"><b>Doton: Doryuu Heki</b>:</td><td width="42%">[DoryuuHekiUses]</td></tr>"}
//	if(DoryuudanUses>0) MoveList+={"<tr><td width="58%"><b>Doton: Doryuudan</b>:</td><td width="42%">[DoryuudanUses]</td></tr>"}

//	if(KagemaneUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Kagemane no Jutsu</b>:</td><td width="42%">[KagemaneUses]</td></tr>"}
//	if(KageKubiShibariUses>0) MoveList+={"<tr><td width="58%"><b>Kage Kubi Shibari no Jutsu</b>:</td><td width="42%">[KageKubiShibariUses]</td></tr>"}

//	if(SensatsuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Sensatsu Suishou</b>:</td><td width="42%">[SensatsuUses]</td></tr>"}
//	if(IceBlastUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Hyouton: Ice Blast</b>:</td><td width="42%">[IceBlastUses]</td></tr>"}
//	if(DemonMirrorUses>0) MoveList+={"<tr><td width="58%"><b>Makyou Hyoushou</b>:</td><td width="42%">[DemonMirrorUses]</td></tr>"}

//	if(TeshiSendanUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Teshi Sendan</b>:</td><td width="42%">[TeshiSendanUses]</td></tr>"}
//	if(YanagiUses>0) MoveList+={"<tr><td width="58%"><b>Yanagi no Mai</b>:</td><td width="42%">[YanagiUses]</td></tr>"}
//	if(TsubakiUses>0) MoveList+={"<tr><td width="58%"><b>Tsubaki no Mai</b>:</td><td width="42%">[TsubakiUses]</td></tr>"}
//	if(KaramatsuUses>0) MoveList+={"<tr><td width="58%"><b>Karamatsu no Mai</b>:</td><td width="42%">[KaramatsuUses]</td></tr>"}
//	if(TessenkaUses>0) MoveList+={"<tr><td width="58%"><b>Tessenka no Mai</b>:</td><td width="42%">[TessenkaUses]</td></tr>"}
//	if(SawarabiUses>0) MoveList+={"<tr><td width="58%"><b>Sawarabi no Mai</b>:</td><td width="42%">[SawarabiUses]</td></tr>"}

//	if(JyukenUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Jyuken</b>:</td><td width="42%">[JyukenUses]</td></tr>"}
//	if(KaitenUses>0) MoveList+={"<tr><td width="58%"><b>Hakkeshou Kaiten</b>:</td><td width="42%">[KaitenUses]</td></tr>"}
//	if(KyushouUses>0) MoveList+={"<tr><td width="58%"><b>Hakke Kyushou</b>:</td><td width="42%">[KyushouUses]</td></tr>"}
//	if(IPalmUses>0) MoveList+={"<tr><td width="58%"><b></b>Hakke Rokujyuyon Shou:</td><td width="42%">[IPalmUses]</td></tr>"}
//	if(IIPalmUses>0) MoveList+={"<tr><td width="58%"><b></b>Hakke HyakuNiJyuYon Shou:</td><td width="42%">[IIPalmUses]</td></tr>"}

//	if(TsuugaUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Tsuuga</b>:</td><td width="42%">[TsuugaUses]</td></tr>"}
//	if(GatsuugaUses>0) MoveList+={"<tr><td width="58%"><b>gatsuuga</b>:</td><td width="42%">[GatsuugaUses]</td></tr>"}
//	if(JuujinUses>0) MoveList+={"<tr><td width="58%"><b>Juujin Bunshin no Jutsu</b>:</td><td width="42%">[JuujinUses]</td></tr>"}
//	if(SoutourouUses>0) MoveList+={"<tr><td width="58%"><b>Soutourou</b>:</td><td width="42%">[SoutourouUses]</td></tr>"}
//	if(GarougaUses>0) MoveList+={"<tr><td width="58%"><b>Garouga</b>:</td><td width="42%">[GarougaUses]</td></tr>"}

//	if(AmaterasuUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Amaterasu</b>:</td><td width="42%">[AmaterasuUses]</td></tr>"}
//	if(TsukuyomiUses>0) MoveList+={"<tr><td width="58%"><b>Tsukuyomi</b>:</td><td width="42%">[TsukuyomiUses]</td></tr>"}

//	if(MushiYoseUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Mushi Yose no Jutsu</b>:</td><td width="42%">[MushiYoseUses]</td></tr>"}
//	if(PlaceBugUses>0) MoveList+={"<tr><td width="58%"><b>Bugs placed</b>:</td><td width="42%">[PlaceBugUses]</td></tr>"}
//	if(ExplodeKonchuuUses>0) MoveList+={"<tr><td width="58%"><b>Bugs XPloded</b>:</td><td width="42%">[ExplodeKonchuuUses]</td></tr>"}
//	if(MushiBunshinUses>0) MoveList+={"<tr><td width="58%"><b>Mushi Bunshin no Jutsu</b>:</td><td width="42%">[MushiBunshinUses]</td></tr>"}
//	if(MushiBunshinDaibakuhaUses>0) MoveList+={"<tr><td width="58%"><b>Mushi Bunshin Daibakuha</b>:</td><td width="42%">[MushiBunshinDaibakuhaUses]</td></tr>"}
//	if(BugArmourUses>0) MoveList+={"<tr><td width="58%"><b>Mushi no Yoroi</b>:</td><td width="42%">[BugArmourUses]</td></tr>"}
//	if(MushiKabeUses>0) MoveList+={"<tr><td width="58%"><b>Mushi Kabe</b>:</td><td width="42%">[MushiKabeUses]</td></tr>"}

//	if(CloakUses>0) MoveList+={"<tr><td width="100%" colspan="2" align="left"><hr align="left" width="160" size="1"></td></tr><tr><td width="58%"><b>Kakuremino</b>:</td><td width="42%">[CloakUses]</td></tr>"}
//	if(CamoUses>0) MoveList+={"<tr><td width="58%"><b>Meisaigakure</b>:</td><td width="42%">[CamoUses]</td></tr>"}