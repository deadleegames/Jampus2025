extends Node

class_name Interactable

func hover_interact():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.interact_container.visible = true

func lose_hover():
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.interact_container.hide()

func interact():
	pass