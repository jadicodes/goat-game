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



func get_default_value() -> Vector2i:
	return Vector2i(Allele.values().pick_random(), Allele.values().pick_random())


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
		_:
			return Coat.WHITE  # Should never happen, but a default is needed


func get_color() -> Color:
	match get_coat():
		Coat.WHITE:
			return Color(1, 1, 1)
		Coat.BROWN:
			return Color(0.5, 0.25, 0)
		Coat.BLACK:
			return Color(0.2, 0.2, 0.2)
		Coat.LIGHT_BROWN:
			return Color(0.75, 0.5, 0.25)
		Coat.DARK_BROWN:
			return Color(0.25, 0.125, 0)
		Coat.GRAY:
			return Color(0.5, 0.5, 0.5)
		_:
			return Color(1, 1, 1)  # Should never happen, but a default is needed
