extends Control

@export var scene_type : String


func _ready() -> void:
	$Interaction/Play.grab_focus()
	
	Songs.current_scene = self
	
	Songs.PlaySong()


func _physics_process(delta: float) -> void:
	$ParallaxBackground/Estrelas.motion_offset.x -= 1.0
	$ParallaxBackground/Meteoros.motion_offset.x -= 1.14


func _on_play_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/UI and more/Play.tscn")


func _on_credits_pressed() -> void:
	$ButtonFX.play()
	Fade.change_scene("res://Scenes/UI and more/Credits.tscn")


func _on_tutorial_pressed() -> void:
	$ButtonFX.play()
	GlobalScpt.difficult = "Nothing"
	Fade.change_scene("res://Scenes/Main/Tutorial.tscn")
