extends Node


@onready var run_timer: Timer = $RunTimer
@onready var money_spawner: Node2D = $"../MoneySpawner"
@onready var player_pouch: Area2D = $"../PlayerPouch"
@onready var piggy: StaticBody2D = $"../Piggy"


var player_money: int = 0


func _ready() -> void:
	Signalbus.run_ended.connect(end_run)
	call_deferred("start_run")


func _on_run_timer_timeout() -> void:
	money_spawner.stop_spawns()


func end_run() -> void:
	player_money = player_pouch.money_count
	print("Total spawned: ", money_spawner.valuespawned)
	print("Player money: ", player_money)
	print("Pig money: ", piggy.pig_money_count)
	money_spawner.valuespawned = 0
	player_pouch.money_count = 0
	piggy.pig_money_count = 0


func start_run() -> void:
	money_spawner.start_spawns()
	run_timer.start(30.0)
