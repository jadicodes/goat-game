class_name GoatBreeder
extends Node


func _breed(goat1, goat2):
	var new_goat = Goat.create(DNA.combine(goat1.dna, goat2.dna))
	new_goat.global_position = get_viewport().size / 2
	get_tree().get_root().add_child(new_goat)
	print("Making a sweet angel goat")
