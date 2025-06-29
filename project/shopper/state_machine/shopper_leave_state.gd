class_name ShopperLeaveState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		(shopper.global_position - (get_viewport().size / 2.0)).normalized() * shopper.speed
	)

	# Disable collision so shopper can leave the screen
	shopper.collision_layer = 0
	shopper.collision_mask = 0

	await get_tree().create_timer(5).timeout

	shopper.queue_free()
	# shopper.animation_player.play("run")
