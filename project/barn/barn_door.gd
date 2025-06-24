class_name BarnDoor
extends StaticBody2D


@export var _goat_breeder : GoatBreeder

func interact(caller: Node) -> void:
	if not caller is Farmer:
		return
	
	var _goats_entering_barn : Array[Goat] = caller.get_goats()
	if _goats_entering_barn.size() == 2:
		_breed(_goats_entering_barn[0], _goats_entering_barn[1])
	if _goats_entering_barn.size() == 1:
		_sacrifice(_goats_entering_barn[0])
	else:
		_go_to_sleep()
	print("Interacting with the barn door.")


func _breed(goat1, goat2):
	_goat_breeder._breed(goat1, goat2)


func _sacrifice(goat):
	pass


func _go_to_sleep():
	pass
