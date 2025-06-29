class_name GoatFollowState
extends GoatState

const FOLLOW_DISTANCE := 128.0

var _target: Node2D


func enter(_previous_state_path: String, _data := {}) -> void:
	if _data.has("target"):
		_target = _data.target
	else:
		printerr("No target provided to GoatFollowState.")
		finished.emit(IDLE)
		return

	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("follow")

	if not _target.has_method("add_goat"):
		return

	var overlap := goat.hit_box.get_overlapping_areas()

	if overlap.is_empty():
		return

	for area in overlap:
		if area == _target:
			_target.add_goat.call_deferred(goat)
			return


func update(_delta: float) -> void:
	if goat.position.distance_to(_target.global_position) <= FOLLOW_DISTANCE:
		goat.velocity = Vector2.ZERO
		return

	goat.velocity = (_target.global_position - goat.global_position).normalized() * goat.speed


func on_hit_box_area_entered(area: Area2D) -> void:
	if area != _target:
		return

	if _target.has_method("add_goat"):
		_target.add_goat(goat)
