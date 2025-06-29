class_name BarnAction
extends RefCounted

var is_instantaneous := false
var conductor: BarnActionConductor


func _init(barn_action_conductor: BarnActionConductor, _data: Dictionary = {}) -> void:
	conductor = barn_action_conductor


func activate() -> void:
	await conductor.get_tree().create_timer(0.1).timeout


func cancel() -> void:
	pass


static func is_applicable(_data: Dictionary = {}) -> bool:
	return false
