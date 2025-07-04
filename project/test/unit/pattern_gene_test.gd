extends GutTest


func test_pattern_gene_output():
	var pattern_gene = PatternGene.new()
	pattern_gene.set_value(PatternGene.Allele.SOLID, PatternGene.Allele.SOLID)
	assert_eq(pattern_gene.get_phenotype(), PatternGene.Phenotype.SOLID, "Pattern should be SOLID")
	pattern_gene.set_value(PatternGene.Allele.STRIPED, PatternGene.Allele.STRIPED)
	assert_eq(
		pattern_gene.get_phenotype(), PatternGene.Phenotype.STRIPED, "Pattern should be STRIPED"
	)
	pattern_gene.set_value(PatternGene.Allele.SPOTTED, PatternGene.Allele.SPOTTED)
	assert_eq(
		pattern_gene.get_phenotype(), PatternGene.Phenotype.SPOTTED, "Pattern should be SPOTTED"
	)
	pattern_gene.set_value(PatternGene.Allele.SOLID, PatternGene.Allele.STRIPED)
	assert_eq(pattern_gene.get_phenotype(), PatternGene.Phenotype.SOLID, "Pattern should be SOLID")
	pattern_gene.set_value(PatternGene.Allele.STRIPED, PatternGene.Allele.SOLID)
	assert_eq(pattern_gene.get_phenotype(), PatternGene.Phenotype.SOLID, "Pattern should be SOLID")
	pattern_gene.set_value(PatternGene.Allele.SOLID, PatternGene.Allele.SPOTTED)
	assert_eq(pattern_gene.get_phenotype(), PatternGene.Phenotype.SOLID, "Pattern should be SOLID")
	pattern_gene.set_value(PatternGene.Allele.SPOTTED, PatternGene.Allele.SOLID)
	assert_eq(pattern_gene.get_phenotype(), PatternGene.Phenotype.SOLID, "Pattern should be SOLID")
	pattern_gene.set_value(PatternGene.Allele.STRIPED, PatternGene.Allele.SPOTTED)
	assert_eq(
		pattern_gene.get_phenotype(), PatternGene.Phenotype.STRIPED, "Pattern should be STRIPED"
	)
	pattern_gene.set_value(PatternGene.Allele.SPOTTED, PatternGene.Allele.STRIPED)
	assert_eq(
		pattern_gene.get_phenotype(), PatternGene.Phenotype.STRIPED, "Pattern should be STRIPED"
	)
