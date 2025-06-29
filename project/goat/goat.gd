class_name Goat
extends CharacterBody2D

const GOAT_SCENE = preload("res://goat/goat.tscn")

const GOAT_FRONT_SPRITE = preload("res://goat/goat_sprite.png")
const GOAT_BACK_SPRITE = preload("res://goat/goat_sprite_back.png")

@export var speed: float = 100.0
@export var _coat_alleles := Vector2i(-1, -1)

@export var dna: DNA

@onready var state_machine: StateMachine = $StateMachine
@onready var hit_box: Area2D = $HitBox
@onready var _sprite: Sprite2D = %DirectionalSprite2D
@onready var _audio_player: AudioStreamPlayer = %AudioStreamPlayer
# @onready var _collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	set_dna()


func _physics_process(_delta: float) -> void:
	move_and_slide()


func set_color(color: Color) -> void:
	_sprite.modulate = color
	_sprite.material.set_shader_parameter("modulate_color", color)


func set_size(new_scale: float) -> void:
	_sprite.scale = Vector2(new_scale, new_scale)


func interact(caller: Node) -> void:
	_audio_player.play()
	state_machine.interact(caller)


func set_dna(new_dna: DNA = null) -> void:
	if new_dna:
		dna = new_dna

	if dna == null:
		dna = DNA.new()

		if _coat_alleles != Vector2i(-1, -1):
			dna.get_gene(DNA.GeneType.COAT).set_value(_coat_alleles.x, _coat_alleles.y)

	set_color.call_deferred(dna.get_gene(DNA.GeneType.COAT).get_color())
	set_size.call_deferred(dna.get_gene(DNA.GeneType.SIZE).get_scale())


static func create(new_dna: DNA) -> Goat:
	var new_goat = GOAT_SCENE.instantiate()
	new_goat.set_dna(new_dna)
	return new_goat


func hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", true)


func _on_hit_box_area_entered(area:Area2D) -> void:
	if state_machine.state.has_method("on_hit_box_area_entered"):
		state_machine.state.on_hit_box_area_entered(area)


func stop_hover() -> void:
	%DirectionalSprite2D.material.set_shader_parameter("enabled", false)
