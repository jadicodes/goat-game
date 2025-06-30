class_name ShopperGiveOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Giving order to farmer...")

	var order_data := _generate_order()

	await get_tree().create_timer(1.0).timeout
	

	var gene_type_name: String = DNA.GeneType.keys()[order_data.gene_type]
	%SpeechBubble.display_text(tr("%s_%d" % [gene_type_name, order_data.phenotype]))

	finished.emit(WAIT_FOR_ORDER, {"order_data": order_data})


func _generate_order() -> Dictionary:
	var days = shopper.start_day
	print(days)
	print(shopper.start_day)

	var gene_type: DNA.GeneType = [DNA.GeneType.COAT].pick_random()

	var phenotype: int = DNA.get_gene_class(gene_type).get_random_phenotype()

	var order_data: Dictionary = {"gene_type": gene_type, "phenotype": phenotype}

	if days >2 and days <7:
		gene_type = [DNA.GeneType.SIZE].pick_random()

		phenotype = DNA.get_gene_class(gene_type).get_random_phenotype()

		order_data = {"gene_type": gene_type, "phenotype": phenotype}

	return order_data
