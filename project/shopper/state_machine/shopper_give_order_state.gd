class_name ShopperGiveOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Giving order to farmer...")

	var order_data := _generate_order()

	await get_tree().create_timer(1.0).timeout
	if not order_data.has("secondary_type"):
		var gene_type_name: String = DNA.GeneType.keys()[order_data.gene_type]
		%SpeechBubble.display_text(tr("%s_%d" % [gene_type_name, order_data.phenotype]))

	if order_data.has("secondary_type"):
		var gene_type_name: String = DNA.GeneType.keys()[order_data.gene_type]
		var secondary_gene_type_name: String = DNA.GeneType.keys()[order_data.secondary_type]
		%SpeechBubble.display_text(tr("%s_%d" % [secondary_gene_type_name, order_data.secondary_phenotype]) +"\n"+ tr("%s_%d" % [gene_type_name, order_data.phenotype]))

	finished.emit(WAIT_FOR_ORDER, {"order_data": order_data})


func _generate_order() -> Dictionary:
	var days = shopper.start_day
	print(days)
	print(shopper.start_day)

	var gene_type: DNA.GeneType = [DNA.GeneType.COAT].pick_random()

	var phenotype: int = DNA.get_gene_class(gene_type).get_random_phenotype()

	var order_data: Dictionary = {"gene_type": gene_type, "phenotype": phenotype}

	if days >3:
		gene_type = [DNA.GeneType.SIZE].pick_random()

		phenotype = DNA.get_gene_class(gene_type).get_random_phenotype()
		if days <8:
			order_data = {"gene_type": gene_type, "phenotype": phenotype}
			print(order_data)
		else:
			order_data["secondary_type"] = gene_type
			order_data["secondary_phenotype"] = phenotype
			print(order_data)
		

	return order_data
