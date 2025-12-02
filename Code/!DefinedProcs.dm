#define RESTRAINEDCHECK(M) M.SnakeBound||M.KO||M.ReverseFlow||M.Webbed||M.IceBlasted||M.fallen||M.ShadowCaptured||M.Sleeping||M.JubakuBound||M.TooMuchWeight||M.waterprisoned||M.Coffin||M.InKageArashi
#define RESTRAINEDLEGS(M) M.Gokusamaisou
#define MoveCheck(U) (U.client&&!U.loggedin)||U.DorouDoumu||U.Kanashibari||U.SunaNoMayu||U.Gokusamaisou||U.Stamina<=0||U.dead||U.fishing||U.TakingExam||U.mirroring||U.EventLock||U.DeathSee||U.Webbed||U.Lotus||U.IceBlasted||U.KO||U.MushiKabe||U.fallen||U.ShadowCaptured||U.Underground||U.climbing||U.Sleeping||U.JubakuBound||U.frozen||U.Playing||U.TooMuchWeight||U.meditating||U.GMfrozen||U.resting||U.moving||U.waterprisoned||U.Coffin||U.kaiten||U.CantWalk||U.ShadowList.len||U.AcquiringList.len

#define GENERICATTACKCHECK(M) M.SnakeBound||M.InIzanami||M.InKamui||M.ReverseFlow||M.ShadowCaptured||M.RaitonCurrent||M.ShibariHit||M.InFakeView||M.InSPS||M.BlockedTenketsu||M.Drugged||M.Dispelling||M.AFK||M.JubakuBound||M.Kanashibari||M.InNarakumi||M.dead||M.MushiKabe||M.mirroring||M.UsingWaterPrison||M.InMesu||M.InCloak||M.Coffin||M.DeathSee||M.EventLock||M.Webbed||M.fishing||M.healingself||M.firing||M.KO||M.Blocking||M.throwing||M.Sleeping||M.protect||M.waterprisoned||M.IceBlasted||M.resting||M.jailed||M.frozen||M.GMfrozen||M.InTsukuyomi||M.Tsukuyomi||M.swimming||M.kaiten||M.climbing||M.InSoutourou||M.InKageArashi
#define AIGENERICCHECK(M) M.SnakeBound||M.InIzanami||M.InKamui||M.ReverseFlow||M.MushiKabe||M.Coffin||M.dead||M.InCloak||M.fishing||M.Kanashibari||M.InNarakumi||M.Webbed||M.healingself||M.ShadowCaptured||M.firing||M.KO||M.IceBlasted||M.Blocking||M.throwing||M.Sleeping||M.JubakuBound||M.protect||M.waterprisoned||M.resting||M.ShadowCaptured||M.jailed||M.frozen||M.GMfrozen||M.Tsukuyomi||M.swimming||M.kaiten||M.climbing||M.InSoutourou

#define SHUNCHECK(M) M.SnakeBound||M.CantWalk||M.InIzanami||M.onmountain||M.InMirrors||M.InMist||M.InSwamp||M.ShadowCaptured||M.RaitonCurrent||M.ShibariHit||M.InFakeView||M.InSPS||M.BlockedTenketsu||M.Drugged||M.AFK||M.JubakuBound||M.Kanashibari||M.InNarakumi||M.dead||M.MushiKabe||M.mirroring||M.UsingWaterPrison||M.InCloak||M.Coffin||M.DeathSee||M.EventLock||M.Webbed||M.fishing||M.healingself||M.firing||M.KO||M.Sleeping||M.waterprisoned||M.IceBlasted||M.resting||M.jailed||M.frozen||M.GMfrozen||M.Tsukuyomi||M.swimming||M.kaiten||M.climbing||M.InSoutourou||M.InKageArashi


