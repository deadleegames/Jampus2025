extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	visible = false

func fade_to_black():
	animation_player.play('FadeToBlack')

func on_fade_finish():
	var main = get_tree().get_first_node_in_group('main')
	main.fade_finish()
