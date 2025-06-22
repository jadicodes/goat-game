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

func get_default_value() -> Vector2i:
	return Vector2i(Allele.SMALL, Allele.LARGE)


func get_type_enum() -> DNA.GeneType:
	return DNA.GeneType.SIZE


func get_size() -> Size:
	if value == Vector2i(Allele.SMALL, Allele.SMALL):
		return Size.SMALL
	elif value == Vector2i(Allele.LARGE, Allele.LARGE):
		return Size.LARGE

	return Size.MEDIUM


func get_scale() -> float:
	match get_size():
		Size.SMALL:
			return 0.5
		Size.MEDIUM:
			return 1.0
		Size.LARGE:
			return 1.5
		_:
			return 1.0  # Should never happen, but a default is needed
