extends Node


@onready var run_timer: Timer = $RunTimer
@onready var money_spawner: Node2D = $"../MoneySpawner"
@onready var player_pouch: Area2D = $"../PlayerPouch"
@onready var piggy: StaticBody2D = $"../Piggy"

@export var run_time: float = 20.0
var current_run: int = 1
var player_money: int = 0
var run_failed: bool = false


func _ready() -> void:
	Signalbus.run_ended.connect(end_run)
	call_deferred("start_run")


func _on_run_timer_timeout() -> void:
	money_spawner.stop_spawns()


func end_run() -> void:
	print_stack()
	player_money = player_pouch.money_count
	print("Total spawned: ", money_spawner.valuespawned)
	print("Player money: ", player_money)
	print("Pig money: ", piggy.pig_money_count)
	var total_spawned: float = float(money_spawner.valuespawned)
	var player_count: float = float(player_money)
	var pig_count: float = float(piggy.pig_money_count)
	var pig_percentage: float =  pig_count / total_spawned
	var player_percentage: float = player_count / total_spawned
	if pig_percentage > player_percentage:
		run_failed = true
		Signalbus.run_failed.emit()
	else:
		current_run += 1
		Signalbus.run_succeed.emit()


func reset_run() -> void:
	money_spawner.valuespawned = 0
	player_pouch.money_count = 0
	piggy.pig_money_count = 0
	start_run()


func start_run() -> void:
	money_spawner.start_spawns()
	run_timer.start(run_time)
