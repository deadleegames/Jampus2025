extends RigidBody3D

class_name Projectile

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
	velocity += direction * proj_speed * delta
	look_at(end_pos, Vector3.UP)

	traveled_distance += proj_speed * delta
	if traveled_distance >= max_distance:
		queue_free()

	move_and_collide(velocity)

func _on_timer_timeout() -> void:
	queue_free()

func queue_free_timer():
	$Timer.start()
	$MeshInstance3D.visible = false
	$CollisionShape3D.set_deferred("disabled", true)