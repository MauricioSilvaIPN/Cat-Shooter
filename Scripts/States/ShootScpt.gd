extends States

@onready var enemie_inst = get_parent().get_parent()
@onready var shoot_timer = get_parent().get_parent().get_node("ShootTimer")
@onready var wait_timer = get_parent().get_parent().get_node("WaitTimer")


func enter_state() -> void:
	if enemie_inst.enemie_type == "Triple":
		enemie_inst.can_walk = false
		enemie_inst.anim.play("Shoot")

	shoot_timer.start()
	wait_timer.stop()


func shooting() -> void:
	if enemie_inst.enemie_type != "Triple":
		enemie_inst.laser_fx.play()
		var new_bullet = enemie_inst.bullet_insta.instantiate()
		new_bullet.global_position = enemie_inst.position_shoot.global_position
		new_bullet.pos = Vector2(1, 0).normalized() * new_bullet.speed
		get_tree().root.add_child(new_bullet)

	if enemie_inst.enemie_type == "Triple":
		enemie_inst.laser_fx.play()
		#tiro1
		var new_bullet = enemie_inst.bullet_insta.instantiate()
		new_bullet.global_position = enemie_inst.position_shoot.global_position
		new_bullet.pos = Vector2(1, 0).normalized() * new_bullet.speed
		get_tree().root.add_child(new_bullet)

		#tiro2
		var new_bullet2 = enemie_inst.bullet_insta.instantiate()
		new_bullet2.global_position = enemie_inst.position_shoot.global_position
		new_bullet2.pos = Vector2(1, 1).normalized() * new_bullet2.speed
		get_tree().root.add_child(new_bullet2)

		#tiro3
		var new_bullet3 = enemie_inst.bullet_insta.instantiate()
		new_bullet3.global_position = enemie_inst.position_shoot.global_position
		new_bullet3.pos = Vector2(1, -1).normalized() * new_bullet3.speed
		get_tree().root.add_child(new_bullet3)


func update_state(delta) -> void:
	if enemie_inst.life <= 0:
		get_parent().change_state("Death")
	
	if enemie_inst.enemie_type == "Triple" and enemie_inst.can_walk == true:
		get_parent().change_state("Walk")


func exit_state() -> void:
	pass


func _on_shoot_timer_timeout() -> void:
	if enemie_inst.enemie_type != "Triple":
		shooting()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Shoot" and enemie_inst.enemie_type == "Triple":
		enemie_inst.can_walk = true
