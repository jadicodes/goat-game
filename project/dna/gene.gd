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


static func combine(a: Gene, b: Gene) -> Gene:
	if a == null:
		a = Gene.new()
	if b == null:
		b = Gene.new()

	var new_value = Vector2i(
		a.value.x if randi() % 2 == 0 else a.value.y, b.value.x if randi() % 2 == 0 else b.value.y
	)

	return Gene.new(new_value)
