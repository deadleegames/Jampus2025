extends Action

@export var interact_ray: RayCast3D
@export var grapple_ray: RayCast3D
@export var player: CharacterBody3D

var previous_hover : Interactable

func _init() -> void:
	ActionName = "Interact_Action"

func start_action() -> void:
	super.start_action()
	try_interact()

func try_interact():
	if interact_ray.is_colliding():
		var interactable = interact_ray.get_collider() as Interactable
		if interactable:
			interactable.interact()
			print('interact success')
		else:
			print('fail')

func _process(delta):
	try_hover_interact()

func try_hover_interact():
	if grapple_ray.is_colliding():
		var interactable = grapple_ray.get_collider() as GrapplePoint
		if interactable:
			interactable.hover_interact()
			previous_hover = interactable
			return
		elif previous_hover:
			previous_hover.lose_hover()
			previous_hover = null


	if interact_ray.is_colliding():
		var interactable = interact_ray.get_collider() as Interactable
		if interactable:
			interactable.hover_interact()
			previous_hover = interactable
		elif previous_hover:
			previous_hover.lose_hover()
			previous_hover = null
	elif previous_hover:
		previous_hover.lose_hover()
		previous_hover = null
	
