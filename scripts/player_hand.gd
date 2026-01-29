extends Area2D


@onready var money_counter: Label = $MoneyCounter
@onready var amount_counter: Label = $AmountCounter


@export var max_money_hold: int = 2

var amount_held: int = 0
var money_held: int = 0


func _ready() -> void:
	toggle_gravity(false)


func toggle_gravity(tf: bool) -> void:
	if tf == true:
		monitoring = true
	elif tf == false:
		monitoring = false


func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		toggle_gravity(true)
	if event.is_action_released("left_click"):
		toggle_gravity(false)


func _on_body_entered(body: Node2D) -> void:
	if money_held < max_money_hold:
		money_held += 1
		print(money_held, "/", max_money_hold)
		body.grab()
		body.particles.emitting = false
		amount_held += body.value
		set_text(true)
	else:
		# Add audio and visual feedback for hand being full.
		pass


func _on_body_exited(body: Node2D) -> void:
	if body.in_hand:
		money_held -= 1
		amount_held -= body.value
		body.in_hand = false
		set_deferred("freeze", false)
		body.particles.emitting = true
		if money_held == 0:
			set_text(false)


func set_text(tf: bool) -> void:
	money_counter.visible = tf
	money_counter.text = str(money_held, "/", max_money_hold)
	amount_counter.visible = tf
	amount_counter.text = str("$", amount_held)
