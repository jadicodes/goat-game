class_name Farmer
extends CharacterBody2D

@export var speed = 300


func _physics_process(_delta: float) -> void:
    var dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")

    velocity = dir

    if dir != Vector2.ZERO:
        velocity = velocity.normalized() * speed

    move_and_slide()
