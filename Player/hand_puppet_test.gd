extends Node3D

signal yank_player()

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func yank():
	yank_player.emit()