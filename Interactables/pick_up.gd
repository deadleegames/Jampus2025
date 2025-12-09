extends Interactable

class_name PickUp

@export var collisionshape : CollisionShape3D

func interact():
	super.interact()
	GameState.add_key_item(self)
	collisionshape.set_deferred('disabled', true)
	call_deferred('queue_free')

func lose_hover():
	super.lose_hover()