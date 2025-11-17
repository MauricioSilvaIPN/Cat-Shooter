extends CanvasLayer


var scene = ""

func _ready() -> void:
	$BG.position.x = -1032


func transition() -> void:
	get_tree().change_scene_to_file(scene)


func change_scene(new_scene : String) -> void:
	scene = new_scene
	$Anim.play("Fade")
