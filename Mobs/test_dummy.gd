extends CharacterBody3D

class_name Enemy

@export var SPEED: float = 5.0
const rotation_speed : float = TAU

var PatrolPoints : Array[Marker3D]
var CurrentPatrolPoint : Marker3D
var PatrolPointIterator : int = 0

var currentState : MyEnums.AIState
var playerRef: CharacterBody3D

signal on_state_changed(new_state: MyEnums.AIState)

@onready var perception_component: Area3D = $PerceptionComponent
@export var capture_area: Area3D

func _ready():
	currentState = MyEnums.AIState.IDLE

	perception_component.player_spotted.connect(on_player_spotted)

	var patrol_node = get_node("PatrolPoints")
	if patrol_node == null:
		return
		
	var points = patrol_node.get_children()
	
	if	points != null:
		for point in points:
			print('point ' + point.name)
			PatrolPoints.append(point)

	currentState = MyEnums.AIState.PATROL


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	match currentState:
		MyEnums.AIState.PATROL:
			do_patrol(delta)

		MyEnums.AIState.CHASE:
			do_chase(delta)

	move_and_slide()


func do_chase(delta: float):
	var capture_collision = capture_area.get_child(0)
	capture_collision.set_deferred("disabled", false)
	global_position = global_position.move_toward(playerRef.global_position, SPEED * delta)
	calculate_lookat(playerRef.global_position, delta)

func do_patrol(delta: float):
	if PatrolPoints.size() > 0 && $PatrolTimer.is_stopped():
		try_set_patrol_point()
		if	CurrentPatrolPoint != null:	
			var desiredLoc = CurrentPatrolPoint.global_position

			calculate_lookat(desiredLoc, delta)

			global_position = global_position.move_toward(desiredLoc, SPEED * delta)
			

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

func calculate_lookat(lookAtLoc: Vector3, delta: float):
	var direction = global_position.direction_to(lookAtLoc)
			
	var theta = wrapf(atan2(-direction.x, -direction.z) - rotation.y + PI/2, -PI, PI)
	rotation.y += clamp(rotation_speed * delta, 0, abs(theta)) * sign(theta)

func on_player_spotted(instigator: CharacterBody3D):
	currentState = MyEnums.AIState.CHASE
	instigator.currentState = MyEnums.PlayerState.IN_CHASE
	on_state_changed.emit(currentState)
	playerRef = instigator

func _on_patrol_timer_timeout():
	$PatrolTimer.stop()

func _on_capture_area_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		var main = get_tree().get_first_node_in_group('main')
		main.game_over()
