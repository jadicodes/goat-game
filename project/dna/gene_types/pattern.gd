class_name PatternGene
extends Gene

enum Allele {
	SOLID,
	STRIPED,
	SPOTTED,
}

enum Phenotype {
	SOLID,
	STRIPED,
	SPOTTED,
}


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.PATTERN


func get_phenotype() -> Phenotype:
	match value:
		Vector2i(Allele.SOLID, Allele.SOLID):
			return Phenotype.SOLID
		Vector2i(Allele.STRIPED, Allele.STRIPED):
			return Phenotype.STRIPED
		Vector2i(Allele.SPOTTED, Allele.SPOTTED):
			return Phenotype.SPOTTED
		Vector2i(Allele.SOLID, Allele.STRIPED):
			return Phenotype.SOLID
		Vector2i(Allele.SOLID, Allele.SPOTTED):
			return Phenotype.SOLID

	return Phenotype.STRIPED  # Should never happen
