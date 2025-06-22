class_name GoatWanderState
extends GoatState


func enter(_previous_state_path: String, _data := {}) -> void:
    goat.velocity = Vector2.from_angle(randf_range(0, TAU)) * goat.speed
    # goat.animation_player.play("run")

    await get_tree().create_timer(randf_range(1, 3)).timeout

    finished.emit(IDLE)


