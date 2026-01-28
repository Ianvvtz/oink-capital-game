extends StaticBody2D


var pig_money_count: int = 0


func add_money(amount) -> void:
	pig_money_count += amount
	print(pig_money_count)


func _on_pig_grab_area_body_entered(body: Node2D) -> void:
	var value = body.value
	add_money(value)
	body.queue_free()
