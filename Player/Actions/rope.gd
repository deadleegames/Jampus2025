extends Node3D

var start_pos : Vector3
var end_pos : Vector3
var bis_spawned : bool = false


var last_global_pos: Vector3

func setup(startpos : Vector3, endpos : Vector3):
	start_pos = startpos
	end_pos = endpos
	bis_spawned = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bis_spawned:		
		#get length
		var scale_vec = basis.get_scale()
		var rope_length = scale_vec.z

		var distance = abs(start_pos) - abs(end_pos)
		#calculate how many objs we need to spawn
		var amount = round(distance.z / rope_length)

		#loop and spawn objs while attaching to joints
		for i in range(amount):
			create_objs(rope_length)

		
		
		#delete after timer?

func create_objs(length: float):
	var joint = PinJoint3D.new()
	