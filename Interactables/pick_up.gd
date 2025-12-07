extends Interactable

class_name PickUp

func interact():
	super.interact()
	GameState.add_key_item()
	queue_free()
