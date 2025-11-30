extends Node

var IsMenuOpen: bool = true

func _ready():
	change_menu_context(true)

func change_menu_context(is_menu_open: bool):
	IsMenuOpen = is_menu_open
	if	IsMenuOpen:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		var player = get_tree().get_first_node_in_group('player')
		player.set_process_input(false)
		player.set_process_unhandled_input(false)
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		var player = get_tree().get_first_node_in_group('player')
		player.set_process_input(true)
		player.set_process_unhandled_input(true)
