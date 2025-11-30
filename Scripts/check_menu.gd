extends Node

var IsMenuOpen: bool = true

func change_menu_context(is_menu_open: bool):
	IsMenuOpen = is_menu_open

	if	IsMenuOpen:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE			
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	var player = get_tree().get_first_node_in_group('player')
	if player != null:
		set_input_mode_player(player)

func set_input_mode_player(player: CharacterBody3D):
	get_tree().paused = IsMenuOpen
