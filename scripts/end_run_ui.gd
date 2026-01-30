extends Control

@onready var session_manager: Node = $"../../../SessionManager"

@onready var retry_button: Button = $MarginContainer/VBoxContainer/RetryButton
@onready var next_button: Button = $MarginContainer/VBoxContainer/NextButton
@onready var community_button: Button = $MarginContainer/VBoxContainer/CommunityButton
@onready var exit_button: Button = $MarginContainer/VBoxContainer/ExitButton


func _ready() -> void:
	set_run_ui(false)
	Signalbus.run_succeed.connect(set_succes_run)
	Signalbus.run_failed.connect(set_failed_run)


func set_run_ui(tf: bool) -> void:
	visible = tf
	retry_button.visible = false
	next_button.visible = false
	community_button.visible = false
	exit_button.visible = false


func set_succes_run() -> void:
	set_run_ui(true)
	next_button.visible = true
	community_button.visible = true
	exit_button.visible = true


func set_failed_run() -> void:
	set_run_ui(true)
	retry_button.visible = true
	exit_button.visible = true


func _on_retry_button_pressed() -> void:
	session_manager.current_run = 1
	session_manager.reset_run()
	set_run_ui(false)


func _on_next_button_pressed() -> void:
	session_manager.reset_run()
	set_run_ui(false)


func _on_community_button_pressed() -> void:
	set_run_ui(false)


func _on_exit_button_pressed() -> void:
	set_run_ui(false)
