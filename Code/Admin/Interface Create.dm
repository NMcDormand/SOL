mob/VerbHolder/Admin/Level4/
	Create
		verb
			Create_Copy(atom/A in world)//Creates a carbon copy of what ever in the world you choose
				set category="Admin"
				CreateVar=list()
				var/T="[A.type]"
				for(var/I=1 to 99999999)
					var/a=findtext(T,"/",2)
					if(a)
						CreateVar+="[copytext(T,1,a)]"
						T=copytext(T,a,0)
					else
						CreateVar+=T
						if(I>1)
							winset(src,"CreatePage.BackBut","is-visible=true")
						break
				Creating=GetCreating()
				UpdateCreate(Creating)
				Reference=A
				src<<output(RefMat,"CreatePage.IconOut:1,1")

			CreateOverlay()//Verb to set your creations as overlay, useful for stacking multiple turfs on top of each other
				set hidden=1
				if(CreateOverlay)
					CreateOverlay=0
					winset(src,"CreatePage.button5","background-color=#B4B4B4")
				else
					CreateOverlay=1
					winset(src,"CreatePage.button5","background-color=#F0F0F0")

			CreateDelete()// Toggles Delete
				set hidden=1
				if(CreateDelete)
					CreateDelete=0
					winset(src,"CreatePage.button6","background-color=#B4B4B4")
				else
					CreateDelete=1
					winset(src,"CreatePage.button6","background-color=#F0F0F0")

			CreateSearch(T as text)//Search through atom types
				set hidden=1
				CreateSearchProc(T)

			CreateChangeIcon()//Change the icon of the type you are creating
				set hidden=1
				RefMat.icon=input("Choose a new icon:","Icon",RefMat.icon) as icon
				winset(src,"CreatePage.IconOut","cells=0x0")
				src<<output(RefMat.icon,"CreatePage.IconOut:1,1")

			CreateChangeState()//Change the icon state
				set hidden=1
				CreateVar+="States"
				winset(src,"CreatePage.AtomGrid","cells=0x0")
				var/L=icon_states(RefMat.icon)
				var/c=0
				var/r=1
				for(var/X in L)
					var/obj/A=new/obj
					A.icon=RefMat.icon
					A.icon_state=X
					src<<output("<a style=\"text-decoration:none;\" href=\"?src=\ref[src];action=Create;vari=[X]\">[X]</a>","CreatePage.AtomGrid:[++c],[r]")

					if(c==10)
						c=0
						r++

			CreateBack()//Verb to go back in the list of types
				set hidden=1
				winset(src,"CreatePage.Search","text=")
				CreateVar.len--
				Creating=null
				Reference=null
				var/A
				if(CreateVar.len==0)
					A="/atom"
				else
					Creating=GetCreating()
					A=Creating
				UpdateCreate(A)
				if(CreateVar.len==0)
					winset(src,"CreatePage.BackBut","is-visible=false")
				sleep()

			ToggleCreate(N as num)//Changes create type from Add to Fill
				set hidden=1
				CreateAdd=N
				if(N==1)
					winset(src,"CreatePage.button2","background-color=#B4B4B4")
					winset(src,"CreatePage.button1","background-color=#F0F0F0")
					CreateFirst=null
					for(var/image/I in client.images)
						if(I.name=="CreateHighlight")
							client.images-=I
							break
				if(N==2)
					winset(src,"CreatePage.button1","background-color=#B4B4B4")
					winset(src,"CreatePage.button2","background-color=#F0F0F0")
