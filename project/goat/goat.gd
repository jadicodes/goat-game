class_name Goat
extends CharacterBody2D

const GOAT_SCENE = preload("res://goat/goat.tscn")

@export var speed: float = 100.0

var dna: DNA

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	set_dna()


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

func set_dna(new_dna: DNA = null) -> void:
	if new_dna:
		dna = new_dna
	
	if dna == null:
		dna = DNA.new()
	
	set_color.call_deferred(dna.get_gene(DNA.GeneType.COAT).get_color())
	set_size.call_deferred(dna.get_gene(DNA.GeneType.SIZE).get_scale())


static func create(new_dna: DNA) -> Goat:
	var new_goat = GOAT_SCENE.instantiate()
	new_goat.set_dna(new_dna)
	return new_goat
