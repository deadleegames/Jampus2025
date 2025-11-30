extends Node3D

@onready var main_menu_ui: Control = $Menus/MainMenu
@onready var game_over_ui: Control = $Menus/GameOver
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func game_over():
	hide_all()
	game_over_ui.visible = true
	CheckMenu.change_menu_context(true)

func restart_game():
	hide_all()
	GameState.reset()
	main_menu_ui.visible = true
	CheckMenu.change_menu_context(true)

func hide_all():
	main_menu_ui.visible = false
	game_over_ui.visible = false
