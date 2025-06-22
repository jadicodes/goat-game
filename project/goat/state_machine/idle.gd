class_name GoatIdleState
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
	goat.velocity = Vector2.ZERO
	# goat.animation_player.play("idle")
	timer.wait_time = randf_range(2, 10)
	timer.start()


func _on_timer_timeout() -> void:
	finished.emit(WANDER)


func exit() -> void:
	timer.stop()
