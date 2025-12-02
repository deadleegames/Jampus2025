extends Node3D

class_name Lantern

@export var collison : CollisionShape3D
@export var respawn_timer : Timer
@export var lantern_mesh : MeshInstance3D

@export var spot_light : SpotLight3D
@export var perception_collision : CollisionShape3D

func _ready() -> void:
	respawn_timer.wait_time = 3
	respawn_timer.connect("timeout", Callable(self, "on_respawn_timer_timeout"))

func break_lantern():
	spot_light.visible = false
	perception_collision.set_deferred("disabled", true)
	collison.set_deferred("disabled", true)
	lantern_mesh.visible = false
	respawn_timer.start()

func on_respawn_timer_timeout():
	respawn_timer.stop()
	spot_light.visible = true
	perception_collision.set_deferred("disabled", false)
	collison.set_deferred("disabled", false)
	lantern_mesh.visible = true
