class_name Gene
extends Resource

@export var value: Vector2i


func _init(new_value: Vector2i = get_default_value()):
	if new_value == null:
		new_value = get_default_value()

	self.value = new_value


func get_default_value() -> Vector2i:
	return Vector2i(0, 0)


func get_type_enum() -> DNA.GeneType:
	return -1  # Default value, should be overridden in subclasses


func set_value(x: int, y: int = -1) -> void:
	if y == -1:
		y = x  # If y is not provided, set it equal to x
	self.value = Vector2i(x, y)


func get_phenotype() -> int:
	return -1  # Default value, should be overridden in subclasses


static func get_random_phenotype() -> int:
	return -1  # Default value, should be overridden in subclasses


static func combine(a: Gene, b: Gene) -> Gene:
	assert(a.get_type_enum() == b.get_type_enum(), "Genes must be of the same type to combine")

	var gene_type = DNA.GeneClass[a.get_type_enum()]

	if a == null:
		a = gene_type.new()
	if b == null:
		b = gene_type.new()

	var new_value = Vector2i(
		a.value.x if randi() % 2 == 0 else a.value.y, b.value.x if randi() % 2 == 0 else b.value.y
	)

	return gene_type.new(new_value)
