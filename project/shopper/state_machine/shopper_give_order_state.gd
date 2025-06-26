class_name ShopperGiveOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Giving order to farmer...")
	
	var order_data := _generate_order()
	
	await get_tree().create_timer(1.0).timeout

	%SpeechBubble.display_text(DNA.get_gene_class(order_data.gene_type).Phenotype.keys()[order_data.phenotype])

	finished.emit(WAIT_FOR_ORDER, {
		"order_data": order_data
	})
	
func _generate_order() -> Dictionary:
	var gene_type: DNA.GeneType = [DNA.GeneType.COAT].pick_random()

	var phenotype: int = DNA.get_gene_class(gene_type).get_random_phenotype()

	var order_data: Dictionary = {
		"gene_type": gene_type,
		"phenotype": phenotype
	}

	return order_data
