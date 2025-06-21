class_name PatternGene
extends Gene

enum Allele {
	SOLID,
	STRIPED,
	SPOTTED,
}

enum Pattern {
	SOLID,
	STRIPED,
	SPOTTED,
}


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.PATTERN


func get_pattern() -> Pattern:
	match value:
		Vector2i(Allele.SOLID, Allele.SOLID):
			return Pattern.SOLID
		Vector2i(Allele.STRIPED, Allele.STRIPED):
			return Pattern.STRIPED
		Vector2i(Allele.SPOTTED, Allele.SPOTTED):
			return Pattern.SPOTTED

	if (
		value == Vector2i(Allele.SOLID, Allele.STRIPED)
		or value == Vector2i(Allele.STRIPED, Allele.SOLID)
	):
		return Pattern.STRIPED
	if (
		value == Vector2i(Allele.SOLID, Allele.SPOTTED)
		or value == Vector2i(Allele.SPOTTED, Allele.SOLID)
	):
		return Pattern.SPOTTED

	if value.x == Allele.STRIPED:
		return Pattern.STRIPED
	if value.x == Allele.SPOTTED:
		return Pattern.SPOTTED

	return Pattern.SOLID  # Should never happen
