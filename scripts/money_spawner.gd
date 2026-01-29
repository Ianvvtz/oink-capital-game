extends Node2D

@onready var session_manager: Node = $"../SessionManager"
@onready var timer: Timer = $Timer
@onready var money: Node2D = $Money


@export var coin_one_scene: PackedScene
@export var coin_five_scene: PackedScene
@export var bill_ten_scene: PackedScene
@export var bill_fifty_scene: PackedScene
@export var bar_hundred_scene: PackedScene
@export var time_between_spawns: float = 0.5

var valuespawned: int = 0


func _ready() -> void:
	money.child_exiting_tree.connect(_on_money_removed)


func get_money_scene() -> PackedScene:
	var run = session_manager.current_run
	var rand = randf() * 100
	
	if run <= 3:
		if rand < 80:
			return coin_one_scene
		else:
			return coin_five_scene

	elif run <= 6:
		if rand < 60:
			return coin_one_scene
		else:
			return coin_five_scene

	elif run <= 10:
		if rand < 50:
			return coin_one_scene
		elif rand < 85:
			return coin_five_scene
		else:
			return bill_ten_scene

	elif run <= 15:
		if rand < 30:
			return coin_one_scene
		elif rand < 70:
			return coin_five_scene
		elif rand < 95:
			return bill_ten_scene
		else:
			return bill_fifty_scene

	else:
		if rand < 20:
			return coin_one_scene
		elif rand < 50:
			return coin_five_scene
		elif rand < 80:
			return bill_ten_scene
		elif rand < 95:
			return bill_fifty_scene
		else:
			return bar_hundred_scene


func spawn_money() -> void:
	var new_money = get_money_scene().instantiate()
	var spawn_location = global_position
	money.call_deferred("add_child", new_money)
	valuespawned += new_money.value
	new_money.call_deferred("set_global_position", spawn_location)
	Signalbus.money_spawned.emit()


func _on_money_removed(_child) -> void:
	await get_tree().process_frame
	if money.get_children().size() == 0:
		print("Run over")
		Signalbus.run_ended.emit()


func stop_spawns() -> void:
	timer.stop()


func start_spawns() -> void:
	timer.start(time_between_spawns)
