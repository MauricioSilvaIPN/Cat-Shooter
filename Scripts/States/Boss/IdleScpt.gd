extends States

@onready var enemie_inst = get_parent().get_parent()


func enter_state() -> void:
	enemie_inst.anim.play("Idle")
	
	if enemie_inst.time_to_shoot.is_stopped() and enemie_inst.time_to_minions.is_stopped():
		enemie_inst.time_to_shoot.start()
		enemie_inst.time_to_minions.start()


func update_state(delta) -> void:
	enemie_inst.speed = 0

	if enemie_inst.life <= 0:
		get_parent().change_state("Death")
	
	if enemie_inst.can_minions == true:
		get_parent().change_state("Prepare")
	
	if enemie_inst.can_shoot == true:
		get_parent().change_state("Shoot")
	
	if enemie_inst.life <= 25:
		get_parent().change_state("Rage")


func exit_state() -> void:
	pass


func _on_time_to_shoot_timeout() -> void:
	enemie_inst.can_shoot = true


func _on_time_to_minions_timeout() -> void:
	enemie_inst.can_minions = true
