extends Node2D

@export var shopper_scene: PackedScene

@onready var barn: Barn = %Barn


func _ready() -> void:
	_create_shopper.call_deferred()


func _create_shopper() -> void:
	var shopper = shopper_scene.instantiate()
	var shopper_spawn_location = %ShopperSpawnLocation
	shopper_spawn_location.progress_ratio = randf()

	shopper.global_position = shopper_spawn_location.global_position
	get_tree().get_root().add_child(shopper)
	barn.day_advanced.connect(shopper._on_day_advanced)
	print("shopper created")


func _on_barn_day_advanced() -> void:
	_create_shopper()
