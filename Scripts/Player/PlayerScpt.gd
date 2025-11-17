extends CharacterBody2D

@export var speed := 150
@export var life := 5
@export var bullet_scene : PackedScene

@onready var hit_fx = $Hit

var pos := Vector2.ZERO
var can_shoot := true

signal player_death


func _physics_process(delta: float) -> void:
	movement()
	animation()
	shoot()
	death()


func movement() -> void:
	pos.x = 0
	pos.y = 0
	var direction_y = int(Input.is_action_pressed("ui_down")) -int(Input.is_action_pressed("ui_up"))
	var direction_x = int(Input.is_action_pressed("ui_right")) -int(Input.is_action_pressed("ui_left"))

	pos.x = direction_x * speed
	pos.y = direction_y * speed
	set_velocity(pos)
	move_and_slide()
	pos = velocity


func animation() -> void:
	var anim = "Idle"

	if Input.is_action_pressed("ui_up"):
		anim = "Up"

	if Input.is_action_pressed("ui_down"):
		anim = "Down"

	if $Anim.assigned_animation != anim:
		$Anim.play(anim)


func shoot() -> void:
	if Input.is_action_pressed("Shoot") and can_shoot:
		can_shoot = false
		var new_bullet = bullet_scene.instantiate()
		new_bullet.global_position = $Marker2D.global_position
		new_bullet.pos = Vector2(1, 0).normalized() * new_bullet.speed
		get_tree().root.add_child(new_bullet)
		$Laser.play()
		$ShootTimer.start()


func death() -> void:
	if life <= 0:
		emit_signal("player_death")


func show_flash_hit() -> void:
	var new_timer = Timer.new()
	add_child(new_timer)
	new_timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	new_timer.start(0.2)
	
	$Sprite2D.material.set_shader_parameter("flash_range", 0.8)


func _on_timer_timeout() -> void:
	$Sprite2D.material.set_shader_parameter("flash_range", 0.0)


func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	$ShootTimer.stop()


func _on_colisor_body_entered(body: Node2D) -> void:
	if body:
		$Hit.play()
		show_flash_hit()
		life -= 1
