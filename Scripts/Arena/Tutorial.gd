extends Node2D


@onready var dialogue_history = $DialogueBox/TextContainer2/TextLabel
@export var scene_type : String

var dialogue = ["Eaí camarada",
"Está pronto para essa aventura?",
"Irei te ensinar os macetes!",
"Aperte WASD ou as setas do teclado para mover-se",
"Para atirar pressione espaço ou shift",
"Ai vem uns inimigos, boa sorte"]


func _ready() -> void:
	show_characters()
	show_dialogue()

	Songs.current_scene = self

	Songs.PlaySong()

	$Enemies.set_physics_process(false)
	$Wool.set_physics_process(false)
	$Vacuum.set_physics_process(false)
	
	$HUD/GameOver.visible = false
	dialogue_history.text = dialogue[0]



func _physics_process(delta: float) -> void:
	$ParallaxBackground/Estrelas.motion_offset.x -= 1.0
	$ParallaxBackground/Meteoros.motion_offset.x -= 1.14

	$HUD/ProgressBar.value = $Player.life


func show_characters() -> void:
	dialogue_history.visible_ratio = 0
	while dialogue_history.visible_ratio < 1:
		$LetterFX.play()
		await get_tree().create_timer(0.05).timeout
		dialogue_history.visible_characters += 1


func enable_enemies() -> void:
	$Vacuum.set_physics_process(true)
	await get_tree().create_timer(10.0).timeout
	$Wool.set_physics_process(true)
	await get_tree().create_timer(5.5).timeout
	$Enemies.set_physics_process(true)



func show_dialogue() -> void:
	await get_tree().create_timer(2.0).timeout
	dialogue_history.text = dialogue[1]
	show_characters()
	
	await get_tree().create_timer(3.0).timeout
	dialogue_history.text = dialogue[2]
	show_characters()

	await get_tree().create_timer(3.0).timeout
	dialogue_history.text = dialogue[3]
	show_characters()

	await get_tree().create_timer(4.5).timeout
	dialogue_history.text = dialogue[4]
	show_characters()
	
	await get_tree().create_timer(4.0).timeout
	dialogue_history.text = dialogue[5]
	show_characters()
	
	await get_tree().create_timer(4.0).timeout
	$DialogueBox.visible = false
	enable_enemies()


func _on_enemie_detector_body_entered(body: Node2D) -> void:
	if body:
		body.queue_free()


func _on_player_player_death() -> void:
	$HUD.game_over()


func _on_colisor_body_entered(body: Node2D) -> void:
	if body.enemie_type == "Default" or body.enemie_type == "Boss":
		body.speed = 0

	if body.enemie_type == "Boss":
		body.can_walk = false


func _on_enemies_last_enemie() -> void:
	$Boa.visible = true
	await get_tree().create_timer(1.5).timeout
	Fade.change_scene("res://Scenes/UI and more/UI.tscn")
