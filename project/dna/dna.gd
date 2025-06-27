class_name DNA
extends Resource

enum GeneType {
	SIZE,
	COAT,
	PATTERN,
}

static var gene_class = {
	GeneType.SIZE: SizeGene,
	GeneType.COAT: CoatGene,
	GeneType.PATTERN: PatternGene,
}

@export var genes: Dictionary[GeneType, Gene] = {}


func get_gene(gene_type: GeneType) -> Gene:
	if not genes.has(gene_type):
		genes[gene_type] = gene_class[gene_type].new()
	return genes.get(gene_type)


static func get_gene_class(gene_type: GeneType) -> GDScript:
	if not gene_class.has(gene_type):
		return null
	return gene_class[gene_type]


static func combine(a: DNA, b: DNA) -> DNA:
	var new_dna = DNA.new()

	for gene_type in GeneType.values():
		new_dna.genes[gene_type] = Gene.combine(a.get_gene(gene_type), b.get_gene(gene_type))

	return new_dna
