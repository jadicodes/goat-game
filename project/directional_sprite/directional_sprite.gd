# @tool
class_name DirectionalSprite2D
extends AnimatedSprite2D

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
	if _character.velocity == Vector2.ZERO:
		play("idle_front" if _is_front else "idle_back")
	else:
		play("walk_front" if _is_front else "walk_back")

	flip_h = not _is_left
