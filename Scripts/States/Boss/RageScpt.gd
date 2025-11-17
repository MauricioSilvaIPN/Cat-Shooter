extends States

@onready var enemie_inst = get_parent().get_parent()
@onready var monster_position = get_parent().get_parent().get_node("MonstersSpawn")


func enter_state() -> void:
	enemie_inst.anim.play("Rage")


func spawn_minions() -> void:
	if GlobalScpt.difficult == "Hard":
		var new_minions = enemie_inst.minions_inst.instantiate()
		new_minions.global_position = monster_position.global_position
		get_parent().get_parent().get_parent().get_parent().get_node("EnemieContainer").add_child(new_minions)
		monster_position.position.y *= -1


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


func exit_state() -> void:
	pass
