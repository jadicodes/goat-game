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
	if hit.size() > 0:
		for body in hit:
			if body.has_method("interact"):
				if body is Goat:
					_following_goats.append(body)
					print("Following goats: ", _following_goats)
				print(self.name, " interacting with ", body.name)
				body.interact(self)
				return

	print("No interactable objects nearby.")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		attempt_interact()


func get_goats() -> Array[Goat]:
	return _following_goats
