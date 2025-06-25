class_name GoatBreeder
extends Node


func _breed(goat1: Goat, goat2: Goat) -> void:
	print("Breeding goats: ", goat1.name, " and ", goat2.name)
	await get_tree().create_timer(2.0).timeout

	var new_goat := Goat.create(DNA.combine(goat1.dna, goat2.dna))
	new_goat.global_position = (goat1.global_position + goat2.global_position) / 2.0
	goat1.get_parent().add_child(new_goat)
	print("Making a sweet angel goat")

	goat1.state_machine.transition_to_next_state(GoatState.IDLE)
	goat2.state_machine.transition_to_next_state(GoatState.IDLE)
