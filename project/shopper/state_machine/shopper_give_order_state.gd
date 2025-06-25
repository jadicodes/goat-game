class_name ShopperGiveOrderState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	print("SHOPPER: Giving order to farmer...")
	
	_generate_order()
	
	await get_tree().create_timer(1.0).timeout

	finished.emit(WAIT_FOR_ORDER)
	
func _generate_order():
	var coat_gene = CoatGene.new()
	var size_gene = SizeGene.new()
	var pattern_gene = PatternGene.new()
	coat_gene.set_value(randi() % CoatGene.Allele.size(), randi() % CoatGene.Allele.size())
	size_gene.set_value(randi() % SizeGene.Size.size())
	pattern_gene.set_value(randi() % PatternGene.Pattern.size())

	var rand_dna = DNA.new()
	rand_dna.genes[DNA.GeneType.COAT] = coat_gene
	rand_dna.genes[DNA.GeneType.SIZE] = size_gene
	rand_dna.genes[DNA.GeneType.PATTERN] = pattern_gene
	
	# TODO: Call currently fails -- sprite is null. fails on set_color
	#var cultist_goat = Goat.create(rand_dna)
		
	print(CoatGene.Coat.keys()[rand_dna.get_gene(DNA.GeneType.COAT).get_coat()])
	print(SizeGene.Size.keys()[rand_dna.get_gene(DNA.GeneType.SIZE).get_size()])
	print(PatternGene.Pattern.keys()[rand_dna.get_gene(DNA.GeneType.PATTERN).get_pattern()])
