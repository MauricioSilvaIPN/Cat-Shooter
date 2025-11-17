extends CanvasLayer

@onready var current_scene


func PlaySong() -> void:
	if current_scene.scene_type == "Levels" and $GameMusic.playing == false:
		$GameMusic.play()
		$MenuMusic.stop()
	
	if current_scene.scene_type == "UI" and $MenuMusic.playing == false:
		$MenuMusic.play()
		$GameMusic.stop()


func _on_menu_music_finished() -> void:
	$MenuMusic.play()


func _on_game_music_finished() -> void:
	$GameMusic.play()
