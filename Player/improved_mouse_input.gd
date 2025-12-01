extends CharacterBody3D

#class_name Player_Character

@export var mouse_sensitivity : float = 1

# Use these to connect to the subcomponents of the look control system.
# Camera < HeadPitch (Marker3D) < HeadYaw (Marker3D) < CharacterBody3D
@export var playerCollider : CollisionShape3D
@export var headYaw : Marker3D
@export var headPitch : Marker3D
@export var camera : Camera3D

# These are generally safe to leave as defaults
@export var max_pitch : float = (PI/2) - 0.01
@export var min_pitch : float = -(PI/2) + 0.01

#This can be tacked on to any existing Unhandled_Input function in place of standard mouselook
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
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
	headYaw.rotate_y(-xvalue)

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
