class_name DNA
extends Resource

enum GeneType {
	SIZE,
	COLOR,
	PATTERN,
}

var GeneClass = {
	GeneType.SIZE: SizeGene,
	GeneType.COLOR: ColorGene,
	GeneType.PATTERN: PatternGene,
}

@export var genes: Dictionary[GeneType, Gene] = {}


func _init():
	for gene_type in GeneType.values():
		genes[gene_type] = GeneClass[gene_type].new()


func get_gene(gene_type: GeneType) -> Gene:
	return genes.get(gene_type)


static func combine(a: DNA, b: DNA) -> DNA:
	var new_dna = DNA.new()

	for gene_type in GeneType.values():
		new_dna.genes[gene_type] = Gene.combine(a.genes.get(gene_type), b.genes.get(gene_type))

	return new_dna
