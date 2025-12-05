extends AudioStreamPlayer3D

@export var audio3dbreathing: AudioStreamPlayer3D

func _ready() -> void:
	var enemy = get_parent() as Enemy
	enemy.on_state_changed.connect(update_sfx)


func update_sfx(state: MyEnums.AIState):
	var playback: AudioStreamPlaybackInteractive = get_stream_playback()
	var breath_playback: AudioStreamPlaybackInteractive = audio3dbreathing.get_stream_playback()
	match state:
		MyEnums.AIState.IDLE:
			playback.switch_to_clip_by_name("Idle")
			breath_playback.switch_to_clip_by_name("Near")
		MyEnums.AIState.CHASE:
			playback.switch_to_clip_by_name("Spotted")
			breath_playback.switch_to_clip_by_name("Running")
		MyEnums.AIState.PATROL:
			playback.switch_to_clip_by_name("Idle")
			breath_playback.switch_to_clip_by_name("Near")
