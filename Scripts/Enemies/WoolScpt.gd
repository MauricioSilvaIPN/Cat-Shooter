extends Enemies


func _ready() -> void:
	state = $States.change_state("Walk")

	if GlobalScpt.difficult == "Easy":
		speed = -150

	if GlobalScpt.difficult == "Normal":
		speed = -250

	if GlobalScpt.difficult == "Hard":
		speed = -350


func _on_detector_body_entered(body: Node2D) -> void:
	if body:
		life -= 1
