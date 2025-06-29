class_name ShopperEnterState
extends ShopperState

var _timer: Timer


func _ready() -> void:
	super._ready()
	_timer = Timer.new()
	_timer.autostart = false
	_timer.one_shot = true
	_timer.timeout.connect(_on_timer_timeout)
	add_child(_timer)


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = (
		((get_viewport().get_visible_rect().size / 2.0) - shopper.global_position).normalized() * shopper.speed
	)

	_timer.start(5)
	# shopper.animation_player.play("run")


func on_collision(_collision: KinematicCollision2D) -> void:
	_timer.stop()
	finished.emit(ARRIVE_AT_FENCE)


func _on_timer_timeout() -> void:
	finished.emit(ARRIVE_AT_FENCE)
