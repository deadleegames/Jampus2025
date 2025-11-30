extends Node

var KeyItemsCollected : int = 0
var TotalLevelKeyItems: int = 3

func reset():
	KeyItemsCollected = 0
	get_tree().reload_current_scene()

func add_key_item():
	KeyItemsCollected += 1
	check_win_condition()
	print('keyitems: ' + str(KeyItemsCollected))

func check_win_condition():
	if KeyItemsCollected == TotalLevelKeyItems:
		var main = get_tree().get_first_node_in_group('main')
		main.game_win()
