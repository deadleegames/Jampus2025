extends Node

class_name Action

var ActionName : String
var bIsRunning : bool

var BlockedTags : Array[String]
var GrantTags : Array[String]

var TimeStart: float

func start_action() -> void:
	TimeStart = Time.get_unix_time_from_system()
	bIsRunning = true

func stop_action() -> void:
	bIsRunning = false

func can_start() -> bool:
	if bIsRunning:
		return false

	var action_comp = get_parent() as ActionComponent
	if action_comp.ActiveActionTags.any(BlockedTags):
		return false

	return true