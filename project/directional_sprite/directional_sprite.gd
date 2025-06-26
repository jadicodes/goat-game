@tool
class_name DirectionalSprite2D
extends Sprite2D

@export var _sprite_front: Texture2D
@export var _sprite_back: Texture2D
@export var _front_flipped: bool = false
@export var _back_flipped: bool = false

var _character: CharacterBody2D

var _is_left := true
var _is_front := true


func _ready() -> void:
	assert(owner is CharacterBody2D, "DirectionalSprite must be owned by a CharacterBody2D")

	_character = owner as CharacterBody2D

	_update_sprite()


func _process(_delta: float) -> void:
	_update_direction()
	_update_sprite()


func _update_direction() -> void:
	if _character.velocity.y > 0:
		_is_front = true
	elif _character.velocity.y < 0:
		_is_front = false

	if _character.velocity.x > 0:
		_is_left = false
	elif _character.velocity.x < 0:
		_is_left = true


func _update_sprite() -> void:
	if _is_front:
		texture = _sprite_front
		flip_h = _front_flipped if _is_left else not _front_flipped
	else:
		texture = _sprite_back
		flip_h = _back_flipped if _is_left else not _back_flipped
