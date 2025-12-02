extends CharacterBody3D

const SPEED = 7.0
const JUMP_VELOCITY = 4.5
@onready var action_component: Node = $ActionComponent

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):		
		action_component.start_action_by_name("Projectile_Attack_Action")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

@export var mouse_sensitivity : float = 1

# Use these to connect to the subcomponents of the look control system.
# Camera < HeadPitch (Marker3D) < HeadYaw (Marker3D) < CharacterBody3D
@export var playerCollider : CollisionShape3D
@export var headPitch : Marker3D
@export var camera : Camera3D

# These are generally safe to leave as defaults
@export var max_pitch : float = (PI/2) - 0.01
@export var min_pitch : float = -(PI/2) + 0.01

#This can be tacked on to any existing Unhandled_Input function in place of standard mouselook
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouseAim(event)
	elif event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func mouseAim(event : InputEventMouseMotion) -> void:
	#mouseEventCount += 1
	#var viewport_transform: Transform2D = get_tree().root.get_final_transform()
	#var motion: Vector2 = event.xformed_by(viewport_transform).relative
	var motion = event.relative
	var rads_per_unit: float = 0.001
	
	motion *= mouse_sensitivity
	motion *= rads_per_unit
	
	add_look_yaw(motion.x)
	add_look_pitch(motion.y)
	clamp_pitch()

func add_look_yaw(xvalue) -> void:
	if is_zero_approx(xvalue):
		return
	rotate_y(-xvalue)

func add_look_pitch(yvalue) -> void:
	if is_zero_approx(yvalue):
		return
	headPitch.rotate_x(-yvalue)
	pass
	
func clamp_pitch()->void:
	if headPitch.rotation.x > min_pitch and headPitch.rotation.x < max_pitch:
		return
	
	headPitch.rotation.x = clamp(headPitch.rotation.x, min_pitch, max_pitch)
	headPitch.orthonormalize()
