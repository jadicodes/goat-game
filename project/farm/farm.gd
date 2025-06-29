extends Node2D

const SHOPPER_SCENE: PackedScene = preload("res://shopper/shopper.tscn")

@onready var _barn: Barn = %Barn


func _ready() -> void:
	_create_shopper.call_deferred()


func _create_shopper() -> void:
	var shopper = SHOPPER_SCENE.instantiate()
	var shopper_spawn_location = %ShopperSpawnLocation
	shopper_spawn_location.progress_ratio = randf()

	shopper.global_position = shopper_spawn_location.global_position
	get_tree().get_root().add_child(shopper)
	_barn.day_advanced.connect(shopper._on_day_advanced)
	print("shopper created")


func _on_barn_day_advanced() -> void:
	_create_shopper()
