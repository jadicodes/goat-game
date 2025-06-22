class_name Goat
extends CharacterBody2D

@export var dna: DNA

@export var speed: float = 100.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	dna = DNA.new()

	dna.get_gene(DNA.GeneType.COAT).set_value(CoatGene.Allele.BROWN if randi() % 2 == 0 else CoatGene.Allele.BLACK)

	set_color(dna.get_gene(DNA.GeneType.COAT).get_color())
	set_size(dna.get_gene(DNA.GeneType.SIZE).get_scale())


func _physics_process(_delta: float) -> void:
	move_and_slide()


func set_color(color: Color) -> void:
	sprite.modulate = color


func set_size(new_scale: float) -> void:
	sprite.scale = Vector2(new_scale, new_scale)


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	state_machine.transition_to_next_state(GoatState.FOLLOW, {
		"target": caller
	})
