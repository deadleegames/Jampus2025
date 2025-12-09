extends Node

signal on_all_items()

var KeyItemsCollected : int = 0
var TotalLevelKeyItems: int = 3

func reset():
	KeyItemsCollected = 0
	get_tree().reload_current_scene()

func add_key_item(item: PickUp):
	KeyItemsCollected += 1
	print('keys' + str(KeyItemsCollected))
	#check_win_condition()
	var main = get_tree().get_first_node_in_group('main')
	var tag = ''
	if item.is_in_group('tome'):
		tag = 'tome'
	elif item.is_in_group('souljar'):
		tag = 'souljar'
	elif item.is_in_group('siphon'):
		tag = 'siphon'
	else:
		print('item no assigned to group')

	main.update_checklist(tag)
	check_win_condition()

func check_win_condition():
	if KeyItemsCollected == TotalLevelKeyItems:
		# var main = get_tree().get_first_node_in_group('main')
		# main.game_win()
		var escape_trigger = get_tree().get_first_node_in_group('escape')
		escape_trigger.enable()
		on_all_items.emit()

func has_all_items() -> bool:
	return KeyItemsCollected == TotalLevelKeyItems