extends Control

func _on_start_btn_pressed():
	var main = get_tree().get_first_node_in_group('main')
	main.start_game()

func _on_quit_btn_pressed():
	get_tree().quit()
