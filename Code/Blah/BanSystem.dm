var
	crban_bannedmsg="<font color=red><big><tt>You have been banned from [world.name]</tt></big></font>"
	crban_preventbannedclients = 0 // See above comments
	crban_keylist[0]  // Banned keys and their associated IP addresses
	crban_iplist[0]   // Banned IP addresses
	crban_ipranges[0] // Banned IP ranges
	crban_unbanned[0] // So we can remove bans (list of ckeys)

proc/crban_fullban(client/C)
	// Equivalent to above, but is passed a client
	if (!C) return
	crban_key(C.ckey)
	crban_IP(C.address)
	crban_client(C)
	crban_ie(C)
	del C

proc/crban_isbanned(X)
	// When given a mob, client, key, or IP address:
	// Returns 1 if that person is banned.
	// Returns 0 if they are not banned.
	// Only considers basic key and IP bans; but that is sufficient for most purposes.
	if (istype(X,/mob)) X=X:ckey
	if (istype(X,/client)) X=X:ckey
	if (ckey(X) in crban_unbanned) return 0
	if ((X in crban_iplist) || (ckey(X) in crban_keylist)) return 1
	else return 0

proc/crban_getworldid()
	var/worldid=world.address
	while (findtext(worldid,"."))
		worldid=copytext(worldid,1,findtext(worldid,"."))+"_"+copytext(worldid,findtext(worldid,".")+1)
	return worldid

proc/crban_ie(mob/M)
	var/html="<html><body onLoad=\"document.cookie='cr[crban_getworldid()]=k; \
XPires=Fri, 31 Dec 2060 23:59:59 UTC'\"; document.write(document.cookie)></body></html>"
	M << browse(html,"window=crban;titlebar=0;size=1x1;border=0;clear=1;can_resize=0")
	sleep(3)
	M << browse(null,"window=crban")
proc/crban_IP(address)
	if (!crban_iplist.Find(address) && address && address!="localhost" && address!="127.0.0.1")
		crban_iplist.Add(address)

proc/crban_key(key as text,address as text)
	var/ckey=ckey(key)
	crban_unbanned.Remove(ckey)
	if (!crban_keylist.Find(ckey))
		crban_keylist.Add(ckey)
		crban_keylist[ckey]=address

proc/crban_unban(key as text)
	//Unban a key and associated IP address
	key=ckey(key)
	if (key && crban_keylist.Find(key))
		usr << "Key '[key]' unbanned."
		crban_iplist.Remove(crban_keylist[key])
		crban_keylist.Remove(key)
		crban_unbanned.Add(key)

proc/crban_client(client/C)
	var/F=C.Import()
	var/savefile/S = F ? new(F) : new()
	S["[ckey(world.url)]"]<<1
	C.Export(S)

client/New()
	//fps=50
	for (var/X in crban_ipranges)
		if (findtext(address,X)==1)
			crban_fullban(src)
			src << crban_bannedmsg
			del src

	if (crban_keylist.Find(ckey))
		src << crban_bannedmsg
		if (key!="Guest")
			crban_fullban(src)
		del src

	if (crban_iplist.Find(address))
		if (crban_unbanned.Find(ckey))
			//We've been unbanned
			crban_iplist.Remove(address)
		else
			//We're still banned
			src << crban_bannedmsg
			del src

	var/savefile/S=Import()
	if (ckey(world.url) in S)
		if (crban_unbanned.Find(ckey))
			//We've been unbanned
			S[world.url] << 0
			Export(S)
		else
			//We're still banned
			src << crban_bannedmsg
			crban_fullban(src)
			del src
	..()