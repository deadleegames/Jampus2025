extends Action

@export var ProjectileSpawnMarker : Marker3D
@export var SPEED : float = 50
@export var Ray : RayCast3D

@onready var projectile: PackedScene = preload("res://Player/Actions/projectile.tscn")

const DistanceTillDespawn : float = 50


func _init() -> void:
	ActionName = "Projectile_Attack_Action"

func fire_projectile() -> void:
	var proj = projectile.instantiate()
	proj.setup(ProjectileSpawnMarker.global_position,
		Ray.target_position, SPEED)
	proj.global_position = ProjectileSpawnMarker.global_position
	var level = get_tree().get_first_node_in_group('level')
	level.add_child(proj)

func start_action() -> void:
	super.start_action()
	fire_projectile()
