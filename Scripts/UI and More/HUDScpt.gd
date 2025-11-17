extends CanvasLayer


func game_over() -> void:
	$Anim.play("GameOver")
	$BG.visible = true
	$GameOver.visible = true
	await get_tree().create_timer(1.0).timeout
	Fade.change_scene("res://Scenes/UI and more/UI.tscn")
