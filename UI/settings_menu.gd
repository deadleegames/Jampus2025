extends Control

@onready var master_scroll_bar: HScrollBar = $VBoxContainer/HBoxContainer/MasterScrollBar
@onready var music_scroll_bar: HScrollBar = $VBoxContainer/HBoxContainer2/MusicScrollBar
@onready var effects_scroll_bar: HScrollBar = $VBoxContainer/HBoxContainer3/EffectsScrollBar

func _ready():
	var music_idx = AudioServer.get_bus_index('Music')
	music_scroll_bar.value = AudioServer.get_bus_volume_db(music_idx)

	var master_idx = AudioServer.get_bus_index('Master')
	master_scroll_bar.value = AudioServer.get_bus_volume_db(master_idx)

	var effects_idx = AudioServer.get_bus_index('Effects')
	effects_scroll_bar.value = AudioServer.get_bus_volume_db(effects_idx)

func _on_back_btn_pressed() -> void:
	var main = get_tree().get_first_node_in_group('main')
	main.main_menu()

func _on_music_scroll_bar_value_changed(value: float) -> void:
	var music_idx = AudioServer.get_bus_index('Music')
	AudioServer.set_bus_volume_db(music_idx, -value)

func _on_effects_scroll_bar_value_changed(value: float) -> void:
	var effects_idx = AudioServer.get_bus_index('Effects')
	AudioServer.set_bus_volume_db(effects_idx, -value)

func _on_master_scroll_bar_value_changed(value: float) -> void:
	var master_idx = AudioServer.get_bus_index('Master')
	AudioServer.set_bus_volume_db(master_idx, -value)

