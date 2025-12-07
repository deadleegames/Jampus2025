extends Interactable

class_name GrapplePoint

func hover_interact():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.set_interact_text(str('Press F'))

func lose_hover():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.set_interact_text('')