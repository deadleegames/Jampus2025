extends Area3D

func _on_body_entered(body):
	if body.is_in_group('enemy'):
		return

	if body.is_in_group('player'):
		var main = get_tree().get_first_node_in_group('main')
		main.game_over()