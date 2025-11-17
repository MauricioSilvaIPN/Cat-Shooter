extends States

@onready var enemie_inst = get_parent().get_parent()

func enter_state() -> void:
	enemie_inst.anim.play("Prepare")


func spawn_minions() -> void:
	var new_minions = enemie_inst.minions_inst.instantiate()
	new_minions.global_position = enemie_inst.position_shoot.global_position
	get_parent().get_parent().get_parent().get_parent().get_node("EnemieContainer").add_child(new_minions)


func update_state(delta) -> void:
	if enemie_inst.life <= 0:
		get_parent().change_state("Death")

	if enemie_inst.can_minions == false:
		get_parent().change_state("Walk")

	if enemie_inst.life <= 25:
		get_parent().change_state("Rage")


func exit_state() -> void:
	pass


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Prepare":
		enemie_inst.can_minions = false
