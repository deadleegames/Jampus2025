extends CharacterBody3D

class_name Player

var currentState : MyEnums.PlayerState = MyEnums.PlayerState.DEFAULT

var bis_grappling : bool = false
var grapple_pos : Vector3

const SPEED = 7.0
const JUMP_VELOCITY = 4.5

@export var rope: MeshInstance3D

@onready var action_component: Node = $ActionComponent
@onready var hand_puppet = $Body/Head/Hand_Puppet
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var bprocess_input = true

func _ready():
	hand_puppet.yank_player.connect(on_animation_grapple_finished)

func on_animation_grapple_finished():
	action_component.start_action_by_name("Grapple_Action")
	bprocess_input = true

func _process(_delta: float) -> void:
	if bprocess_input:
		if Input.is_action_just_pressed("Shoot"):		
			action_component.start_action_by_name("Projectile_Attack_Action")
		if Input.is_action_just_pressed("Grapple"):
			hand_puppet.animation_player.play('Tool_Yank')
			audio_stream_player.play()
			bprocess_input = false
		if Input.is_action_just_pressed("Interact"):
			action_component.start_action_by_name("Interact_Action")
		

func _physics_process(delta):
	rope.visible = bis_grappling
	if bis_grappling:
		velocity = Vector3.ZERO
		var distance_vec = global_position - grapple_pos

		# var d = pow(distance_vec.x, 2) + pow(distance_vec.z, 2)
		# var distance = sqrt(d)
		# print('distance ' + str(distance))
		# rope.global_scale(Vector3(0, distance, 0))
		# print('rope scale ' + str(rope.global_basis.get_scale().y))
		#rope.stretch_between($Body/Head/Hand_Puppet/GrappleSpawn.global_position, grapple_pos)

		var additional_speed = abs(distance_vec.z) + abs(distance_vec.x)
		#tween_scale(rope, Vector3(0, distance, 0), .5)

		var direction = global_position.direction_to(grapple_pos)
		velocity = direction * SPEED * additional_speed

		if compare_x_z(global_position, grapple_pos, 2.0):
			bis_grappling = false
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if bprocess_input:
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
	if event is InputEventMouseMotion and bprocess_input:
		mouseAim(event)

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

func compare_x_z(v1 : Vector3, v2 : Vector3, acceptable_radius : float) -> bool:
	if v1.x >= (v2.x - acceptable_radius) and v1.x <= (v2.x + acceptable_radius):
		if v1.z >= (v2.z - acceptable_radius) and v1.z <= (v2.z + acceptable_radius):
			return true
	return false

func tween_scale(target, target_scale, duration):
	var tween = create_tween()
	tween.tween_property(target, "scale", target_scale, duration).set_trans(Tween.TRANS_ELASTIC)
