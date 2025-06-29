class_name ShopperEnterState
extends ShopperState

var timer: Timer


func _ready() -> void:
	super._ready()
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		((get_viewport().size / 2.0) - shopper.global_position).normalized() * shopper.speed
	)

	timer.start(5)
	# shopper.animation_player.play("run")


func on_collision(_collision: KinematicCollision2D) -> void:
	timer.stop()
	finished.emit(ARRIVE_AT_FENCE)


func _on_timer_timeout() -> void:
	finished.emit(ARRIVE_AT_FENCE)
