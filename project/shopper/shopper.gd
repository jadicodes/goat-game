class_name Shopper
extends CharacterBody2D


var speed : int = 100

func _physics_process(delta: float) -> void:
	move_and_slide()


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return
