extends Control


func _on_play_button_pressed() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(%Signature, "value", 100, 1)
	tween.tween_callback(get_tree().change_scene_to_file.bind("res://farm/farm.tscn"))
