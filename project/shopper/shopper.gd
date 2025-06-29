class_name Shopper
extends CharacterBody2D

var speed: int = 100

@onready var state_machine: StateMachine = $StateMachine


func _physics_process(delta: float) -> void:
	var collision := move_and_collide(velocity * delta)

	if collision:
		state_machine.state.on_collision(collision)


func interact(caller: Node) -> void:
	state_machine.interact(caller)


func hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", true)


func stop_hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", false)
