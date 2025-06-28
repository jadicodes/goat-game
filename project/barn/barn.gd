class_name Barn
extends Node2D

signal day_advanced

@onready var _conductor: BarnActionConductor = %BarnActionConductor
@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func go_to_sleep() -> void:
	_animation_player.play("barn_sleep")

	await _animation_player.animation_finished

	_animation_player.play("barn_shake")

	await _conductor.activate_barn_actions()

	_animation_player.stop()

	_animation_player.play_backwards("barn_sleep")

	await _animation_player.animation_finished

	day_advanced.emit()
