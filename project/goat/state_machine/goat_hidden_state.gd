class_name GoatHiddenState
extends GoatState


var _start_color: Color


func enter(_previous_state_path: String, _data := {}) -> void:
	_start_color = Color(goat.modulate)
	print(_start_color)
	goat.velocity = Vector2.ZERO
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(goat, "modulate", Color.hex(0x1d1c2a00), 1)
	tween.tween_callback(func() -> void:
		goat.visible = false)


func exit() -> void:
	goat.modulate = _start_color
	goat.visible = true
	print(_start_color)
