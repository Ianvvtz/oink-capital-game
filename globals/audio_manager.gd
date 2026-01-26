extends Node

@onready var click: AudioStreamPlayer = $Click
@onready var background_music: AudioStreamPlayer = $BackgroundMusic


func play_background_music():
	background_music.play()


func play_click():
	click.play()
