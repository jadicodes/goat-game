class_name SizeGene
extends Gene

enum Allele {
	SMALL,
	LARGE,
}

enum Size {
	SMALL,
	MEDIUM,
	LARGE,
}


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.SIZE


func get_size() -> int:
	if value == Vector2i(Allele.SMALL, Allele.SMALL):
		return Size.SMALL
	elif value == Vector2i(Allele.LARGE, Allele.LARGE):
		return Size.LARGE

	return Size.MEDIUM
