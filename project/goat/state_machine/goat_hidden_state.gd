class_name GoatHiddenState
extends GoatState


var _start_color: Color
var _tween: Tween

func enter(_previous_state_path: String, _data := {}) -> void:
	_start_color = Color(goat.modulate)
	goat.velocity = Vector2.ZERO
	_tween = get_tree().create_tween()
	_tween.tween_property(goat, "modulate", Color.hex(0x1d1c2a00), 1)
	_tween.tween_callback(func() -> void:
		goat.visible = false
	)


func exit() -> void:
	goat.visible = true

	if not _tween:
		return

	_tween.kill()
	goat.modulate = _start_color
