extends GutTest


func test_pattern_gene_output():
	var coat_gene = CoatGene.new()
	coat_gene.set_value(CoatGene.Allele.WHITE, CoatGene.Allele.WHITE)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.WHITE, "Coat should be WHITE")
	coat_gene.set_value(CoatGene.Allele.BROWN, CoatGene.Allele.BROWN)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.BROWN, "Coat should be BROWN")
	coat_gene.set_value(CoatGene.Allele.BLACK, CoatGene.Allele.BLACK)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.BLACK, "Coat should be BLACK")
	coat_gene.set_value(CoatGene.Allele.WHITE, CoatGene.Allele.BROWN)
	assert_eq(
		coat_gene.get_phenotype(), CoatGene.Phenotype.LIGHT_BROWN, "Coat should be LIGHT_BROWN"
	)
	coat_gene.set_value(CoatGene.Allele.BROWN, CoatGene.Allele.WHITE)
	assert_eq(
		coat_gene.get_phenotype(), CoatGene.Phenotype.LIGHT_BROWN, "Coat should be LIGHT_BROWN"
	)
	coat_gene.set_value(CoatGene.Allele.BROWN, CoatGene.Allele.BLACK)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.DARK_BROWN, "Coat should be DARK_BROWN")
	coat_gene.set_value(CoatGene.Allele.BLACK, CoatGene.Allele.BROWN)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.DARK_BROWN, "Coat should be DARK_BROWN")
	coat_gene.set_value(CoatGene.Allele.WHITE, CoatGene.Allele.BLACK)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.GRAY, "Coat should be GRAY")
	coat_gene.set_value(CoatGene.Allele.BLACK, CoatGene.Allele.WHITE)
	assert_eq(coat_gene.get_phenotype(), CoatGene.Phenotype.GRAY, "Coat should be GRAY")
