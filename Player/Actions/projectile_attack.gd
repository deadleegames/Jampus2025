extends Action

@export var ProjectileSpawnMarker : Marker3D
@export var SPEED : float = 50
@export var EndPos : Vector3

@onready var projectile: PackedScene = preload("res://Player/Actions/projectile.tscn")

const DistanceTillDespawn : float = 50


func _init() -> void:
	ActionName = "Projectile_Attack_Action"

func fire_projectile():
	var proj = projectile.instantiate()
	proj.global_position = ProjectileSpawnMarker.global_position
	var level = get_tree().get_first_node_in_group('level')
	level.add_child(proj)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction
