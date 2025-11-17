extends States

@onready var enemie_inst = get_parent().get_parent()


func enter_state() -> void:
	pass


func movement() -> void:
	enemie_inst.pos.x = enemie_inst.speed
	enemie_inst.set_velocity(enemie_inst.pos)
	enemie_inst.move_and_slide()
	enemie_inst.pos = enemie_inst.velocity



func update_state(delta) -> void:
	movement()
	
	enemie_inst.anim.play("Idle")

	if enemie_inst.can_walk == false:
		get_parent().change_state("Idle")

	if enemie_inst.life <= 25:
		get_parent().change_state("Rage")


func exit_state() -> void:
	pass
