extends CharacterBody2D

@export var dna: DNA

@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	dna = DNA.new()

	dna.get_gene(DNA.GeneType.COAT).set_value(CoatGene.Allele.BROWN if randi() % 2 == 0 else CoatGene.Allele.BLACK)

	set_color(dna.get_gene(DNA.GeneType.COAT).get_color())


func set_color(color: Color) -> void:
	sprite.modulate = color
