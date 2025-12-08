extends Action

@export var projectileSpawnMarker : Marker3D
@export var SPEED : float = 50
@export var ray : RayCast3D

@onready var timer: Timer = $Timer

@onready var projectile: PackedScene = preload("res://Player/Actions/projectile.tscn")

const DistanceTillDespawn : float = 50


func _init() -> void:
	ActionName = "Projectile_Attack_Action"

func fire_projectile() -> void:
	if !timer.is_stopped():
		return

	timer.start()
	var proj = projectile.instantiate()
	
	var end_pos = ray.global_transform.origin + (ray.global_transform.basis * ray.target_position)

	if ray.is_colliding():
		end_pos = ray.get_collision_point()
	
	proj.setup(projectileSpawnMarker.global_position, end_pos, SPEED)	
	var level = get_tree().get_first_node_in_group('level')
	level.add_child(proj)
	proj.global_position = projectileSpawnMarker.global_position

func start_action() -> void:
	super.start_action()
	fire_projectile()


func _on_timer_timeout() -> void:
	timer.stop()