mob
	proc
		CloseCreateProc()//Proc to close create
			Creating=null
			InCreate=0
			Reference=null
			CreateAdd=0
			CreateVar=list()
			RefMat=null
			CreateFirst=null
			src<<output(null,"CreatePage.SelectedOut")
			winset(src,null,"CreatePage.button6.background-color=#B4B4B4;CreatePage.button5.background-color=#B4B4B4;CreatePage.button1.background-color=#B4B4B4;CreatePage.button2.background-color=#B4B4B4;CreatePage.SelectedOut.background-color=#B4B4B4")
			winset(src,"CreatePage.AtomGrid","cells=0x0")
			winset(src,"CreatePage.BackBut","is-visible=false")
			UpdateCreateVerbs(0)

		CreateSearchProc(T as text)//Proc to perform searches
			var/A=Creating
			if(!Creating)
				A="/atom"
				winset(src,"CreatePage.BackBut","is-visible=true")
			UpdateCreate(A,T)
			CreateVar+="Search"

		AutoSearchCreate()//"Live Search" proc to check through types
			set background=1
			var/T=""
			for(var/I=0 to 999999)
				if(!InCreate)
					break
				var/t=winget(src,"CreatePage.Search","text")
				if(T!=t)
					T=t
					if(T!="")
						if(CreateVar.len>0)
							if(CreateVar[CreateVar.len]=="Search")
								CreateVar.len--
						CreateSearchProc(T)
				sleep(2)

		CreateDeleteAtom(atom/type,X,Y,Z)//Deletes the currently chosen atom as long as type, icon, and state match up
			if(CreateOverlay)
				var/icon/A=new(RefMat.icon,RefMat.icon_state)
				for(var/turf/B in block(locate(X,Y,Z),locate(X,Y,Z)))
					B.overlays-=A
			else
				var/Pass=0
				for(var/atom/A in locate(X,Y,Z))
					if(A.type==type&&A.icon==RefMat.icon&&A.icon_state==RefMat.icon_state)
						del A
						Pass=1
				if(!Pass)
					for(var/turf/A in block(locate(X,Y,Z),locate(X,Y,Z)))
						if(A.type==type&&A.icon==RefMat.icon&&A.icon_state==RefMat.icon_state)
							del A

		CreateAtom(atom/type,X,Y,Z)//Creates the atom
			if(CreateOverlay)
				var/icon/A=new(RefMat.icon,RefMat.icon_state)
				for(var/turf/B in block(locate(X,Y,Z),locate(X,Y,Z)))
					B.overlays+=A
			else
				var/atom/A=new type(locate(X,Y,Z))
				if(!ispath(type,/area))
					if(Reference)
						for(var/v in A.vars)
							if(v!="client" && v!="key" && v!="ckey" && v!="group" && v!="type" && v!="parent_type"&&v!="locs"&&v!="verbs"&&v!="vars"&&v!="loc"&&v!="x"&&v!="y"&&v!="z")
								if(istype(Reference.vars[v],/list))
									for(var/M in Reference.vars[v])
										if(istype(M,/atom))
											var/W=M:type
											var/atom/Q=new W
											A.vars[v]+=Q
										else
											A.vars[v]+=M
									continue
								A.vars[v]=Reference.vars[v]
					else
						A.icon=RefMat.icon
						A.icon_state=RefMat.icon_state

		UpdateCreateVerbs(N)//Update your verbs accordingly
			if(N)
				verbs+=typesof(/mob/VerbHolder/Admin/Level4/Create/verb)
			else
				verbs-=typesof(/mob/VerbHolder/Admin/Level4/Create/verb)
				CreateFirst=null
				for(var/image/I in client.images)
					if(I.name=="CreateHighlight")
						client.images-=I
						break

		GetCreating(N=0)//Figures out what the path is
			var/C=CreateVar[1]
			if(C!="Search")
				if(CreateVar.len>1)
					for(var/I=2 to CreateVar.len-N)
						C+=CreateVar[I]
			else
				C="/atom"
			return  C

		UpdateCreate(A,B)//Update the grid
			winset(src,"CreatePage.AtomGrid","cells=0x0")
			if(Creating!=null)
				if(findtext(A,"/area")==0)
					var/type=text2path(A)
					var/atom/I=new type(locate(1000,1000,4))//Set to a location that is always out of sight, the only reason this is needed is because turfs couldn't be created otherwise
					if(RefMat)
						RefMat.icon=I.icon
						RefMat.icon_state=I.icon_state
						del I
						src<<output(RefMat,"CreatePage.IconOut:1,1")
			else
				src<<output(null,"CreatePage.IconOut:1,1")
			var/list/L=list()
			var/r=1
			var/c=0
			for(var/X in typesof(text2path("[A]")))
				var/H=1
				var/T="[X]"
				if(CreateVar.len>0)
					H=CreateVar.len
					src<<output(Creating,"CreatePage.SelectedOut")
					T=copytext(T,length(Creating)+1,0)
				var/t
				for(var/I=1 to H)
					var/a=findtext(T,"/",2)
					if(a)
						t+="[copytext(T,1,a)]"
						T=copytext(T,a,0)
				if(!t)
					t=T
				if(t in L)
					continue
				var/a=findtext(t,"/",2)
				if(a)
					continue
				L+=t
			for(var/X in L)
				if(B)
					if(findtext(X,B)==0)
						continue
				if(findtext(X,"/",2)==1)
					continue
				if(X==A||X=="")
					continue
				src<<output("<a style=\"text-decoration:none;\" href=\"?src=\ref[src];action=Create;vari=[X]\">[X]</a>","CreatePage.AtomGrid:[++c],[r]")
				if(c==4)
					c=0
					r++
	var//tmp vars incase your save system saves the entire mob
		tmp/InCreate
		tmp/Creating
		tmp/list/CreateVar=list()
		tmp/CreateAdd
		tmp/obj/RefMat
		tmp/atom/CreateFirst
		tmp/CreateDelete
		tmp/CreateOverlay
		tmp/atom/Reference
	verb
		CloseCreate()//Close and reset the create system
			set hidden=1
			CloseCreateProc()