#define TAIATTACKCHECKSELF(M) (M.InIzanami||M.InKamui||M.ReverseFlow||M.firing||M.Sleeping||M.InKageArashi||M.Kanashibari||M.MushiKabe||M.InNarakumi||M.DeathSee||M.dead||M.mirroring||M.EventLock||M.Webbed||M.frozen||M.Blocking||M.KO||M.reset||M.throwing||M.GMfrozen||M.Tsukuyomi||M.jailed||M.attacking||M.swimming||M.resting||M.ShadowCaptured||M.kaiten||M.IceBlasted||M.waterprisoned||M.Coffin)
#define TAIATTACKCHECKYOU(M) M&&(M.protect||M.InIzanami||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga||M.GMfrozen)
#define TAICHECKBOTH(U,M) TAIATTACKCHECKSELF(U) || TAIATTACKCHECKYOU(M)

#define DISPELCHECK(U) U.BlockedTenketsu||U.Drugged||U.Dispelling||U.AFK||U.dead||U.MushiKabe||U.UsingWaterPrison||U.InCloak||U.DeathSee||U.EventLock||U.Webbed||U.fishing||U.healingself||U.ShadowCaptured||U.KO||U.Blocking||U.throwing||U.Sleeping||U.protect||U.resting||U.ShadowCaptured||U.jailed||U.frozen||U.GMfrozen||U.Tsukuyomi||U.swimming||U.kaiten||U.climbing

#define InvisibilityCheck(U,M) U.see_invisible<=M.invisibility

#define CMDATKCHK(U) U.DeathSee||U.jailed||U.dead||U.GMfrozen||U.EventLock||U.InSoutourou

#define GAROUGAATkCHK(U) U.InKamui||U.DeathSee||U.Coffin||U.dead||U.Webbed||U.EventLock||U.InNarakumi||U.fishing||U.healingself||U.ShadowCaptured||U.firing||U.KO||U.Blocking||U.throwing||U.Sleeping||U.JubakuBound||U.protect||U.waterprisoned||U.IceBlasted||U.resting||U.ShadowCaptured||U.jailed||U.frozen||U.GMfrozen||U.Tsukuyomi||U.swimming||U.climbing

#define IDCHECK(A,B)  B.PlayerID && A.PlayerID == B.PlayerID || B.TeamID && A.TeamID == B.TeamID || B.TempID && A.TempID == B.TempID
//B.GuildID && A.GuildID == B.GuildID ||
#define FRIENDCHECK(A,B) B.TeamID && A.TeamID == B.TeamID || B.GuildID && A.GuildID == B.GuildID
#define TEAMCHECK(A,B) B.TeamID && A.TeamID == B.TeamID

#define IDCOPY(A,B) A.PlayerID = B.PlayerID; A.TeamID = B.TeamID; A.GuildID = B.GuildID; A.TempID = B.TempID;
#define IDRESET(A) A.PlayerID = null; A.TeamID = null; A.GuildID = null; A.TempID = null;
#define IDSET(A,B) A.PlayerID = B; A.TeamID = B; A.GuildID = B; A.TempID = B;

#define AutoFishingAttackCheck(U) U.Drugged||U.Dispelling||U.JubakuBound||U.InNarakumi||U.dead||U.MushiKabe||U.mirroring||U.UsingWaterPrison||U.InMesu||U.InCloak||U.Coffin||U.DeathSee||U.EventLock||U.Webbed||U.healingself||U.KO||U.Blocking||U.throwing||U.Sleeping||U.protect||U.waterprisoned||U.IceBlasted||U.ShadowCaptured||U.jailed||U.frozen||U.GMfrozen||U.Tsukuyomi||U.swimming||U.kaiten||U.climbing||U.InSoutourou

#define ISLIVINGMOB(A) !istype(A,/mob/Hittable/Unresponsive/Training) && !istype(A,/mob/Hittable/Unresponsive/Inanimate) && !istype(A,/mob/Hittable/Command/Clones) && !istype(A,/mob/Hittable/Command/EdoClone) && !istype(A,/mob/Hittable/Command/Genjutsu)&& !istype(A,/mob/Hittable/Responsive/Animal) && (istype(A,/mob/player)||istype(A,/mob/Hittable)))


#define NINIGNORELIST(A) istype(A,/mob/Hittable/Unresponsive/NPC)||istype(A,/mob/Hittable/Unresponsive/Training)||istype(A,/mob/Hittable/Command/Genjutsu)

