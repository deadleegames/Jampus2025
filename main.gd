extends Node3D

const ZERO_VOLUME = -40

var is_on_main_menu : bool = true

@onready var main_menu_ui: Control = $Menus/MainMenu
@onready var game_over_ui: Control = $Menus/GameOver
@onready var game_win_ui: Control = $Menus/GameWin
@onready var player_hud: Control = $Menus/PlayerHud
@onready var settings_menu_ui: Control = $Menus/SettingsMenu
@onready var pause_menu_ui: Control = $Menus/PauseMenu

@onready var music_player: AudioStreamPlayer = $AudioMaster/MusicPlayer
@onready var menu_music: AudioStreamPlayer = $AudioMaster/MenuMusic

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
	is_on_main_menu = true

func main_menu():
	hide_all()
	main_menu_ui.visible = true
	CheckMenu.change_menu_context(true)
	is_on_main_menu = true

func settings():
	hide_all()
	settings_menu_ui.visible = true
	CheckMenu.change_menu_context(true)

func pause():
	if not is_on_main_menu:
		hide_all()
		pause_menu_ui.visible = true
		CheckMenu.change_menu_context(true)

func start_game():
	var playback = menu_music.get_stream_playback()
	playback.switch_to_clip_by_name("End")
	hide_all()
	CheckMenu.change_menu_context(false)
	player_hud.visible = true
	is_on_main_menu = false

func hide_all():
	main_menu_ui.hide()
	game_over_ui.hide()
	game_win_ui.hide()
	player_hud.hide()
	settings_menu_ui.hide()
	pause_menu_ui.hide()

func _process(_delta):
	var p = get_tree().get_first_node_in_group('player') as Player
	
	if p.currentState == MyEnums.PlayerState.IN_CHASE:
		if !music_player.playing:
			music_player.play()

		#TODO need to check enemy distance
		var e : Enemy
		for enemy : Enemy in get_tree().get_nodes_in_group('enemy'):
			if enemy and enemy.currentState == MyEnums.AIState.CHASE:
				e = enemy

		if e == null:
			return
		
		var distance = p.global_position - e.global_position
		
		var my_x = distance.x
		if my_x < 0:
			my_x = -1 * my_x

		var my_z = distance.z
		if my_z < 0:
			my_z = -1 * my_z

		var l = (my_x + my_z) * 2

		var stream_sync = music_player.stream as AudioStreamSynchronized

		var u = clamp(l * -1, ZERO_VOLUME, 0)
		#print('near ' + str(u))
		stream_sync.set_sync_stream_volume(0, u)

		#var t = min(ZERO_VOLUME + l *(-ZERO_VOLUME), 0.0)
		var t = clamp(l + ZERO_VOLUME, ZERO_VOLUME, 0)
		#print('far ' + str(t))
		stream_sync.set_sync_stream_volume(1, ZERO_VOLUME)
		stream_sync.set_sync_stream_volume(2, t)
		

func _on_pause_menu_visibility_changed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	else:
		get_tree().paused = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		pause()