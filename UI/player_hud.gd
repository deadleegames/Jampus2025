extends Control

@onready var subtitles_label: Label = $Interact_Container/SubtitlesLabel
@onready var interact_label: Label = $Interact_Container/InteractLabel
@onready var dialog_animation_player: AnimationPlayer = $DialogAnimationPlayer

@onready var tome_check_box: CheckBox = $VBoxContainer2/CheckBox
@onready var jar_check_box_2: CheckBox = $VBoxContainer2/CheckBox2
@onready var siphon_check_box_3: CheckBox = $VBoxContainer2/CheckBox3
@onready var escape_check_box_4: CheckBox = $VBoxContainer2/CheckBox4

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
	escape_check_box_4.hide()

func stop_dialog():
	dialog_animation_player.stop()
	subtitles_label.text = ''
	$DialogPlayer.stop()

func update_checklist(tag: String):
	match tag:
		'souljar':
			jar_check_box_2.button_pressed = true
		'tome':
			tome_check_box.button_pressed = true
		'siphon':
			siphon_check_box_3.button_pressed = true

	if jar_check_box_2.button_pressed and tome_check_box.button_pressed and siphon_check_box_3.button_pressed:
		jar_check_box_2.hide()
		tome_check_box.hide()
		siphon_check_box_3.hide()
		escape_check_box_4.visible = true

func dialog_finished():
	var main = get_tree().get_first_node_in_group('main')
	subtitles_label.text = ''
	main.dialog_finish()