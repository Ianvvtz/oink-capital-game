extends StaticBody2D


@onready var pig_grab_area: Area2D = $PigGrabArea
@onready var area_shape: CollisionShape2D = $PigGrabArea/CollisionShape2D

var base_size = 100.0
var pig_money_count: int = 0


func add_money(amount) -> void:
	pig_money_count += amount
	area_shape.shape.radius += amount
	print(pig_money_count)


func _on_pig_grab_area_body_entered(body: Node2D) -> void:
	var value = body.value
	add_money(value)
	body.queue_free()
