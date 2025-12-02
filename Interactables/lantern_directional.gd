extends Lantern

func _on_hit_box_body_entered(body: Node3D) -> void:
	if body is Projectile:
		break_lantern()
		body.queue_free_timer()
