class_name GoatFollowState
extends GoatState


const FOLLOW_DISTANCE := 256.0

var target: Node2D

func enter(_previous_state_path: String, _data := {}) -> void:
	if _data.has("target"):
		target = _data.target
	else:
		printerr("No target provided to GoatFollowState.")
		finished.emit(IDLE)
		return

	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("follow")


func update(_delta: float) -> void:
	goat.velocity = (target.position - goat.position).normalized() * goat.speed

	if goat.position.distance_to(target.position) > FOLLOW_DISTANCE:
		return

	goat.velocity = Vector2.ZERO

	if target is BarnDoor:
		finished.emit(ENTER_DOOR, {
			"door": target
		})

