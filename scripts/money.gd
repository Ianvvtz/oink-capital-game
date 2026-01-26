extends RigidBody2D

#@export var pig_gravity_strength: float = 5
#@export var pig_pull_strength: float = 2000.0
var pig: Node2D
#
#func _ready() -> void:
	
#
#
#func _physics_process(_delta: float) -> void:
	#if pig == null:
		#return
	#
	#var direction = pig.global_position - global_position
	#var normalized_gravity = direction.normalized()
	#linear_velocity = normalized_gravity * pig_gravity_strength
	#var money_velocity = normalized_gravity.rotated(PI / 2)
	#constant_force = money_velocity * pig_pull_strength
	#
	
func _ready() -> void:
	pig = get_tree().get_first_node_in_group("pig")
	var pig_area = pig.get_child(0)
	var dir = global_position - pig.global_position
	var distance = dir.length()
	if distance == 0:
		distance = 1
	var orbit_speed = sqrt(pig_area.gravity / distance) * randf_range(200.0, 500.0)
	if randi() % 2 == 0:
		orbit_speed *= -1
	var tangential = dir.rotated(PI / 2).normalized() * orbit_speed
	linear_velocity = tangential
