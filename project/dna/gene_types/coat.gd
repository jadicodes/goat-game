class_name CoatGene
extends Gene

enum Allele {
	WHITE,
	BROWN,
	BLACK,
}

enum Coat {
	WHITE,
	BROWN,
	BLACK,
	LIGHT_BROWN,
	DARK_BROWN,
	GRAY,
}


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.COAT


func get_coat() -> Coat:
	# TODO: Ignore allele order
	match value:
		Vector2i(Allele.WHITE, Allele.WHITE):
			return Coat.WHITE
		Vector2i(Allele.BROWN, Allele.BROWN):
			return Coat.BROWN
		Vector2i(Allele.BLACK, Allele.BLACK):
			return Coat.BLACK
		Vector2i(Allele.WHITE, Allele.BROWN):
			return Coat.LIGHT_BROWN
		Vector2i(Allele.BROWN, Allele.WHITE):
			return Coat.LIGHT_BROWN
		Vector2i(Allele.BROWN, Allele.BLACK):
			return Coat.DARK_BROWN
		Vector2i(Allele.BLACK, Allele.BROWN):
			return Coat.DARK_BROWN
		Vector2i(Allele.WHITE, Allele.BLACK):
			return Coat.GRAY
		Vector2i(Allele.BLACK, Allele.WHITE):
			return Coat.GRAY

	return Coat.WHITE  # Should never happen, but a default is needed
