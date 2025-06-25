class_name GoatWanderState
extends GoatState

var timer: Timer


func _ready() -> void:
	super._ready()
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)


func enter(_previous_state_path: String, _data := {}) -> void:
	goat.velocity = Vector2.from_angle(randf_range(0, TAU)) * goat.speed
	# goat.animation_player.play("run")

	timer.wait_time = randf_range(1, 3)
	timer.start()


func _on_timer_timeout() -> void:
	finished.emit(IDLE)


func exit() -> void:
	timer.stop()
