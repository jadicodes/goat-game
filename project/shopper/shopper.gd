class_name Shopper
extends CharacterBody2D

const TOTAL_DAYS := 4

var speed: int = 100
var _days: int = 0
var start_day: int = 0

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


func _on_day_advanced() -> void:
	_days += 1
	%DaysLeftLabel.text = str(4 - _days) + " days left"

	if _days >= TOTAL_DAYS:
		state_machine.transition_to_next_state(ShopperState.ORDER_FAILURE)
