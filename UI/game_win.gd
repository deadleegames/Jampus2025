extends Control

func _on_return_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.restart_game()
