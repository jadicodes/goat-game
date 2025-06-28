class_name GoatHiddenState
extends GoatState


var _start_color: Color
var _start_collision_layer: int
var _tween: Tween

func enter(_previous_state_path: String, _data := {}) -> void:
	_start_color = Color(goat.modulate)
	_start_collision_layer = goat.collision_layer
	goat.velocity = Vector2.ZERO
	_tween = get_tree().create_tween()
	_tween.tween_property(goat, "modulate", Color.hex(0x1d1c2a00), 1)
	_tween.tween_callback(func() -> void:
		goat.hide()
		goat.collision_layer = 0
	)


func exit() -> void:
	assert(_tween, "Tween must be initialized before exiting GoatHiddenState.")

	goat.show()
	_tween.kill()
	goat.collision_layer = _start_collision_layer
	goat.modulate = _start_color
