class_name GoatHiddenState
extends GoatState


func enter(_previous_state_path: String, _data := {}) -> void:
	goat.velocity = Vector2.ZERO
	goat.visible = false


func exit() -> void:
	goat.visible = true
