extends Node2D


@onready var timer: Timer = $Timer
@onready var money: Node2D = $Money


@export var money_scene: PackedScene
@export var time_between_spawns: float = 0.5

var valuespawned: int = 0


func _ready() -> void:
	money.child_exiting_tree.connect(_on_money_removed)


func spawn_money() -> void:
	var new_money = money_scene.instantiate()
	var spawn_location = global_position
	money.call_deferred("add_child", new_money)
	valuespawned += new_money.value
	new_money.call_deferred("set_global_position", spawn_location)


func _on_money_removed(_child) -> void:
	await get_tree().process_frame
	if money.get_children().size() == 0:
		print("Run over")
		Signalbus.run_ended.emit()


func stop_spawns() -> void:
	timer.stop()


func start_spawns() -> void:
	timer.start(time_between_spawns)
