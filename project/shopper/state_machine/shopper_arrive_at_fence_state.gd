class_name ShopperArriveAtFenceState
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
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	_timer.start(5)


func interact(caller: Node) -> void:
	if not caller is Farmer:
		return

	_timer.stop()
	finished.emit(GIVE_ORDER)


func _on_timer_timeout() -> void:
	finished.emit(ENTER)
