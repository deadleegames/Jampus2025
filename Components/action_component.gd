extends Node
class_name ActionComponent
var Actions : Array[Action]

var ActiveActionTags : Array[String]

func _ready() -> void:
	for child in get_children():
		Actions.append(child as Action)

func start_action_by_name(action_name: String):
	for action in Actions:
		if action.ActionName == action_name:
			action.start_action()
			ActiveActionTags.append(action_name)

func stop_action_by_name(action_name: String):
	for action in Actions:
		if action.ActionName == action_name:
			action.stop_action()
			ActiveActionTags.erase(action_name)
