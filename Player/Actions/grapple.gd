extends Action

const SPEED : float = 100.0

@export var ray: RayCast3D
@export var player: CharacterBody3D
#@export var rope: MeshInstance3D

var grapple_point: GrapplePoint

func _init() -> void:
	ActionName = "Grapple_Action"

func start_action() -> void:
	super.start_action()
	use_grapple()

func use_grapple():
	if ray.is_colliding():
		grapple_point = ray.get_collider() as GrapplePoint
		if grapple_point:
			player.bis_grappling = true
			player.grapple_pos = grapple_point.global_position
			print('grapple success')
		else:
			print('fail')
