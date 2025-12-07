extends Interactable

func interact():
	super.interact()
	var main = get_tree().get_first_node_in_group('main')
	main.play_dialog()
	var player = get_tree().get_first_node_in_group('player')
	var player_start = get_tree().get_first_node_in_group('player_start')
	player.global_transform  = player_start.transform
