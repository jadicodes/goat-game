class_name ShopperLeaveState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		(shopper.global_position - (get_viewport().size / 2.0)).normalized() * shopper.speed
	)

	await get_tree().create_timer(5).timeout

	shopper.queue_free()
	# shopper.animation_player.play("run")
