extends States

@onready var enemie_inst = get_parent().get_parent()


func enter_state() -> void:
	pass


func death() -> void:
	if enemie_inst.life <= 0 and enemie_inst.enemie_type != "Boss":
		enemie_inst.explosion_fx.play()
		enemie_inst.emit_signal("last_enemie")
		var new_particles = enemie_inst.particles_inst.instantiate()
		new_particles.position = enemie_inst.global_position
		new_particles.emitting = true
		get_tree().current_scene.add_child(new_particles)
		
		enemie_inst.queue_free()

	if enemie_inst.life <= 0 and enemie_inst.enemie_type == "Boss":
		enemie_inst.explosion_fx.play()
		enemie_inst.emit_signal("boss_death")
		enemie_inst.collision.disabled = true
		enemie_inst.anim.play("Idle")
		var new_particles = enemie_inst.particles_inst.instantiate()
		new_particles.position = enemie_inst.global_position
		new_particles.emitting = true
		get_tree().current_scene.add_child(new_particles)
		enemie_inst.set_physics_process(false)
		enemie_inst.hide()


func update_state(delta) -> void:
	death()


func exit_state() -> void:
	pass
