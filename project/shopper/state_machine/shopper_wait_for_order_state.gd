class_name ShopperWaitForOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Waiting for order...")


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	var goats = (caller as Farmer).empty_goats()

	if not goats:
		print("SHOPPER: No goats available!")
		finished.emit(ORDER_FAILURE)
		return
	
	for goat in goats:
		print("SHOPPER: Goat received - ", goat.name)
		goat.queue_free()
	
	print("SHOPPER: Received order from farmer!")
	finished.emit(ORDER_SUCCESS)
