class_name ShopperEnterState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		((get_viewport().size / 2.0) - shopper.global_position).normalized() * shopper.speed
	)

	await get_tree().create_timer(5).timeout

	finished.emit(ARRIVE_AT_FENCE)
	# shopper.animation_player.play("run")
