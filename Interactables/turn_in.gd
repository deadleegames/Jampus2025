extends Interactable

var bcan_interact = false

@onready var puppet_cross: StaticBody3D = $PuppetCross
@onready var spot_light_3d: SpotLight3D = $SpotLight3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	puppet_cross.cross_obtained.connect(on_obtained)

func interact():
	if !bcan_interact:
		return

	super.interact()
	if GameState.has_all_items():
		animation_player.play('Victory')
		return

	var main = get_tree().get_first_node_in_group('main')
	main.play_dialog()

func hover_interact():
	if !bcan_interact:
		return
	
	super.hover_interact()

func on_obtained():
	spot_light_3d.visible = true
	bcan_interact = true

func on_victory_finished():
	var main = get_tree().get_first_node_in_group('main')
	main.game_win()
