extends Node2D

@onready var timer: Timer = $Timer
@export var money_scene: PackedScene


func spawn_money() -> void:
	var new_money = money_scene.instantiate()
	var spawn_location = global_position
	call_deferred("add_child", new_money)
	new_money.call_deferred("set_global_position", spawn_location)
