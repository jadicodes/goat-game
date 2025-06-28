class_name Shopper
extends CharacterBody2D

var speed: int = 100

@onready var state_machine: StateMachine = $StateMachine


func _physics_process(_delta: float) -> void:
	move_and_slide()


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	state_machine.state.interact(caller)


func hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", true)


func stop_hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", false)
