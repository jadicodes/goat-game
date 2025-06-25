class_name ShopperGiveOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Giving order to farmer...")
	await get_tree().create_timer(1.0).timeout

	finished.emit(WAIT_FOR_ORDER)
