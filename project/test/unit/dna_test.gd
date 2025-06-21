extends GutTest

func test_dna_initialization():
	var dna = DNA.new()
	
	for gene_type in DNA.GeneType.values():
		var gene = dna.get_gene(gene_type)
		assert_not_null(gene, "Gene should not be null")
		assert_true(gene is Gene, "Gene should be an instance of Gene")
		assert_eq(gene.get_type_enum(), gene_type, "Gene type should match")


func test_dna_combination():
	var dna1 := DNA.new()
	var dna2 := DNA.new()
	
	# Set specific values for testing
	dna1.get_gene(DNA.GeneType.SIZE).set_value(SizeGene.Allele.SMALL)
	dna2.get_gene(DNA.GeneType.SIZE).set_value(SizeGene.Allele.LARGE)

	var combined_dna := DNA.combine(dna1, dna2)

	var combined_size_gene := combined_dna.get_gene(DNA.GeneType.SIZE)
	assert_not_null(combined_size_gene, "Combined size gene should not be null")
	assert_true(combined_size_gene is SizeGene, "Combined gene should be an instance of SizeGene")

	assert_eq(combined_size_gene.value.x, SizeGene.Allele.SMALL, "Combined size gene x value should be SMALL")
	assert_eq(combined_size_gene.value.y, SizeGene.Allele.LARGE, "Combined size gene y value should be LARGE")
