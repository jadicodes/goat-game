class_name ShopperState
extends State

const ENTER = "ShopperEnterState"
const ARRIVE_AT_FENCE = "ShopperArriveAtFenceState"
const GIVE_ORDER = "ShopperGiveOrderState"
const WAIT_FOR_ORDER = "ShopperWaitForOrderState"
const ORDER_SUCCESS = "ShopperOrderSuccessState"
const ORDER_FAILURE = "ShopperOrderFailureState"
const LEAVE = "ShopperLeaveState"

var shopper: Shopper


func _ready() -> void:
	await owner.ready
	shopper = owner as Shopper
	assert(
		shopper != null,
		"The ShopperState state type must be used only in the shopper scene. It needs the owner to be a Shopper node."
	)
