extends Area2D

var money_count: int = 0


func add_money(amount) -> void:
	money_count += amount
	print(money_count)


func _on_body_entered(body: Node2D) -> void:
	var value = body.value
	add_money(value)
	body.queue_free()
