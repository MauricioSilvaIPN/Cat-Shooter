extends States

@onready var enemie_inst = get_parent().get_parent()
@onready var time_to_shoot = get_parent().get_parent().get_node("TimeToShoot")


func enter_state() -> void:
	enemie_inst.anim.play("Shoot")


func shooting() -> void:
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
	
	if enemie_inst.can_shoot == false:
		get_parent().change_state("Idle")

	if enemie_inst.life <= 25:
		get_parent().change_state("Rage")


func exit_state() -> void:
	pass


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Shoot":
		enemie_inst.can_shoot = false
