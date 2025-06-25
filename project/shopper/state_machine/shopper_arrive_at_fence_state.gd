class_name ShopperArriveAtFenceState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	finished.emit(GIVE_ORDER)
