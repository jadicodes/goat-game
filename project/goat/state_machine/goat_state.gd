class_name GoatState
extends State

const IDLE = "GoatIdleState"
const WANDER = "GoatWanderState"
const FOLLOW = "GoatFollowState"
const HIDDEN = "GoatHiddenState"

var goat: Goat


func _ready() -> void:
	await owner.ready
	goat = owner as Goat
	assert(
		goat != null,
		"The GoatState state type must be used only in the goat scene. It needs the owner to be a Goat node."
	)
