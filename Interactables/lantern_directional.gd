extends Lantern
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is Projectile:
		break_lantern()
		audio_stream_player_3d.play()
		body.queue_free_timer()
