class_name ShopperOrderSuccessState
extends ShopperState


func enter(_previous_state_path: String, _data := {}) -> void:
	shopper.velocity = Vector2.ZERO
	# shopper.animation_player.play("idle")

	%SpeechBubble.display_text(tr("SHOPPER_HAPPY"))
	%DaysLeftLabel.text = ""
	await get_tree().create_timer(1.0).timeout

	finished.emit(LEAVE)
