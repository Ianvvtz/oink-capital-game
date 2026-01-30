extends Sprite2D

@export var rotate_speed := 0.025

func _process(delta):
	rotation += rotate_speed * delta
