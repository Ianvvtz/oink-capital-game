extends StaticBody2D


@onready var pig_grab_area: Area2D = $PigGrabArea
@onready var area_shape: CollisionShape2D = $PigGrabArea/CollisionShape2D
@onready var pig_sprite: Sprite2D = $Sprite2D
@onready var pig_area_background: MeshInstance2D = $PigGrabArea/MeshInstance2D

var base_size = 100.0
var pig_money_count: int = 0


func add_money(amount) -> void:
	pig_money_count += amount
	
	var base_radius = 90.0
	var grow_amount = 1.0 + (pig_money_count + 1) * 0.002
	area_shape.shape.radius = base_radius * grow_amount
	var base_area_scale = Vector2(180.0, 180.0)
	pig_area_background.scale = base_area_scale * grow_amount
	
	var base_scale = Vector2(0.4, 0.3)
	var scale_factor = 1.0 + (pig_money_count + 1) * 0.002
	pig_sprite.scale = base_scale * scale_factor


func _on_pig_grab_area_body_entered(body: Node2D) -> void:
	var value = body.value
	add_money(value)
	Signalbus.pig_received_money.emit()
	body.queue_free()
