class_name GoatIdleState
extends GoatState

func enter(_previous_state_path: String, _data := {}) -> void:
	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("idle")
	await get_tree().create_timer(randf_range(2, 10)).timeout

	finished.emit(WANDER)
