extends Interactable

signal cross_obtained()

@onready var timer: Timer = $Timer

func interact():
	var player = get_tree().get_first_node_in_group('player')
	player.hand_puppet.visible = true
	player.hand_puppet.animation_player.play('Tool_Deploy')
	cross_obtained.emit()
	timer.start()
	self.visible = false

func _on_timer_timeout() -> void:
	timer.stop()
	queue_free()

