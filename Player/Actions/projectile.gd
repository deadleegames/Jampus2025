extends RigidBody3D

var start_pos : Vector3
var end_pos : Vector3
var proj_speed : float

const max_distance : float = 100
var traveled_distance : float = 0

func setup(start: Vector3, end: Vector3, speed: float):
	start_pos = start
	end_pos = end
	proj_speed = speed

func _physics_process(delta: float) -> void:
	var direction = start_pos.direction_to(end_pos)
	var velocity = Vector3()
	velocity.x += direction.x * proj_speed * delta
	velocity.z += direction.z * proj_speed * delta

	#rotate()

	traveled_distance += velocity.x
	if traveled_distance >= max_distance:
		queue_free()

	move_and_collide(velocity)