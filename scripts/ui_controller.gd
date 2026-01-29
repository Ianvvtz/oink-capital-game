extends CanvasLayer


@onready var player_percentage: Label = $Control/HBoxContainer/PlayerPercentage
@onready var pig_percentage: Label = $Control/HBoxContainer/PigPercentage
@onready var player_bar: ProgressBar = $Control/HBoxContainer/Control/PlayerBar
@onready var pig_bar: ProgressBar = $Control/HBoxContainer/Control/PigBar
@onready var player_pouch: Area2D = $"../PlayerPouch"
@onready var piggy: StaticBody2D = $"../Piggy"
@onready var money_spawner: Node2D = $"../MoneySpawner"

var player_percent: float
var pig_percent: float


func _ready() -> void:
	player_percentage.visible = false
	pig_percentage.visible = false
	player_bar.visible = false
	pig_bar.visible = false
	Signalbus.money_spawned.connect(calculate_percentages)
	Signalbus.pig_received_money.connect(calculate_percentages)
	Signalbus.player_received_money.connect(calculate_percentages)


func calculate_percentages() -> void:
	if pig_bar.visible == false:
		player_percentage.visible = true
		pig_percentage.visible = true
		player_bar.visible = true
		pig_bar.visible = true
	var total_spawned = float(money_spawner.valuespawned)
	var pig_money_count = float(piggy.pig_money_count)
	var player_money_count = float(player_pouch.money_count)
	player_percent = player_money_count / total_spawned
	pig_percent = pig_money_count / total_spawned
	set_labels()


func set_labels() -> void:
	player_percentage.text = "Community: %.1f%%" % (player_percent * 100)
	pig_percentage.text = "Pig: %.1f%%" % (pig_percent * 100)
	player_bar.value = player_percent
	pig_bar.value = pig_percent
