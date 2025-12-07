extends Area3D

class_name PickUp

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group('player'):
		GameState.add_key_item()
		queue_free()
