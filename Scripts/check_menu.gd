extends Node

var IsMenuOpen: bool = true

func change_menu_context(is_menu_open: bool):
	IsMenuOpen = is_menu_open

	if	IsMenuOpen:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	set_input_mode_player()

func set_input_mode_player():
	get_tree().paused = IsMenuOpen
