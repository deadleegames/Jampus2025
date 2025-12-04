extends Node3D

@onready var main_menu_ui: Control = $Menus/MainMenu
@onready var game_over_ui: Control = $Menus/GameOver
@onready var game_win_ui: Control = $Menus/GameWin
@onready var player_hud: Control = $Menus/PlayerHud

@onready var music_player: AudioStreamPlayer = $AudioMaster/MusicPlayer

func game_over():
	hide_all()
	game_over_ui.visible = true
	CheckMenu.change_menu_context(true)

func game_win():
	hide_all()
	game_win_ui.visible = true
	CheckMenu.change_menu_context(true)

func restart_game():
	hide_all()
	GameState.reset()
	main_menu_ui.visible = true
	CheckMenu.change_menu_context(true)

func start_game():
	var playback = music_player.get_stream_playback()
	playback.switch_to_clip_by_name("End")
	hide_all()
	CheckMenu.change_menu_context(false)
	player_hud.visible = true
	

func hide_all():
	main_menu_ui.visible = false
	game_over_ui.visible = false
	game_win_ui.visible = false
	player_hud.visible = false
