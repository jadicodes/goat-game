extends CharacterBody2D

@export var dna: DNA

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	dna = DNA.new()

	dna.get_gene(DNA.GeneType.COAT).set_value(CoatGene.Allele.BROWN if randi() % 2 == 0 else CoatGene.Allele.BLACK)

	set_color(dna.get_gene(DNA.GeneType.COAT).get_color())
	set_size(dna.get_gene(DNA.GeneType.SIZE).get_scale())


func set_color(color: Color) -> void:
	sprite.modulate = color


func set_size(new_scale: float) -> void:
	sprite.scale = Vector2(new_scale, new_scale)


func interact(caller: Node) -> void:
	print(self.name, " interacted with by ", caller.name)
