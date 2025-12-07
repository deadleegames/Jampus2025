extends Control

@onready var subtitles_label: Label = $Interact_Container/SubtitlesLabel
@onready var interact_label: Label = $Interact_Container/InteractLabel
@onready var dialog_animation_player: AnimationPlayer = $DialogAnimationPlayer


@onready var objective_box: VBoxContainer = $VBoxContainer2

func set_interact_text(text: String):
	interact_label.text = text

func reset():
	for child in objective_box.get_children():
		child.hide()

	subtitles_label.hide()

func show_objective():
	for child in objective_box.get_children():
		child.visible = true

func stop_dialog():
	dialog_animation_player.stop()
	subtitles_label.text = ''
	$DialogPlayer.stop()