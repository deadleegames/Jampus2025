extends Area3D

@export var finish_marker: Marker3D
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
var fade
@onready var timer: Timer = $Timer
var bodyRef

func enable():
	collision_shape_3d.set_deferred('disabled', false)
	print('disabled ' + str(collision_shape_3d.disabled))

func _on_body_entered(body: Node3D) -> void:
	if !body.is_in_group('player'):
		return

	bodyRef = body
	var fade = get_tree().get_first_node_in_group('fade')
	fade.fade_to_black()
	timer.start()

func _on_timer_timeout() -> void:
	timer.stop()
	if finish_marker:		
		bodyRef.global_position = finish_marker.global_position
		bodyRef.global_rotation = finish_marker.global_rotation
