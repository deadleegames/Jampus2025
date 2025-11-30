extends Control

func _on_start_btn_pressed():
	CheckMenu.change_menu_context(false)
	visible = false

func _on_quit_btn_pressed():
	get_tree().quit()
