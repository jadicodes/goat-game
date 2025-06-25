class_name ShopperWaitForOrderState
extends ShopperState

var order_data: Dictionary


func enter(_previous_state_path: String, data := {}) -> void:
	order_data = data.get("order_data")

	assert(order_data, "No order data provided to ShopperWaitForOrderState.")

	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Waiting for order...")


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	var goats = (caller as Farmer).empty_goats()

	if not goats:
		print("SHOPPER: No goats available!")
		return
	
	for goat in goats:
		var phenotype: int = goat.dna.get_gene(order_data.gene_type).get_phenotype()

		if phenotype == order_data.phenotype:
			goat.queue_free()

			print("SHOPPER: Received order from farmer!")
			finished.emit(ORDER_SUCCESS)
			return
	
	print("SHOPPER: No matching goats found!")
	finished.emit(ORDER_FAILURE)
