extends Area3D

class_name PerceptionComponent

signal player_spotted(instigating_body: CharacterBody3D)

func _on_body_entered(body):
	if body.is_in_group('enemy'):
		return

	if body.is_in_group('player'):
		player_spotted.emit(body as CharacterBody3D)
		# var main = get_tree().get_first_node_in_group('main')
		# main.game_over()
