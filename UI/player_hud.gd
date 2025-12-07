extends Control

@onready var subtitles_label: Label = $Interact_Container/SubtitlesLabel
@onready var interact_label: Label = $Interact_Container/InteractLabel

func set_interact_text(text: String):
	interact_label.text = text