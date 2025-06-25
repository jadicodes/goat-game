class_name SizeGene
extends Gene

enum Allele {
	SMALL,
	LARGE,
}

enum Phenotype {
	SMALL,
	MEDIUM,
	LARGE,
}

func get_default_value() -> Vector2i:
	return Vector2i(Allele.SMALL, Allele.LARGE)


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.SIZE


func get_phenotype() -> Phenotype:
	if value == Vector2i(Allele.SMALL, Allele.SMALL):
		return Phenotype.SMALL
	elif value == Vector2i(Allele.LARGE, Allele.LARGE):
		return Phenotype.LARGE

	return Phenotype.MEDIUM


func get_scale() -> float:
	match get_phenotype():
		Phenotype.SMALL:
			return 0.5
		Phenotype.MEDIUM:
			return 1.0
		Phenotype.LARGE:
			return 1.5
		_:
			return 1.0  # Should never happen, but a default is needed
