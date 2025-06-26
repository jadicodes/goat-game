class_name CoatGene
extends Gene

enum Allele {
	WHITE,
	BROWN,
	BLACK,
}

enum Phenotype {
	WHITE,
	BROWN,
	BLACK,
	LIGHT_BROWN,
	DARK_BROWN,
	GRAY,
}



func get_default_value() -> Vector2i:
	return Vector2i(Allele.values().pick_random(), Allele.values().pick_random())


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.COAT


func get_phenotype() -> Phenotype:
	match value:
		Vector2i(Allele.WHITE, Allele.WHITE):
			return Phenotype.WHITE
		Vector2i(Allele.BROWN, Allele.BROWN):
			return Phenotype.BROWN
		Vector2i(Allele.BLACK, Allele.BLACK):
			return Phenotype.BLACK
		Vector2i(Allele.WHITE, Allele.BROWN):
			return Phenotype.LIGHT_BROWN
		Vector2i(Allele.BROWN, Allele.BLACK):
			return Phenotype.DARK_BROWN
		Vector2i(Allele.WHITE, Allele.BLACK):
			return Phenotype.GRAY
		_:
			assert(false, "Invalid coat allele combination: %s" % value)

	return Phenotype.WHITE  # Should never happen, but a return is needed


func get_color() -> Color:
	match get_phenotype():
		Phenotype.WHITE:
			return Color(1, 1, 1)
		Phenotype.BROWN:
			return Color(0.5, 0.25, 0)
		Phenotype.BLACK:
			return Color(0.2, 0.2, 0.2)
		Phenotype.LIGHT_BROWN:
			return Color(0.75, 0.5, 0.25)
		Phenotype.DARK_BROWN:
			return Color(0.25, 0.125, 0)
		Phenotype.GRAY:
			return Color(0.5, 0.5, 0.5)
		_:
			return Color(1, 1, 1)  # Should never happen, but a default is needed


static func get_random_phenotype() -> int:
	return Phenotype.values().pick_random()
