extends States

@onready var enemie_inst = get_parent().get_parent()
@onready var wait_timer = get_parent().get_parent().get_node("WaitTimer")


func enter_state() -> void:
	if enemie_inst.enemie_type == "Triple":
		enemie_inst.speed = 150
		wait_timer.start()


func movement() -> void:
	if enemie_inst.enemie_type != "Triple":
		enemie_inst.pos.x = enemie_inst.speed
		enemie_inst.set_velocity(enemie_inst.pos)
		enemie_inst.move_and_slide()
		enemie_inst.pos = enemie_inst.velocity
	else:
		enemie_inst.pos.y = enemie_inst.speed
		enemie_inst.set_velocity(enemie_inst.pos)
		enemie_inst.move_and_slide()
		enemie_inst.pos = enemie_inst.velocity


func update_state(delta) -> void:
	movement()
	
	enemie_inst.anim.play("Idle")

	if enemie_inst.speed == 0 and enemie_inst.enemie_type != "Walker":
		get_parent().change_state("Shoot")
	
	if enemie_inst.life <= 0:
		get_parent().change_state("Death")


func exit_state() -> void:
	pass


func _on_wait_timer_timeout() -> void:
	enemie_inst.speed = 0
