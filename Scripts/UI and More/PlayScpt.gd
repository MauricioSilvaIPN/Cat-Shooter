extends Control

@export var scene_type : String


func _ready() -> void:
	$Easy.grab_focus()

	Songs.current_scene = self

	Songs.PlaySong()


func _physics_process(delta: float) -> void:
	$ParallaxBackground/Estrelas.motion_offset.x -= 1.0
	$ParallaxBackground/Meteoros.motion_offset.x -= 1.14


func _on_easy_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/Main/Main.tscn")
	GlobalScpt.difficult = "Easy"


func _on_medium_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/Main/Main.tscn")
	GlobalScpt.difficult = "Normal"


func _on_hard_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/Main/Main.tscn")
	GlobalScpt.difficult = "Hard"


func _on_back_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/UI and more/UI.tscn")
