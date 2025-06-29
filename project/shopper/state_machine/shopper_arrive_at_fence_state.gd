class_name ShopperArriveAtFenceState
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
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	timer.start(5)


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	timer.stop()
	finished.emit(GIVE_ORDER)


func _on_timer_timeout() -> void:
	finished.emit(ENTER)
