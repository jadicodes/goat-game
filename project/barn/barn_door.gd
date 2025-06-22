class_name BarnDoor
extends StaticBody2D


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	print("Interacting with the barn door.")
