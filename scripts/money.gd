extends RigidBody2D


@onready var particles: GPUParticles2D = $GPUParticles2D


@export var value: int = 1
var pig: Node2D
var in_hand: bool = false
var hand_offset: Vector2
var grab_transition: float


func _ready() -> void:
	pig = get_tree().get_first_node_in_group("pig")
	var pig_area = pig.get_child(0)
	var dir = global_position - pig.global_position
	var distance = dir.length()
	if distance == 0:
		distance = 1
	var orbit_speed = sqrt(pig_area.gravity / distance) * randf_range(100.0, 300.0)
	if randi() % 2 == 0:
		orbit_speed *= -1
	var tangential = dir.rotated(PI / 2).normalized() * orbit_speed
	linear_velocity = tangential
	angular_velocity = randf_range(-3, 3)


func grab() -> void:
	in_hand = true
	grab_transition = 0.0
	set_deferred("FreezeMode", RigidBody2D.FREEZE_MODE_KINEMATIC)
	var angle = randf() * TAU
	var distance = randf_range(10, 30)
	hand_offset = Vector2(cos(angle), sin(angle)) * distance


func _physics_process(delta: float) -> void:
	if in_hand:
		grab_transition = min(grab_transition + delta * 3.0, 3.0)
		var target = get_global_mouse_position() + hand_offset
		var lerp_speed = lerp(0.1, 0.4, grab_transition)
		global_position = lerp(global_position, target, lerp_speed)
