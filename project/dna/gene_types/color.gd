class_name ColorGene
extends Gene

enum Allele {
	WHITE,
	BROWN,
	BLACK,
}


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.COLOR


func get_color() -> Color:
	# TODO: Ignore allele order
	match value:
		Vector2i(Allele.WHITE, Allele.WHITE):
			return Color(1, 1, 1)  # White
		Vector2i(Allele.BROWN, Allele.BROWN):
			return Color(0.6, 0.4, 0.2)  # Brown
		Vector2i(Allele.BLACK, Allele.BLACK):
			return Color(0, 0, 0)  # Black
		Vector2i(Allele.WHITE, Allele.BROWN):
			return Color(0.8, 0.7, 0.5)  # Light brown
		Vector2i(Allele.WHITE, Allele.BLACK):
			return Color(0.5, 0.5, 0.5)  # Gray
		Vector2i(Allele.BROWN, Allele.BLACK):
			return Color(0.3, 0.2, 0.1)  # Dark brown

	return Color(1, 1, 1)  # Default to white if no match
