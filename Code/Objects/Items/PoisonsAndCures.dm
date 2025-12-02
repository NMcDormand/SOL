obj/var
	PoisonLevel
obj/Item
	Cure
		icon='Items.dmi'
		icon_state="cure"
		name="Cure"
		trueName="Cure"
		Stackable = 1
		verb
			Use()
				usr<<"You used the cure!"
	Poison
		icon='Items.dmi'
		icon_state="poison"
		name="Poison"
		trueName="Poison"
		PoisonLevel=1
		Stackable = 1
		DblClick() Use()
		verb
			Use()
				usr<<"You used the poison!"
				/*
				select to apply it to a weapon; once done the weapon can never again be repaired
				Each blow will do poison damage, and if not already poisoned - posion the target.
				The target will receive no poison damage if they have received a vaccine within the past 5 minutes.
				Vaccines are crafted at a higher level to cures, But cures also work as a vaccine for a short amount of time.
				*/
