extends Area3D

class_name PerceptionComponent

signal on_suspicion(instigating_body: CharacterBody3D)
signal clear_suspicion(instigating_body: CharacterBody3D)
signal player_spotted(instigating_body: CharacterBody3D)

@onready var ray: RayCast3D = $RayCast3D
@onready var suspicion_timer: Timer = $SuspicionTimer
var bis_suspicous = false

func _on_body_entered(body):
	if !body.is_in_group('player'):
		return

	on_suspicion.emit(body)
	bis_suspicous = true
	suspicion_timer.start()
	print('sus')


func _process(delta):
	if ray.is_colliding() and bis_suspicous:
		var collider = ray.get_collider() as CharacterBody3D
		if collider:
			player_spotted.emit(collider)
			bis_suspicous = false
			print('chase!')


func _on_suspicion_timer_timeout() -> void:
		suspicion_timer.stop()
		bis_suspicous = false
		clear_suspicion.emit()
		print('clear')
