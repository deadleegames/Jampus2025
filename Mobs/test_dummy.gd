extends CharacterBody3D

const SPEED: float = 5.0
const rotation_speed : float = TAU * 2

var PatrolPoints : Array[Marker3D]

var CurrentPatrolPoint : Marker3D
var PatrolPointIterator : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var patrol_node = get_node("PatrolPoints")
	if patrol_node == null:
		return
		
	var points = patrol_node.get_children()
	
	if	points != null:
		for point in points:
			print('point ' + point.name)
			PatrolPoints.append(point)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if PatrolPoints.size() > 0 && $PatrolTimer.is_stopped():
		try_set_patrol_point()
		if	CurrentPatrolPoint != null:	
			var desiredLoc = CurrentPatrolPoint.global_position

			var direction = global_position.direction_to(desiredLoc)
			
			var theta = wrapf(atan2(-direction.x, -direction.z) - rotation.y + PI/2, -PI, PI)
			rotation.y += clamp(rotation_speed * delta, 0, abs(theta)) * sign(theta)

			global_position = global_position.move_toward(desiredLoc, SPEED * delta)
			move_and_slide()

func try_set_patrol_point():
	if PatrolPoints.size() <= 0 or !$PatrolTimer.is_stopped():
		return
			
	if	CurrentPatrolPoint == null:
		CurrentPatrolPoint = PatrolPoints[0]
	else:
		if compare_x_z(global_position, CurrentPatrolPoint.global_position, .05):
			PatrolPointIterator += 1
			if PatrolPointIterator > PatrolPoints.size() -1:
				PatrolPointIterator = 0;
			CurrentPatrolPoint = PatrolPoints[PatrolPointIterator]
			$PatrolTimer.start()

func compare_x_z(v1 : Vector3, v2 : Vector3, acceptable_radius : float) -> bool:
	if v1.x >= (v2.x - acceptable_radius) and v1.x <= (v2.x + acceptable_radius):
		if v1.z >= (v2.z - acceptable_radius) and v1.z <= (v2.z + acceptable_radius):
			return true
	return false

func _on_patrol_timer_timeout():
	$PatrolTimer.stop()
