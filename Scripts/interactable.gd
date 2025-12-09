extends Node

class_name Interactable

func hover_interact():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.set_interact_text('Press E')

func lose_hover():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.set_interact_text('')

func interact():
	pass

static func reset_hover():
	var main_loop = Engine.get_main_loop()
	if main_loop is SceneTree:
		main_loop.get_first_node_in_group('main').player_hud.set_interact_text('')
	return null
	
