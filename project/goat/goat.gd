class_name Goat
extends CharacterBody2D

const GOAT_SCENE = preload("res://goat/goat.tscn")

const GOAT_FRONT_SPRITE = preload("res://goat/goat_sprite.png")
const GOAT_BACK_SPRITE = preload("res://goat/goat_sprite_back.png")

@export var speed: float = 100.0

@export var dna: DNA

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $StateMachine


func _ready() -> void:
	set_dna()


func _process(_delta: float) -> void:
	_set_sprite_direction()


func _physics_process(_delta: float) -> void:
	move_and_slide()


func _set_sprite_direction() -> void:
	if velocity == Vector2.ZERO:
		return  # No movement, no need to change sprite direction

	if velocity.y > 0:
		sprite.texture = GOAT_FRONT_SPRITE
		sprite.flip_h = (velocity.x > 0)  # Flip sprite horizontally if moving right
	elif velocity.y < 0:
		sprite.texture = GOAT_BACK_SPRITE
		sprite.flip_h = (velocity.x < 0)  # Flip sprite horizontally if moving left



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
