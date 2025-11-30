extends Node

var IsMenuOpen: bool = true

func _ready():
	change_menu_context(true)

func change_menu_context(is_menu_open: bool):
	IsMenuOpen = is_menu_open
	if	IsMenuOpen:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
