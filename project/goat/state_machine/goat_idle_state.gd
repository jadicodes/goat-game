class_name GoatIdleState
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
	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("idle")
	_timer.wait_time = randf_range(2, 10)
	_timer.start()


func update(_delta: float) -> void:
	goat.velocity = Vector2.ZERO


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	finished.emit(FOLLOW, {"target": caller})


func _on_timer_timeout() -> void:
	finished.emit(WANDER)


func exit() -> void:
	_timer.stop()
