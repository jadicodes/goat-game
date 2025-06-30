class_name ShopperWaitForOrderState
extends ShopperState

var _order_data: Dictionary


func enter(_previous_state_path: String, data := {}) -> void:
	_order_data = data.get("order_data")

	assert(_order_data, "No order data provided to ShopperWaitForOrderState.")

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
		var phenotype: int = goat.dna.get_gene(_order_data.gene_type).get_phenotype()

		if _order_data.has("secondary_type"):
			var secondary_phenotype: int = goat.dna.get_gene(_order_data.secondary_type).get_phenotype()
			if secondary_phenotype != _order_data.secondary_phenotype:
				print("SHOPPER: No matching goats found!")
				finished.emit(ORDER_FAILURE)

		if phenotype == _order_data.phenotype:
			goat.queue_free()

			print("SHOPPER: Received order from farmer!")
			finished.emit(ORDER_SUCCESS)
			return

	print("SHOPPER: No matching goats found!")
	finished.emit(ORDER_FAILURE)
