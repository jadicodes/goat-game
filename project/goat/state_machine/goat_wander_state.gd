class_name GoatWanderState
extends GoatState

var _timer: Timer


func _ready() -> void:
	super._ready()
	_timer = Timer.new()
	_timer.autostart = false
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func enter(_previous_state_path: String, _data := {}) -> void:
	var overlap: Array[Node2D] = []

	for area in goat.hit_box.get_overlapping_areas():
		overlap.append(area)

	for body in goat.hit_box.get_overlapping_bodies():
		if body == goat:
			continue
		overlap.append(body)

	if overlap.is_empty():
		goat.velocity = Vector2.from_angle(randf_range(0, TAU)) * goat.speed
	else:
		_move_away(overlap)
	# goat.animation_player.play("run")

	_timer.wait_time = randf_range(1, 3)
	_timer.start()


func _move_away(nodes: Array[Node2D]) -> void:
	var average_position := Vector2.ZERO

	for node in nodes:
		average_position += node.global_position

	average_position /= nodes.size()

	goat.velocity = (goat.global_position - average_position).normalized() * goat.speed

	# Add some randomness to the direction
	goat.velocity = goat.velocity.rotated(randf_range(-PI / 4, PI / 4))


func _on_timer_timeout() -> void:
	finished.emit(IDLE)


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	finished.emit(FOLLOW, {"target": caller})


func exit() -> void:
	_timer.stop()