mob/VerbHolder/Admin/Level4/
	verb
		Create()//The verb to open the panel
			set category="Admin"
			CreateVar=list()
			RefMat=null
			CreateFirst=null
			InCreate=1
			winset(src,"CreatePage","is-visible=true")
			UpdateCreateVerbs(1)
			UpdateCreate("/atom")
			src<<output("/atom","CreatePage.SelectedOut")
			RefMat=new/obj
			AutoSearchCreate()
client
	Click(atom/O)
		..()
		var/mob/U=mob
		if(U.InCreate&&U.CreateAdd)
			var/x1=O.x
			var/y1=O.y
			var/x2=O.x
			var/y2=O.y
			var/type=text2path(U.Creating)
			var/Z
			if(U.CreateAdd==2)
				if(!U.CreateFirst)
					U.CreateFirst=O
					var/image/I=image('createSelect.dmi',O,"")
					I.name="CreateHighlight"
					U<<I
					return
				else
					if(O!=U.CreateFirst)
						if(U.CreateFirst.x<O.x)
							x1=U.CreateFirst.x
							x2=O.x
						else
							x1=O.x
							x2=U.CreateFirst.x
						if(U.CreateFirst.y<O.y)
							y1=U.CreateFirst.y
							y2=O.y
						else
							y1=O.y
							y2=U.CreateFirst.y
					else
						Z=1
					U.CreateFirst=null
					for(var/image/I in images)
						if(I.name=="CreateHighlight")
							images-=I
							break
			if(!Z)
				for(var/turf/T in block(locate(x1,y1,O.z),locate(x2,y2,O.z)))
					if(U.CreateDelete)
						U.CreateDeleteAtom(type,T.x,T.y,T.z)
					else
						U.CreateAtom(type,T.x,T.y,T.z)

	Topic(href,href_list[])//Used in the grid to update the list of types
		var/mob/U=mob
		switch(href_list["action"])
			if("CreateState")
				U.RefMat.icon_state=href_list["vari"]
				src<<output(U.RefMat,"CreatePage.IconOut:1,1")
				U.Reference=null
			if("Create")
				winset(src,"CreatePage.Search","text")
				if(U.CreateVar.len>0)
					if(U.CreateVar[U.CreateVar.len]=="Search")
						U.CreateVar.len--
				U.CreateVar+=href_list["vari"]
				U.Creating=U.GetCreating()
				U.UpdateCreate(U.Creating)
				U.Reference=null
				if(U.CreateVar.len>0)
					winset(U,"CreatePage.BackBut","is-visible=true")
		.=..()