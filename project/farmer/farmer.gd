class_name Farmer
extends CharacterBody2D

@export var speed = 300

var _following_goats: Array[Goat] = []

@onready var hit_box: Area2D = $HitBox


func _physics_process(_delta: float) -> void:
	var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = dir

	if dir != Vector2.ZERO:
		velocity = velocity.normalized() * speed

	look_at(global_position + velocity)

	move_and_slide()


func attempt_interact() -> void:
	var hit = hit_box.get_overlapping_bodies()

	# TODO: Deal with multiple overlapping bodies
	if hit.is_empty():
		print("No interactable objects nearby.")
		return

	for body in hit:
		if not body.has_method("interact"):
			continue

		if body is Goat:
			if body in _following_goats:
				_following_goats.erase(body)
				body.state_machine.transition_to_next_state(GoatState.IDLE)
				return
			elif _following_goats.size() >= 2:
				print("Already two goats following, cannot follow more.")
				return
			else:
				_following_goats.append(body)
			print("Following goats: ", _following_goats)

		print(self.name, " interacting with ", body.name)
		body.interact(self)
		return



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		attempt_interact()


func get_goats() -> Array[Goat]:
	return _following_goats


func empty_goats() -> Array[Goat]:
	var following_goats := _following_goats.duplicate()
	_following_goats.clear()

	return following_goats
