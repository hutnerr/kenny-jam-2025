extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

# This is like the _ready() function, except I want to pass the "parent" as a reference. 
func custom_init(parent)-> void:
	for child in get_children():
		if child is State:
			child.parent = parent
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
func change_state(state, new_state_name):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()

	current_state = new_state

func on_child_transition(state, new_state_name):
	change_state(state, new_state_name)
