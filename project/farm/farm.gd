extends Node2D

@export var shopper_scene: PackedScene


func _create_shopper():
	var shopper = shopper_scene.instantiate()
	var shopper_spawn_location = %ShopperSpawnLocation
	shopper_spawn_location.progress_ratio = randf()

	shopper.global_position = shopper_spawn_location.global_position
	get_tree().get_root().add_child(shopper)
	print("shopper created")


func _on_barn_day_advanced() -> void:
	_create_shopper()
