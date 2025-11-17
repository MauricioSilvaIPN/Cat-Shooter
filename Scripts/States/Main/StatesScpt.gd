class_name States
extends Node2D

var default_state = null


func change_state(state_name) -> void:
	if default_state:
		default_state.exit_state()

	default_state = get_node(state_name)
	default_state.enter_state()


func update_state(delta) -> void:
	if default_state:
		default_state.update_state(delta)
