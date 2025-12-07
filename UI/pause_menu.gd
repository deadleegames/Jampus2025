extends Control

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_return_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.main_menu()

func _on_settings_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.settings()

func _on_continue_btn_pressed():
	hide()
	CheckMenu.change_menu_context(false)
	var main = get_tree().get_first_node_in_group('main')
	main.player_hud.visible = true
