extends Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func do_patrol(delta: float):
	super.do_patrol(delta)
	animation_player.speed_scale = .75
	animation_player.play('Walk_Forward')

func do_chase(delta: float):
	super.do_chase(delta)

	animation_player.speed_scale = 1.5