extends Node2D

@export var enemie_intan : Array[PackedScene]
@export var vacuum_inst : PackedScene
@export var scene_type : String

@onready var mob_spawn_location = $MobPath/MobSpawn


func _ready() -> void:
	get_tree().call_group("Bullets", "queue_free")
	difficult_setting()

	Songs.current_scene = self

	Songs.PlaySong()

	$EnemieContainer/Boss.set_physics_process(false)
	$HUD/GameOver.visible = false
	
	$Timer.start()
	$BossTimer.start()


func _physics_process(delta: float) -> void:
	$ParallaxBackground/Estrelas.motion_offset.x -= 1.0
	$ParallaxBackground/Meteoros.motion_offset.x -= 1.14

	$HUD/ProgressBar.value = $Player.life
	$BossLife.value = $EnemieContainer/Boss.life


func _on_colisor_body_entered(body: Node2D) -> void:
	if body.enemie_type == "Default" or body.enemie_type == "Boss":
		body.speed = 0

	if body.enemie_type == "Boss":
		body.can_walk = false


func _on_timer_timeout() -> void:
	spawn_basic_enemies()
	spawn_vacuum()


func spawn_vacuum() -> void:
	var new_vacuum = vacuum_inst.instantiate()
	new_vacuum.global_position = Vector2(400, -50)
	get_node("EnemieContainer").add_child(new_vacuum)


func difficult_setting() -> void:
	if GlobalScpt.difficult == "Easy":
		$Timer.wait_time = 5.0

	if GlobalScpt.difficult == "Normal":
		$Timer.wait_time = 3.5

	if GlobalScpt.difficult == "Hard":
		$Timer.wait_time = 2.0


func spawn_basic_enemies() -> void:
	var enemie_randf = randi() % 2
	var new_enemie

	if enemie_randf == 0:
		new_enemie = enemie_intan[0].instantiate()

	if enemie_randf == 1:
		new_enemie = enemie_intan[1].instantiate()
	
	mob_spawn_location.progress_ratio = randf()
	
	new_enemie.position = mob_spawn_location.position
	
	get_node("EnemieContainer").add_child(new_enemie)


func _on_enemie_detector_body_entered(body: Node2D) -> void:
	if body:
		body.queue_free()


func _on_player_player_death() -> void:
	$HUD.game_over()


func _on_boss_timer_timeout() -> void:
	get_tree().call_group("Bullets", "queue_free")
	get_tree().call_group("Enemies", "queue_free")
	$Timer.stop()
	$BossTimer.stop()
	$BossLife.visible = true
	$EnemieContainer/Boss.set_physics_process(true)


func _on_boss_boss_death() -> void:
	$HUD/Won.visible = true
	$EnemieContainer/Boss.set_physics_process(false)
	await get_tree().create_timer(2.0).timeout
	Fade.change_scene("res://Scenes/UI and more/UI.tscn")
