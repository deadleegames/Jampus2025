extends Control

@onready var default_pause: MarginContainer = $DefaultPause
@onready var dialog_pause: MarginContainer = $DialogPause

func show_menu(is_dialog_playing: bool):
	visible = true
	if is_dialog_playing:
		default_pause.hide()
		dialog_pause.visible = true
	else:
		default_pause.visible = true
		dialog_pause.hide()


func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_return_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.main_menu()

func _on_settings_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.settings()

func _on_skip_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.skip_dialouge()
	hide()
	CheckMenu.change_menu_context(false)
	main.player_hud.visible = true

func _on_continue_btn_pressed():
	hide()
	CheckMenu.change_menu_context(false)
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.visible = true
