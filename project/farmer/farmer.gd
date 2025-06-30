class_name Farmer
extends CharacterBody2D

@export var _speed = 300

var _following_goats: Array[Goat] = []
var _last_hovered: Node

@onready var _hit_cast: ShapeCast2D = %HitCast


func _process(_delta: float) -> void:
	if not _hit_cast.is_colliding():
		if _last_hovered:
			_last_hovered.stop_hover()
			_last_hovered = null
		return

	var collider = _hit_cast.get_collider(0)

	if not collider:
		return

	if collider != _last_hovered and _last_hovered:
		_last_hovered.stop_hover()

	if collider.has_method("hover"):
		collider.hover()
		_last_hovered = collider


func _physics_process(_delta: float) -> void:
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = dir

	if dir != Vector2.ZERO:
		velocity = velocity.normalized() * _speed

	_hit_cast.look_at(_hit_cast.global_position + dir)

	move_and_slide()


func attempt_interact() -> void:
	if not _hit_cast.is_colliding():
		return

	var hit := _hit_cast.get_collider(0) as Node

	if not hit.has_method("interact"):
		print("No interactable objects nearby.")
		return

	if hit is Goat:
		var goat: Goat = hit

		if goat in _following_goats:
			_following_goats.erase(goat)
			goat.state_machine.transition_to_next_state(GoatState.IDLE)
			return

		if _following_goats.size() >= 2:
			print("Already two goats following, cannot follow more.")
			return

		_following_goats.append(goat)
		print("Following goats: ", _following_goats)

	print(self.name, " interacting with ", hit.name)
	hit.interact(self)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		attempt_interact()


func get_goats() -> Array[Goat]:
	return _following_goats


func empty_goats() -> Array[Goat]:
	var following_goats := _following_goats.duplicate()
	_following_goats.clear()

	return following_goats
