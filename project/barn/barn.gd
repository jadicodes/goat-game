class_name Barn
extends Node2D

signal day_advanced

const SACRIFICE_DURATION := 0.5

@export var _farmer: Farmer

var _souls := 0

@onready var _conductor: BarnActionConductor = %BarnActionConductor
@onready var _animation_player: AnimationPlayer = %AnimationPlayer
@onready var _barn_door: BarnDoor = %BarnDoor


func go_to_sleep() -> void:
	_farmer.process_mode = Node2D.PROCESS_MODE_DISABLED

	await _barn_door.open()

	_farmer.visible = false

	await _barn_door.close()

	await _play_sleep_animation()

	await _conductor.activate_barn_actions()

	await _play_wake_animation()

	await _barn_door.open()

	_farmer.visible = true

	await _barn_door.close()

	_farmer.process_mode = Node2D.PROCESS_MODE_INHERIT

	day_advanced.emit()


func sacrifice() -> void:
	_animation_player.play("sacrifice")
	await _animation_player.animation_finished

	await get_tree().create_timer(SACRIFICE_DURATION).timeout

	_animation_player.play_backwards("sacrifice")
	await _animation_player.animation_finished


func start_shaking() -> void:
	_animation_player.play("barn_shake")
	await _animation_player.animation_finished


func stop_shaking() -> void:
	_animation_player.stop()


func is_powered() -> bool:
	return _souls > 0


func use_power() -> bool:
	if not is_powered():
		return false

	_souls -= 1

	if _souls == 0:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color("#ffffff"), 0.5)

	return true


func add_soul(count := 1) -> void:
	if not is_powered():
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color("#f5a390"), 0.5)

	_souls += count


func _play_sleep_animation() -> void:
	_animation_player.play("barn_sleep")
	await _animation_player.animation_finished


func _play_wake_animation() -> void:
	_animation_player.play_backwards("barn_sleep")
	await _animation_player.animation_finished
