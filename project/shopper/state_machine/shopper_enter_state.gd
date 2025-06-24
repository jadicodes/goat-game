class_name ShopperEnterState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.from_angle(randf_range(0, TAU)) * shopper.speed
	# shopper.animation_player.play("run")
