extends Area2D


func toggle_gravity(tf: bool) -> void:
	if tf == true:
		set_gravity_space_override_mode(SPACE_OVERRIDE_REPLACE)
	elif tf == false:
		set_gravity_space_override_mode(SPACE_OVERRIDE_DISABLED)

func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		toggle_gravity(true)
	if event.is_action_released("left_click"):
		toggle_gravity(false)
