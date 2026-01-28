extends Area2D


@onready var money_counter: Label = $MoneyCounter


@export var max_money_hold: int = 2

var money_held: int = 0


func _ready() -> void:
	toggle_gravity(false)


func toggle_gravity(tf: bool) -> void:
	if tf == true:
		monitoring = true
		set_gravity_space_override_mode(SPACE_OVERRIDE_COMBINE_REPLACE)
	elif tf == false:
		monitoring = false
		set_gravity_space_override_mode(SPACE_OVERRIDE_DISABLED)


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
		set_text(true)
	else:
		# Add audio and visual feedback for hand being full.
		pass


func _on_body_exited(body: Node2D) -> void:
	if body.in_hand:
		money_held -= 1
		body.in_hand = false
		if money_held == 0:
			set_text(false)


func set_text(tf: bool) -> void:
	money_counter.visible = tf
	money_counter.text = str(money_held, "/", max_money_hold)
