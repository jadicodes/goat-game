extends PanelContainer


func display_text(new_text) -> void:
	%SpeechBubble.show()
	%Text.text = new_text
