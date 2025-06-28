class_name ShopperEnterState
extends ShopperState


var _order_point: Vector2

func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		((get_viewport().size / 2.0) - shopper.global_position).normalized() * shopper.speed
	)
	print("shopper position: ", shopper.global_position)
	print(shopper.velocity)
	print(get_viewport().size)
	print("viewport: " + str(get_viewport().size / 2.0))

	await get_tree().create_timer(5).timeout

	finished.emit(ARRIVE_AT_FENCE)
	# shopper.animation_player.play("run")
