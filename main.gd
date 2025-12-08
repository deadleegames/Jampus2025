extends Node3D

const ZERO_VOLUME = -40

var is_on_main_menu : bool = true

@onready var main_menu_ui: Control = $Menus/MainMenu
@onready var game_over_ui: Control = $Menus/GameOver
@onready var game_win_ui: Control = $Menus/GameWin
@onready var player_hud: Control = $Menus/PlayerHud
@onready var settings_menu_ui: Control = $Menus/SettingsMenu
@onready var pause_menu_ui: Control = $Menus/PauseMenu
@onready var fade: Control = $Menus/Fade

@onready var teleport_player: Timer = $TeleportPlayer

@onready var music_player: AudioStreamPlayer = $AudioMaster/MusicPlayer
@onready var menu_music: AudioStreamPlayer = $AudioMaster/MenuMusic

var bis_gameover = false

func game_over():
	var p = get_tree().get_first_node_in_group('player') as Player
	p.currentState = MyEnums.PlayerState.DEFAULT
	bis_gameover = true
	get_tree().paused = true
	hide_all()
	game_over_ui.visible = true
	CheckMenu.change_menu_context(true)
	
	var playback1 = music_player.get_stream_playback()
	playback1.stop()
	
	var playback = menu_music.get_stream_playback()
	playback.switch_to_clip_by_name("GameOver")

func game_win():
	hide_all()
	var playback = menu_music.get_stream_playback()
	playback.switch_to_clip_by_name("Default")
	game_win_ui.play_end()
	CheckMenu.change_menu_context(true)

func restart_game():
	fade.fade_to_black()
	var p = get_tree().get_first_node_in_group('player') as Player
	p.currentState = MyEnums.PlayerState.DEFAULT
	bis_gameover = false
	hide_all()
	GameState.reset()
	player_hud.reset()
	main_menu_ui.visible = true
	CheckMenu.change_menu_context(true)
	is_on_main_menu = true

func main_menu():
	restart_game()

func settings():
	hide_all()
	settings_menu_ui.visible = true
	CheckMenu.change_menu_context(true)

func update_checklist(tag: String):
	player_hud.update_checklist(tag)

func pause():	
	if not is_on_main_menu:
		hide_all()
		pause_menu_ui.show_menu(player_hud.dialog_animation_player.is_playing())
		CheckMenu.change_menu_context(true)

func play_dialog():
	player_hud.dialog_animation_player.play('intro')

func skip_dialouge():
	player_hud.stop_dialog()
	dialog_finish()
	player_hud.show_objective()

func dialog_finish():
	fade.fade_to_black()
	var player = get_tree().get_first_node_in_group('player')
	player.bprocess_input = false

	teleport_player.start()

func start_game():
	var player = get_tree().get_first_node_in_group('player')
	player.bprocess_input = false

	fade.fade_to_black()
	var playback = menu_music.get_stream_playback()
	playback.switch_to_clip_by_name("End")
	
	hide_all()
	CheckMenu.change_menu_context(false)	
	is_on_main_menu = false

func fade_finish():
	var player = get_tree().get_first_node_in_group('player')
	player.bprocess_input = true
	player_hud.visible = true

func hide_all():
	main_menu_ui.hide()
	game_over_ui.hide()
	game_win_ui.hide()
	player_hud.hide()
	settings_menu_ui.hide()
	pause_menu_ui.hide()

func _process(_delta):
	var p = get_tree().get_first_node_in_group('player') as Player
	
	if p.currentState == MyEnums.PlayerState.IN_CHASE and !bis_gameover:
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


func _on_dialog_player_finished() -> void:
	# var player = get_tree().get_first_node_in_group('player')
	# var player_start = get_tree().get_first_node_in_group('player_start')
	# player.global_posistion = player_start.global_posistion
	pass


func _on_teleport_player_timeout() -> void:
	teleport_player.stop()
	var player = get_tree().get_first_node_in_group('player')
	var player_start = get_tree().get_first_node_in_group('player_start')
	player.global_transform  = player_start.transform